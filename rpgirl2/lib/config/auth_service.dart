// auth_service.dart
import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:rpgirl2/models/user_model.dart'; // Add this import

class AuthService extends ChangeNotifier { // Changed to extend ChangeNotifier
  final Account account;
  final Databases databases; // Add Databases client
  UserModel? _currentUser;

  AuthService({required this.account, required this.databases}); // Update constructor

  UserModel? get currentUser => _currentUser;

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

  Future<void> _fetchCurrentUser() async {
    try {
      final models.User user = await account.get();
      
      // Fetch user document from database
      try {
        final document = await databases.getDocument(
          databaseId: '68d7d66d0010af66dce6', // Your database ID
          collectionId: 'users', // Your collection ID
          documentId: user.$id,
        );
        
        // Merge Appwrite user data with database document data
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
          teams: List<String>.from(document.data['teams'] ?? []),
          labels: List<String>.from(document.data['labels'] ?? []),
        );
      } catch (e) {
        // If document doesn't exist, create a default one
        _currentUser = UserModel.fromAppwriteUser(user);
      }
    } catch (e) {
      _currentUser = null;
      throw Exception('Failed to fetch user: $e');
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

  Future<void> logout() async {
    try {
      await account.deleteSession(sessionId: 'current');
      _currentUser = null;
      notifyListeners();
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

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

  Future<void> refreshUserData() async {
    await _fetchCurrentUser();
    notifyListeners();
  }
}