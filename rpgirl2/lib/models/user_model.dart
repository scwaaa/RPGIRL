// models/user_model.dart
import 'package:appwrite/models.dart' as models;

class UserModel {
  final String id;
  final String name;
  final String email;
  final bool isEmailVerified;
  final String? profilePhotoUrl;
  final int level;
  final int maxHealth;
  final int currentXp;
  final int maxXp;
  final int maxMana;
  final List<String> teams;
  final List<String> labels;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.isEmailVerified,
    this.profilePhotoUrl,
    required this.level,
    required this.maxHealth,
    required this.currentXp,
    required this.maxXp,
    required this.maxMana,
    required this.teams,
    required this.labels,
  });

  factory UserModel.fromAppwriteUser(models.User user) {
    // Parse the prefs map to get custom attributes
    final prefs = user.prefs.data;
    
    return UserModel(
      id: user.$id,
      name: user.name,
      email: user.email,
      isEmailVerified: user.emailVerification,
      profilePhotoUrl: null,
      level: prefs['level'] ?? 1,
      maxHealth: prefs['Max_health'] ?? 150,
      currentXp: prefs['current_xp'] ?? 0,
      maxXp: prefs['max_xp'] ?? 500,
      maxMana: prefs['max_mana'] ?? 100,
      teams: List<String>.from(prefs['teams'] ?? []),
      labels: List<String>.from(prefs['labels'] ?? []),
    );
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    bool? isEmailVerified,
    String? profilePhotoUrl,
    int? level,
    int? maxHealth,
    int? currentXp,
    int? maxXp,
    int? maxMana,
    List<String>? teams,
    List<String>? labels,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      level: level ?? this.level,
      maxHealth: maxHealth ?? this.maxHealth,
      currentXp: currentXp ?? this.currentXp,
      maxXp: maxXp ?? this.maxXp,
      maxMana: maxMana ?? this.maxMana,
      teams: teams ?? this.teams,
      labels: labels ?? this.labels,
    );
  }
}