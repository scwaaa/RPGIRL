// auth_wrapper.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_service.dart';
import 'package:rpgirl2/pages/LoginPage.dart';
import 'package:rpgirl2/pages/HomeBase.dart'; // Import your Home widget
import 'package:rpgirl2/pages/authScreen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    
    return FutureBuilder(
      future: authService.isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData && snapshot.data == true) {
          return Home(); // User is logged in, show home page
        } else {
          return Authpage(); // User is not logged in, show login page
        }
      },
    );
  }
}