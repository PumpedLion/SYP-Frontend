import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:medlife/Continue.dart';
import 'package:medlife/EditAccount.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSettingsPage extends StatefulWidget {
  final String username;
  final String email;
  final String profileImage;

  ProfileSettingsPage({
    required this.username,
    required this.email,
    required this.profileImage,
  });

  @override
  _ProfileSettingsPageState createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  int? userId; // Variable to store the user ID

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('userId'); // Retrieve as int
    });
    print("Loaded User ID: $userId");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1A2F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A1A2F),
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(widget.profileImage),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Color(0xFF70D6FF),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(widget.username, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                Text("25 Year", style: TextStyle(color: Colors.white60, fontSize: 14)),
                Text(widget.email, style: TextStyle(color: Colors.white60, fontSize: 14)),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditAccount()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF70D6FF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: const Text("Edit Profile", style: TextStyle(color: Color(0xFF0A1A2F), fontSize: 14)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: const Text("Settings", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: [
                settingsTile("Notifications", "assets/icons/notification.svg"),
                settingsTile("Privacy and Security", "assets/icons/privacy.svg"),
                settingsTile("Change Password", "assets/icons/password.svg"),
                settingsTile("Change Profile Lock", "assets/icons/lock.svg"),
                settingsTile("Delete Account", "assets/icons/delete.svg", onTap: () {
                  _showDeleteConfirmationDialog(context);
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget settingsTile(String title, String iconPath, {Function()? onTap}) {
    return ListTile(
      leading: SvgPicture.asset(
        iconPath,
        height: 24,
        width: 24,
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
      ),
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 16)),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
      onTap: onTap ?? () {},
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF0A1A2F),
          title: const Text("Delete Account", style: TextStyle(color: Colors.white)),
          content: const Text("Are you sure you want to delete your account? This action cannot be undone.", style: TextStyle(color: Colors.white60)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text("Cancel", style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                _deleteAccount(context);
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteAccount(BuildContext context) async {
    if (userId != null) {
      final response = await http.delete(
        Uri.parse('http://localhost:8000/api/users/deleteUser'), // Your API endpoint
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id': userId.toString()}), // Convert int to string for the API
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Account deleted successfully")));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Continue()), // Replace with your ContinuePage
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${response.body}')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("User ID not found.")));
    }
  }
}