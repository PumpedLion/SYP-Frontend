import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class EditAccount extends StatefulWidget {
  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int? userId; // Change userId to int

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
      backgroundColor: Color(0xFF03142B),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/Logo.png', height: 100, width: 100),
                Text(
                  "Edit Account",
                  style: TextStyle(
                    color: Color(0xFF70D6FF),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 32),
                _buildInputField("Enter your name", Icons.person, controller: _nameController),
                SizedBox(height: 16),
                _buildInputField("Enter your email", Icons.email, controller: _emailController),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    print("Edit button clicked");
                    _handleSubmit();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF70D6FF),
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Text("Edit"),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String hintText, IconData icon, {TextEditingController? controller}) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      validator: (value) {
        if (value!.isEmpty) {
          return '$hintText cannot be empty';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Color(0xFF1A2C46),
        prefixIcon: Icon(icon, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Future<void> _handleSubmit() async {
    // Ensure userId is not null
    if (userId != null) {
      print("Submitting form with ID: $userId, Username: ${_nameController.text}, Email: ${_emailController.text}");

      final response = await http.patch(
        Uri.parse('http://localhost:8000/api/users/editProfile'), // Replace with your actual IP address
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id': userId.toString(), // Convert int to string for the API
          'username': _nameController.text,
          'email': _emailController.text,
        }),
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile updated successfully')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error updating profile: ${response.body}')));
      }
    } else {
      print("User ID is null");
    }
  }
}