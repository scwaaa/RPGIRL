// authScreen.dart
import 'package:flutter/material.dart';
import 'package:rpgirl2/pages/LoginPage.dart';
import 'package:rpgirl2/pages/SignupPage.dart';

class Authpage extends StatefulWidget {
  const Authpage({super.key});

  @override
  State<Authpage> createState() => _AuthpageState();
}

class _AuthpageState extends State<Authpage> {
  bool showLogin = true;

  void toggleView() {
    setState(() {
      showLogin = !showLogin;
    });
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
            )
          else
            SignupScreen(
              onSignInPressed: toggleView,
            ),
        ],
      ),
    );
  }
}