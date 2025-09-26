// lib/routeGenerator.dart
import 'package:flutter/material.dart';
import 'package:rpgirl2/config/auth_wrapper.dart';
import 'package:rpgirl2/pages/main_app_screen.dart';
import 'package:rpgirl2/pages/homepages/inventory.dart';
import 'package:rpgirl2/pages/homepages/social.dart';
import 'package:rpgirl2/pages/homepages/messages.dart';
import 'package:rpgirl2/widgets/chat.dart';
import 'package:rpgirl2/widgets/settingScreen.dart';
import 'package:rpgirl2/quickplay.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => AuthWrapper());
      case '/home':
        return MaterialPageRoute(builder: (_) => MainAppScreen());
      case "/inventory":
        return MaterialPageRoute(builder: (_) => InventoryPage());
      case "/friends":
        return MaterialPageRoute(builder: (_) => SocialPage());
      case "/messages":
        return MaterialPageRoute(builder: (_) => messagesScreen());
      case "/chat":
        return MaterialPageRoute(builder: (_) => ChatScreen());
      case "/settings":
        return MaterialPageRoute(builder: (_) => settingScreen());
      case "/quickplay":
        return MaterialPageRoute(builder: (_) => QuickplayScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: Text('Error')),
        body: Center(child: Text('Page not found!')),
      );
    });
  }
}