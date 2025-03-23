import 'package:flutter/material.dart';
import 'package:medlife/ProfileSetting.dart';


class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = <Widget>[
    const Placeholder(), // Home Page
    const Placeholder(), // Replace with Routes Page widget
    const Placeholder(), // Replace with Guides Page widget
    ProfileSettingsPage(), // Replace with Profile Page widget
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.brown[700],
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.route), label: 'Routes'),
          BottomNavigationBarItem(icon: Icon(Icons.person_search), label: 'Guides'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}