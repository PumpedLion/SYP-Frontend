import 'package:flutter/material.dart';
import 'package:medlife/Navigation.dart';
import 'package:pinput/pinput.dart';

class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF03142B), // Dark background
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'assets/logo.png', // Replace with your logo asset
                height: 60,
              ),

              SizedBox(height: 20),

              // Title
              Text(
                "Enter OTP Code",
                style: TextStyle(
                  color: Colors.cyanAccent,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 8),

              // Subtitle
              Text(
                "Verify your phone number using the 6-digit OTP code sent by avlical",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),

              SizedBox(height: 32),

              // OTP Input
              Pinput(
                controller: _otpController,
                length: 6,
                defaultPinTheme: PinTheme(
                  width: 50,
                  height: 50,
                  textStyle: TextStyle(fontSize: 20, color: Colors.white),
                  decoration: BoxDecoration(
                    color: Color(0xFF1A2C46),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.cyanAccent),
                  ),
                ),
                onCompleted: (pin) {
                  print("Entered OTP: $pin");
                },
              ),

              SizedBox(height: 24),

              // Verify OTP Button
              ElevatedButton(
                onPressed: () {
                  // Handle OTP verification
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Navigation()),
                    );
                  print("Verifying OTP: ${_otpController.text}");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Text("Verify OTP Code"),
              ),

              SizedBox(height: 16),

              // Resend Code Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Did not get the code? ",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () {
                      
                      // Handle OTP resend
                      print("Resending OTP...");
                    },
                    child: Text(
                      "Resend code",
                      style: TextStyle(
                        color: Colors.cyanAccent,
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
}
