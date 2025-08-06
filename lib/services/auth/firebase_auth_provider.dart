import 'dart:developer' as devtools show log;

import 'package:firebase_core/firebase_core.dart';
import 'package:Nuvio/firebase_options.dart';
import 'package:Nuvio/services/auth/auth_user.dart';
import 'package:Nuvio/services/auth/auth_exceptions.dart';
import 'package:Nuvio/services/auth/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth,FirebaseAuthException;



class FirebaseAuthProvider implements AuthProvider{
  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async
  {
    try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          throw WeakPasswordAuthException();
        case 'email-already-in-use':
          throw EmailAlreadyInUseAuthException();
        case 'invalid-email':
          throw InvalidEmailAuthException();
        default:
          throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  AuthUser? get currentUser {
   final user = FirebaseAuth.instance.currentUser;
   if(user !=null){
     return AuthUser.fromFirebase(user);
   } else{
     return null;
   }
  }



  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) async
  {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _reloadUser(); // Ensure user is reloaded to get the latest status
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      devtools.log('Firebase Error: ${e.code}');
      switch (e.code) {
        case 'user-not-found':
          throw UserNotFoundAuthException();
        case 'wrong-password':
          throw WrongPasswordAuthException();
        case 'invalid-email':
          throw InvalidEmailAuthException();
        case 'invalid-credential':
          throw InvalidCredentialAuthException();
        default:
          throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }





  @override
  Future<void> logOut() async{
    final user = FirebaseAuth.instance.currentUser;
    if(user!=null){
      await FirebaseAuth.instance.signOut();
    }
    else {
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<void> sendEmailVerification() async {
   final user = FirebaseAuth.instance.currentUser;
   if(user!=null){
     await user.sendEmailVerification();
   }else{
     throw UserNotLoggedInAuthException();
   }
  }

  @override
  Future<void> initialize() async{
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  Future<void> _reloadUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.reload();
    }
  }

  @override
  Future<void> sendPasswordReset({required String toEmail}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: toEmail);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {

        case 'firebase_auth/bad-credential':
          throw InvalidCredentialAuthException();
        case 'firebase_auth/not-found':
          throw UserNotFoundAuthException();
        case 'firebase_auth/invalid-email':
          throw InvalidEmailAuthException();
        default:
          throw GenericAuthException();
      }

    }catch(_) {
      throw GenericAuthException();
    }

  }



}