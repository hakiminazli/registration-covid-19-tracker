import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:register_covid19app/CONSTANTS.dart';
import 'package:register_covid19app/screens/main_page.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
  static const routeName = '/home';
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    MainPage(), // combined with PowerPage()
    UserPage(),
    PowerPage(), // combined code into one main_page.dart
    SettingPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
        child: BottomNavigationBar(
          backgroundColor: primaryColour,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedIconTheme: IconThemeData(color: accentColour, opacity: 1),
          unselectedIconTheme:
              IconThemeData(opacity: 0.4), //opacity ranged from 0 to 1
          iconSize: 18,

          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.userFriends),
              label: 'User',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.bell),
              label: 'Menu',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.cog),
              label: 'Setting',
            ),
          ],
          onTap: (itemIndex) {
            setState(() {
              _currentIndex = itemIndex;
            });
          },
        ),
      ),
      extendBody: true,
      body: SafeArea(bottom: false, child: _children[_currentIndex]),
    );
  }
}

//https://willowtreeapps.com/ideas/how-to-use-flutter-to-build-an-app-with-bottom-navigation
