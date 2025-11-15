// models/user_model.dart
import 'package:appwrite/models.dart' as models;

class UserModel {
  final String id;
  final String name;
  final String email;
  final bool isEmailVerified;
  final String? profilePhotoUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.isEmailVerified,
    this.profilePhotoUrl,
  });

  factory UserModel.fromAppwriteUser(models.User user) {
    return UserModel(
      id: user.$id,
      name: user.name,
      email: user.email,
      isEmailVerified: user.emailVerification,
      profilePhotoUrl: null,
    );
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    bool? isEmailVerified,
    String? profilePhotoUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
    );
  }
}