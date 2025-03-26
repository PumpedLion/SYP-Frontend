import 'package:flutter/material.dart';
import 'package:medlife/Grid.dart';
import 'package:medlife/Home.dart';
import 'package:medlife/ProfileSetting.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0; // Default screen index

  final List<Widget> _screens = [
    HomeScreen(),
    GridPage(),
    ProfileSettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index; // Update active tab
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens, // Keep screen state persistent
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF0A1A2F),
        selectedItemColor: Color(0xFF70D6FF),
        unselectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/Icons/Home.png'), size: 24),
            activeIcon: ImageIcon(AssetImage('assets/Icons/SelectedHome.png'), size: 24),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/Icons/Grid.png'), size: 24),
            activeIcon: ImageIcon(AssetImage('assets/Icons/SelectedGrid.png'), size: 24),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundImage: AssetImage('assets/Icons/Man.png'),
              radius: 12,
            ),
            activeIcon: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xFF70D6FF), width: 2),
              ),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/Icons/Man.png'),
                radius: 12,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
