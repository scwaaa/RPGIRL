// Authpage.dart
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rpgirl2/pages/LoginPage.dart';
import 'package:rpgirl2/pages/verificationPage.dart';
import 'package:rpgirl2/pages/SignupPage.dart';

class Authpage extends StatelessWidget {
  final pageController = PageController(
    initialPage: 1,
  );

  void _changePage(int index) {
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Lottie.network(
            "https://lottie.host/25d91c54-8cb0-4bd2-bdb2-d5622a3bebbb/jxeDFH40aG.json",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            repeat: true,
            animate: true,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                PageView(
                  controller: pageController,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    verificationPage(),
                    LoginPage(onSignUpPressed: () => _changePage(2)),
                    SignupScreen(onSignInPressed: () => _changePage(1)), // Add callback here
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}