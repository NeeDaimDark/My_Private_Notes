import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

@immutable
class AuthUser {
  final bool isEmailVerified;

  const AuthUser({required this.isEmailVerified});

  // Factory constructor to create AuthUser from Firebase User
  factory AuthUser.fromFirebase(User user) {
    return AuthUser(
      isEmailVerified: user.emailVerified,
    );
  }
}
