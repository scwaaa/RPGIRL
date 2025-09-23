import 'package:appwrite/appwrite.dart';

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