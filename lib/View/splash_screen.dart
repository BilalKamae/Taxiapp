import 'dart:async';
import 'package:flutter/material.dart';


import 'HomePage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    // Simulate loading time
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => TaxiSchool()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF95C0EC),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              backgroundColor: Colors.yellow,
              color: Colors.white,
            ), // Show loader
            SizedBox(height: 20),
            Image.asset(
              'images/taxiapp.png',
              filterQuality: FilterQuality.high,
              height: 220,
              width: 200,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}






