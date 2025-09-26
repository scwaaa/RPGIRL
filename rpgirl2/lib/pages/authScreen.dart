// authScreen.dart
import 'package:flutter/material.dart';
import 'package:rpgirl2/pages/LoginPage.dart';
import 'package:rpgirl2/pages/SignupPage.dart'; // Make sure this import is correct

class Authpage extends StatefulWidget {
  const Authpage({super.key});

  @override
  State<Authpage> createState() => _AuthpageState();
}

class _AuthpageState extends State<Authpage> {
  bool showLogin = true;
  bool showVerification = false;

  void toggleView() {
    setState(() {
      showLogin = !showLogin;
      showVerification = false;
    });
  }

  void showVerificationScreen() {
    // For now, show a snackbar. You can implement a proper verification page later.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Verification email sent! Please check your inbox.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff8a0ad5),
      body: Stack(
        children: [
          if (showLogin)
            LoginPage(
              onSignUpPressed: toggleView,
              onVerificationNeeded: showVerificationScreen,
            )
          else
            SignupScreen(
              onSignInPressed: toggleView, // This matches the parameter name
              onVerificationNeeded: showVerificationScreen,
            ),
        ],
      ),
    );
  }
}