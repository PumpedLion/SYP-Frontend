import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';

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
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // SVG Background Image
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/Screenshot.svg',
              fit: BoxFit.cover,
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
      body: Center(
        child: Text("Welcome to Medlife!"),
      ),
    );
  }
}
