import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medlife/Grid.dart';
import 'package:medlife/Home.dart';
import 'package:medlife/ProfileSetting.dart';

class NavigationScreen extends StatefulWidget {
  final String username;
  final String email;

  NavigationScreen({required this.username, required this.email});

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0;
  String name = "";
  String profileImage = "assets/Icons/Man.png"; // Default Image

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    try {
      print("Fetching profile for username: ${widget.username} and email: ${widget.email}");

      var uri = Uri.parse("http://localhost:8000/api/users/myProfile"); // Use appropriate IP for the device/emulator

      // Send the request and get the response
      var response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
          "username": widget.username,
          "email": widget.email,
        },
      );

      // Log the response status and body
      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          name = data["user"]["username"];
          profileImage = data["user"]["profileImage"] ?? "assets/Icons/Man.png";
        });
      } else {
        print("Failed to fetch profile. Status code: ${response.statusCode}, ${response.body}");
      }
    } catch (error) {
      print("Error fetching profile: $error");
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      HomeScreen(username: widget.username, profileImage: profileImage),
      GridPage(username: widget.username, profileImage: profileImage),
      ProfileSettingsPage(username: widget.username, email: widget.email, profileImage: profileImage),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
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
              backgroundImage: AssetImage(profileImage),
              radius: 12,
            ),
            activeIcon: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xFF70D6FF), width: 2),
              ),
              child: CircleAvatar(
                backgroundImage: AssetImage(profileImage),
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