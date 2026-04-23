import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../HomePage/myhompage.dart';
import '../Form Pages/loginform.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(), // 🔥 auto updates on login/logout
      builder: (context, snapshot) {
        // While checking
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        // If logged in → go to Home
        if (snapshot.hasData) {
          return const MyHomePage();
        }
        // If not logged in → go to Login
        return const LoginUI();
      },
    );
  }
}
