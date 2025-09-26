// lib/models/user_model.dart
class UserModel {
  final String id;
  final String name;
  final String email;
  final bool isEmailVerified;
  final DateTime? registrationDate;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.isEmailVerified,
    this.registrationDate,
  });

  factory UserModel.fromAppwriteUser(dynamic user) {
    return UserModel(
      id: user.$id,
      name: user.name ?? 'Unknown User',
      email: user.email ?? '',
      isEmailVerified: user.emailVerification ?? false,
      registrationDate: user.registration != null 
          ? DateTime.tryParse(user.registration) 
          : null,
    );
  }
}