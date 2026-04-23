import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../HomePage/myhompage.dart';
import '../Form Pages/loginform.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Wait 2 seconds then check user status
    Timer(const Duration(seconds: 2), _checkUserStatus);
  }

  void _checkUserStatus() {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User already logged in → Go to Home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage()),
      );
    } else {
      //  Not logged in → Go to Login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginUI()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange, // 🌈 Your theme color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.task_alt,
              color: Colors.white,
              size: 100,
            ),
            const SizedBox(height: 20),
            const Text(
              "My TODO App",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
