import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../screens/home_screen.dart';
import '../screens/messages_screen.dart';
import '../screens/schedule_screen.dart';
import '../screens/settings_screen.dart';

class NavBarRoots extends StatefulWidget {
  @override
  State<NavBarRoots> createState() => _NavBarRootsState();
}

class _NavBarRootsState extends State<NavBarRoots> {
  int _selectedIndex = 0;
  final _screens = [
   HomeScreen(),
    MessagesScreen(),
    ScheduleScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: _screens[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: const Color(0xFFa04e68),
        buttonBackgroundColor:  Color(0xFF912c49),
        index: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const <Widget>[
          Icon(Icons.home, size: 30),
          Icon(CupertinoIcons.bell_fill, size: 30),
          Icon(Icons.tips_and_updates, size: 30),
          Icon(Icons.person, size: 30),
        ],
      ),
    );
  }
}
