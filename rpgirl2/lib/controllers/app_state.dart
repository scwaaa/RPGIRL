// lib/controllers/app_state.dart
import 'package:flutter/material.dart';
import 'package:rpgirl2/models/user_model.dart';

class AppState with ChangeNotifier {
  int _currentPageIndex = 1; // Only allowed values: 0, 1, 2
  bool _isBottomMenuOpen = false;

  // Private setter to ensure index is always valid
  int get currentPageIndex => _currentPageIndex;
  bool get isBottomMenuOpen => _isBottomMenuOpen;

  void setCurrentPage(int index) {
    // Force index to be within valid range
    final safeIndex = index.clamp(0, 2);
    if (_currentPageIndex != safeIndex) {
      _currentPageIndex = safeIndex;
      _isBottomMenuOpen = false;
      notifyListeners();
    }
  }

  void toggleBottomMenu() {
    _isBottomMenuOpen = !_isBottomMenuOpen;
    notifyListeners();
  }

  String get currentPageTitle {
    switch (_currentPageIndex) {
      case 0: return 'My Profile';
      case 1: return 'RPGIRL';
      case 2: return 'Search';
      default: return 'RPGIRL'; // Fallback
    }
  }
}