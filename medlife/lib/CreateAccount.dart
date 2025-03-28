import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medlife/LoginScreen.dart';
import 'package:medlife/OTPScreen.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  Future<void> _registerUser() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Passwords do not match!")),
      );
      return;
    }

    final url = Uri.parse("http://localhost:8000/api/users/register");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": nameController.text,
        "email": emailController.text,
        "password": passwordController.text,
      }),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Account created successfully!")),
      );
      String email = emailController.text;
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => OTPScreen(email:email, username:nameController.text)));
    } else {
      final responseData = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(responseData['message'] ?? "Registration failed")),
      );
    }
  }

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
              Image.asset('assets/Logo.png'),
              Text(
                "Create Account",
                style: TextStyle(
                  color: Color(0xFF70D6FF),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Enter your email address and password\nto create your account",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              SizedBox(height: 32),
              
              // Name Input
              _buildInputField("Enter your name", Icons.person, false, nameController),
              SizedBox(height: 16),
              
              // Email Input
              _buildInputField("Enter your email", Icons.email, false, emailController),
              SizedBox(height: 16),
              
              // Password Input
              _buildInputField("Enter your password", Icons.lock, true, passwordController),
              SizedBox(height: 16),
              
              // Confirm Password Input
              _buildInputField("Confirm your password", Icons.lock, true, confirmPasswordController, isConfirm: true),
              SizedBox(height: 24),
              
              // Create Account Button
              ElevatedButton(
                onPressed: _registerUser, // Call API function
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF70D6FF),
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Text("Create Account"),
              ),
              
              SizedBox(height: 16),
              
              // Login Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account ? ",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(
                      "Log in",
                      style: TextStyle(
                        color: Color(0xFF70D6FF),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String hintText, IconData icon, bool isPassword, TextEditingController controller, {bool isConfirm = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? (isConfirm ? _obscureConfirmPassword : _obscurePassword) : false,
      style: TextStyle(color: Colors.white),
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
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isConfirm
                      ? (_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility)
                      : (_obscurePassword ? Icons.visibility_off : Icons.visibility),
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    if (isConfirm) {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    } else {
                      _obscurePassword = !_obscurePassword;
                    }
                  });
                },
              )
            : null,
      ),
    );
  }
}
