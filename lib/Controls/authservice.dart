
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Views/HomePage/myhompage.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> registerUser(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return "User registered successfully!";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          return "Invalid email address.";
        case 'weak-password':
          return "Password should be at least 6 characters.";
        case 'email-already-in-use':
          return "Email already registered.";
        default:
          return "Registration failed: ${e.message}";
      }
    } catch (e) {
      return "Unexpected error: $e";
    }
  }

  Future<String?> loginUser(BuildContext context ,String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));//"Login successful!";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          return "Invalid email format.";
        case 'user-not-found':
          return "User not found.";
        case 'wrong-password':
          return "Incorrect password.";
        default:
          return "Login failed: ${e.message}";
      }
    } catch (e) {
      return "Unexpected error: $e";
    }
  }
}



