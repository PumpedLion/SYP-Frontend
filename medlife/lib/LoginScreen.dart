import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medlife/NavigationBar.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    final String url = "http://localhost:8000/api/users/login";

    final Map<String, String> requestBody = {
      "email": _emailController.text,
      "password": _passwordController.text,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        int id = data["user"]["id"]; // Change Int to int
        String username = data["user"]["username"];
        String email = data["user"]["email"];
        print("Login successful for $username with email $email");
        
        // Store the id in shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt('userId', id); // Store the id

        // Navigate to NavigationScreen with username & email
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => NavigationScreen(
              username: username,
              email: email,
            ),
          ),
        );
      } else {
        print("Login failed: ${response.body}");
      }
    } catch (error) {
      print("Error during login: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF03142B),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/Logo.png', height: 100, width: 100),
              SizedBox(height: 16),
              Text(
                "Medlife",
                style: TextStyle(
                  color: Color(0xFF70D6FF),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Login your Account",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              SizedBox(height: 32),
              _buildInputField("Email", _emailController, false),
              SizedBox(height: 16),
              _buildInputField("Password", _passwordController, true),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => _login(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF70D6FF),
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Text("Login"),
              ),
              SizedBox(height: 16),
              Text(
                "By continuing you accept our\nterms of services And Privacy policy",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller, bool isPassword) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? _obscurePassword : false,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Color(0xFF1A2C46),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              )
            : null,
      ),
    );
  }
}