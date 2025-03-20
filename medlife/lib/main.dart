import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'package:medlife/Continue.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to HomeScreen after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Loading SVG file...");
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // SVG Background Image
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/Screenshot.svg',
              fit: BoxFit.cover,
              placeholderBuilder: (BuildContext context) => 
                  Center(child: CircularProgressIndicator()), // Show loading if SVG is not found
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SVG Logo
              SvgPicture.asset(
                'assets/logo1.svg',
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 20),
              // App Name
              const Text(
                "Medlife",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              // Tagline
              const Text(
                "Relax, Reflect, and Recharge",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 20),
              // Progress Indicator
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Dummy Home Screen

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0E1B30), // Dark background
      body: SafeArea(
        
          
          child: Column(
            
            
            children: [
              
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Welcome to Medlife",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Relax, Reflex, and Recharge",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SvgPicture.asset(
                'assets/image1.svg',
                // width: 100,
                // height: 100,
              ),
              
              const SizedBox(height: 200),
              
              const Text(
                "Discover the power of mindfulness with guided meditations, breathing exercise, and daily tracking to help you find calm and focus",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to Continue screen
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Continue()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF70D6FF), // Light blue button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      
                    ),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
    
  }
}