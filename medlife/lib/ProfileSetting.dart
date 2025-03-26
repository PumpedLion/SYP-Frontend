import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medlife/EditAccount.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileSettingsPage(),
    );
  }
}

class ProfileSettingsPage extends StatelessWidget {
  Widget buildSvgIcon(String assetPath, Color color, {double size = 24}) {
    return SvgPicture.asset(
      assetPath,
      height: size,
      width: size,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1A2F), // Dark background color
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A1A2F),
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          // Profile Section
          Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          "https://via.placeholder.com/150"), // Replace with actual image
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
                const Text(
                  "John Smith",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "25 Year",
                  style: TextStyle(color: Colors.white60, fontSize: 14),
                ),
                const Text(
                  "johnsmith@gmail.com",
                  style: TextStyle(color: Colors.white60, fontSize: 14),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditAccount(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF70D6FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: const Text(
                    "Edit Profile",
                    style: TextStyle(color: Color(0xFF0A1A2F), fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Settings Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Settings",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Settings List
          Expanded(
            child: ListView(
              children: [
                settingsTile("Notifications", "assets/icons/notification.svg"),
                settingsTile("Privacy and Security", "assets/icons/privacy.svg"),
                settingsTile("Change Password", "assets/icons/password.svg"),
                settingsTile("Change Profile Lock", "assets/icons/lock.svg"),
              ],
            ),
          ),
        ],
      ),
      
      
    );
  }

  // Widget for Settings List Items
  Widget settingsTile(String title, String iconPath) {
    return ListTile(
      leading: SvgPicture.asset(
        iconPath,
        height: 24,
        width: 24,
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
      onTap: () {},
    );
  }
}
