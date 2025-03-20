import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF03142B), // Dark background color
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'assets/logo.png', // Replace with your logo asset path
                height: 60,
              ),
              SizedBox(height: 16),
              
              // App Name
              Text(
                "Medlife",
                style: TextStyle(
                  color: Colors.cyanAccent,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              // Subtitle
              Text(
                "Login your Account",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              
              SizedBox(height: 32),
              
              // Username Input
              _buildInputField("UserName", false),
              SizedBox(height: 16),
              
              // Password Input
              _buildInputField("Password", true),
              SizedBox(height: 24),
              
              // Login Button
              ElevatedButton(
                onPressed: () {
                  // Handle login action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Text("Login"),
              ),
              
              SizedBox(height: 16),
              
              // Terms & Privacy Policy Text
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

  Widget _buildInputField(String label, bool isPassword) {
    return TextField(
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
