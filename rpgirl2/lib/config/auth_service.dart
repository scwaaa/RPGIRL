import 'package:appwrite/appwrite.dart';

class AuthService {
  final Account account;

  AuthService({required this.account});

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