import 'package:flutter/material.dart';
import 'package:medlife/NavigationBar.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OTPScreen extends StatefulWidget {
  final String username;
  final String email;

  OTPScreen({required this.email, required this.username});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _otpController = TextEditingController();

Future<void> verifyOTP(BuildContext context) async {
  String otp = _otpController.text;
  if (otp.isEmpty) {
    print("OTP cannot be empty");
    return;
  }

  var url = Uri.parse("http://localhost:8000/api/users/verify-otp");
  var response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "email": widget.email,  // Assuming you have 'email' passed to the widget
      "otp": otp,
    }),
  );

  if (response.statusCode == 200) {
    
    print("OTP Verified Successfully!");

    // Navigate to NavigationScreen with username & email
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => NavigationScreen(
          username: widget.username,
          email: widget.email,
        ),
      ),
    );
  } else {
    print("OTP Verification Failed: ${response.body}");
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
              Image.asset('assets/logo.png', height: 60),
              SizedBox(height: 20),
              Text(
                "Enter OTP Code",
                style: TextStyle(color: Color(0xFF70D6FF), fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "Verify your email (${widget.email}) using the 6-digit OTP code.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              SizedBox(height: 32),
              Pinput(
                controller: _otpController,
                length: 5,
                defaultPinTheme: PinTheme(
                  width: 50,
                  height: 50,
                  textStyle: TextStyle(fontSize: 20, color: Colors.white),
                  decoration: BoxDecoration(
                    color: Color(0xFF1A2C46),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Color(0xFF70D6FF)),
                  ),
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => verifyOTP(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF70D6FF),
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Text("Verify OTP Code"),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Did not get the code? ", style: TextStyle(color: Colors.grey, fontSize: 14)),
                  GestureDetector(
                    onTap: () => print("Resending OTP..."),
                    child: Text(
                      "Resend code",
                      style: TextStyle(color: Color(0xFF70D6FF), fontSize: 14, fontWeight: FontWeight.bold),
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
}
