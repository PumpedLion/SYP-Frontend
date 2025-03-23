import 'package:flutter/material.dart';
import 'package:medlife/Grid.dart';
import 'package:medlife/ProfileSetting.dart';
import 'package:medlife/main.dart';
import 'package:medlife/Home.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = <Widget>[
    HomeScreen(),
    GridPage(), // Routes Page
    const Placeholder(), // Guides Page
    ProfileSettingsPage(), // Profile Page
  ];

  // Image Paths for Icons
  final List<String> _iconPaths = [
    'assets/Icons/Home.png',
    'assets/Icons/Main.png',
    'assets/Icons/Grid.png',
    'assets/Icons/Bman.png',
  ];

  final List<String> _selectedIconPaths = [
    'assets/Icons/SelectedHome.png',
    'assets/Icons/SelectedMain.png',
    'assets/Icons/SelectedGrid.png',
    'assets/Icons/Aman.png',
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
      bottomNavigationBar: Stack(
        children: [
          // Gradient Background
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80, // Match BottomNavigationBar height
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0E1B30), Color(0xFF03142B)], // Custom Gradient Colors
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          // BottomNavigationBar with Transparent Background
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: BottomNavigationBar(
              backgroundColor: Color(0xFF0E1B30), // Must be transparent for gradient effect
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              selectedItemColor: Color(0xFF70D6FF),
              unselectedItemColor: Colors.white,
              elevation: 0, // Remove shadow
              items: List.generate(4, (index) {
                return BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(_selectedIndex == index ? _selectedIconPaths[index] : _iconPaths[index]),
                    size: 30,
                  ),
                  label: _getLabel(index),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  String _getLabel(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'MedLife';
      case 2:
        return 'Lists';
      case 3:
        return 'Profile';
      default:
        return '';
    }
  }
}
