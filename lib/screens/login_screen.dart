import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home.dart';
import 'signup_screen.dart';
import 'package:register_covid19app/home.dart';
import '../models/authentication.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formkey = GlobalKey();

  Map<String, String> _authData = {
    'email' : '',
    'password' : ''
  };

  void _showErrorDialog(String msg)
  {
    showDialog(
        context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occured!'),
        content: Text(msg),
        actions: <Widget>[
          FlatButton(
              onPressed: (){
                Navigator.of(ctx).pop();
              },
              child: Text('Okay')
          )
        ],
      )
    );
  }

  Future<void> _submit() async
  {
    if(!_formkey.currentState.validate())
      {
        return;
      }
    _formkey.currentState.save();

    try{
      await Provider.of<Authentication>(context, listen: false).logIn(
          _authData['email'],
          _authData['password']
      );
      Navigator.of(context).pushReplacementNamed(Home.routeName);

    } catch (error)
    {
      var errorMessage = 'Authentication Failed! Please try again later.';
      _showErrorDialog(errorMessage);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        actions: <Widget>[
          FlatButton(
              child: Row(
                children: <Widget>[
                  Text('Sign Up'),
                  Icon(Icons.person_add)
                ],
              ),
            textColor: Colors.white,
            onPressed: ()
            {
              Navigator.of(context).pushReplacementNamed(SignupScreen.routeName);
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.lightBlueAccent,
                  Colors.blue,
                ]
              )
            ),
          ),
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                height: 260,
                width: 300,
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formkey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        //email
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value)
                          {
                            if(value.isEmpty || !value.contains('@'))
                              {
                                return 'Invalid Email!';
                              }
                            return null;
                          },
                          onSaved: (value)
                          {
                              _authData['email'] = value;
                          },
                        ),

                        //password
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          validator: (value)
                          {
                            if(value.isEmpty || value.length <= 5)
                              {
                                return 'invalid password';
                              }
                            return null;
                          },
                          onSaved: (value)
                          {
                            _authData['password'] = value;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        RaisedButton(
                            child: Text(
                              'Submit'
                            ),
                          onPressed: ()
                          {
                              _submit();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: Colors.blue,
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
