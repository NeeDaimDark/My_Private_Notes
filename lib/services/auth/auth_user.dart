import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

@immutable
class AuthUser {
  final String id;
  final bool isEmailVerified;
  final String? email;

  const AuthUser({
    required this.id,
    required this.email,
    required this.isEmailVerified
  });

  // Factory constructor to create AuthUser from Firebase User
  factory AuthUser.fromFirebase(User user) {
    return AuthUser(
      id: user.uid,
      email: user.email,
      isEmailVerified: user.emailVerified,
    );
  }
}
