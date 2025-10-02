// auth_service.dart
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

class AuthService {
  final Account account;

  AuthService({required this.account});

  Future<void> register(String email, String password, String name) async {
    try {
      await account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );
      
      // Automatically log in after registration
      await account.createEmailPasswordSession(email: email, password: password);
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await account.createEmailPasswordSession(email: email, password: password);
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<User> getCurrentUser() async {
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
        url: 'https://rpgirl2.vercel.app/verify', // Replace with your actual URL
      );
    } catch (e) {
      throw Exception('Failed to send verification email: $e');
    }
  }

  Future<void> verifyEmail(String secret) async {
    try {
      await account.updateVerification(
        userId: ID.unique(), // You might need to get the current user ID
        secret: secret,
      );
    } catch (e) {
      throw Exception('Email verification failed: $e');
    }
  }

  Future<void> logout() async {
    try {
      await account.deleteSession(sessionId: 'current');
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

  Future<bool> isLoggedIn() async {
    try {
      await account.get();
      return true;
    } catch (e) {
      return false;
    }
  }
}