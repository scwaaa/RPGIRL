// auth_service.dart
import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:rpgirl2/models/user_model.dart';

class AuthService extends ChangeNotifier {
  final Account account;
  final Databases databases;
  final Teams teams;
  UserModel? _currentUser;

  AuthService({
    required this.account, 
    required this.databases,
    required this.teams,
  });

  UserModel? get currentUser => _currentUser;

  // Add the missing isLoggedIn method
  Future<bool> isLoggedIn() async {
    try {
      await account.get();
      if (_currentUser == null) {
        await _fetchCurrentUser();
      }
      return true;
    } catch (e) {
      _currentUser = null;
      return false;
    }
  }

  // Add the missing logout method
  Future<void> logout() async {
    try {
      await account.deleteSession(sessionId: 'current');
      _currentUser = null;
      notifyListeners();
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

  // Add method to get user's teams
  Future<List<String>> _getUserTeams() async {
    try {
      final teamList = await teams.list();
      print('User teams from Teams API: ${teamList.teams.map((t) => t.name).toList()}');
      return teamList.teams.map((team) => team.name).toList();
    } catch (e) {
      print('Error fetching user teams: $e');
      return [];
    }
  }

  Future<void> _fetchCurrentUser() async {
    try {
      final models.User user = await account.get();
      
      // Debug user prefs
      print('=== USER PREF DATA ===');
      print('User prefs: ${user.prefs.data}');
      print('Labels from prefs: ${user.prefs.data['labels']}');
      
      // Get user's teams membership
      final userTeams = await _getUserTeams();
      
      // Fetch user document from database
      try {
        final document = await databases.getDocument(
          databaseId: '68d7d66d0010af66dce6',
          collectionId: 'users', 
          documentId: user.$id,
        );
        
        print('=== DATABASE DOCUMENT DATA ===');
        print('Document data: ${document.data}');
        print('Document labels: ${document.data['labels']}');
        print('Document labels type: ${document.data['labels']?.runtimeType}');
        
        // Handle different label formats
        List<String> labels = [];
        final labelsData = document.data['labels'];
        
        if (labelsData is List) {
          // Convert each item to string
          labels = labelsData.map((item) => item.toString()).toList();
        } else if (labelsData is String) {
          // Handle comma-separated string
          labels = labelsData.split(',').map((s) => s.trim()).toList();
        } else {
          // Fallback to empty list
          labels = List<String>.from(document.data['labels'] ?? []);
        }
        
        print('Processed labels: $labels');
        
        // Merge all data including Teams API data
        _currentUser = UserModel(
          id: user.$id,
          name: user.name,
          email: user.email,
          isEmailVerified: user.emailVerification,
          profilePhotoUrl: null,
          level: document.data['level'] ?? 1,
          maxHealth: document.data['max_health'] ?? 150,
          currentXp: document.data['current_xp'] ?? 0,
          maxXp: document.data['max_xp'] ?? 500,
          maxMana: document.data['max_mana'] ?? 100,
          teams: userTeams, // Use teams from Teams API
          labels: labels, // Use processed labels
          badges: List<String>.from(document.data['badges'] ?? []),
        );
        
      } catch (e) {
        print('Error fetching user document: $e');
        // If document doesn't exist, check user prefs for labels
        final prefs = user.prefs.data;
        final labelsFromPrefs = List<String>.from(prefs['labels'] ?? []);
        
        _currentUser = UserModel.fromAppwriteUser(user).copyWith(
          teams: userTeams,
          labels: labelsFromPrefs,
        );
        print('Fallback user model - Labels from prefs: ${_currentUser!.labels}');
      }
      
      // Final debug output
      print('=== FINAL USER DATA ===');
      print('Teams: ${_currentUser!.teams}');
      print('Labels: ${_currentUser!.labels}');
      print('Labels count: ${_currentUser!.labels.length}');
      
    } catch (e) {
      _currentUser = null;
      throw Exception('Failed to fetch user: $e');
    }
  }

  // Add debug method to check user document
  Future<void> debugUserDocument() async {
    try {
      final user = await account.get();
      final document = await databases.getDocument(
        databaseId: '68d7d66d0010af66dce6',
        collectionId: 'users',
        documentId: user.$id,
      );
      
      print('=== USER DOCUMENT DEBUG ===');
      print('Document ID: ${document.$id}');
      print('All data: ${document.data}');
      print('Labels field: ${document.data['labels']}');
      print('Labels field type: ${document.data['labels']?.runtimeType}');
      if (document.data['labels'] != null) {
        print('Labels length: ${(document.data['labels'] as List).length}');
      }
      print('===========================');
    } catch (e) {
      print('Debug error: $e');
    }
  }

  // Add method to fetch achievement details
  Future<Map<String, dynamic>> getAchievementDetails(String achievementId) async {
    try {
      final document = await databases.getDocument(
        databaseId: '68d7d66d0010af66dce6',
        collectionId: 'achievements',
        documentId: achievementId,
      );
      return document.data;
    } catch (e) {
      throw Exception('Failed to fetch achievement: $e');
    }
  }

  Future<models.User> getCurrentUser() async {
    try {
      return await account.get();
    } catch (e) {
      throw Exception('Failed to get user: $e');
    }
  }

  Future<bool> isEmailVerified() async {
    try {
      final user = await account.get();
      return user.emailVerification;
    } catch (e) {
      return false;
    }
  }

  Future<void> sendVerificationEmail() async {
    try {
      await account.createVerification(
        url: 'https://rpgirl2.vercel.app/verify',
      );
    } catch (e) {
      throw Exception('Failed to send verification email: $e');
    }
  }

  Future<void> verifyEmail(String secret) async {
    try {
      await account.updateVerification(
        userId: ID.unique(),
        secret: secret,
      );
      await _fetchCurrentUser();
      notifyListeners();
    } catch (e) {
      throw Exception('Email verification failed: $e');
    }
  }

  Future<void> refreshUserData() async {
    await _fetchCurrentUser();
    notifyListeners();
  }

  // Registration and login methods
  Future<void> register(String email, String password, String name) async {
    try {
      await account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );
      
      await account.createEmailPasswordSession(email: email, password: password);
      await _fetchCurrentUser();
      notifyListeners();
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await account.createEmailPasswordSession(email: email, password: password);
      await _fetchCurrentUser();
      notifyListeners();
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }
}