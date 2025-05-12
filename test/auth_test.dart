import 'package:myprivatenotes/services/auth/auth_exceptions.dart';
import 'package:myprivatenotes/services/auth/auth_provider.dart';
import 'package:myprivatenotes/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main() {
  group('Mock Authentication', () {
    final provider = MockAuthProvider();

    //test1
    test('should not be initialized to begin with', () {
      expect(provider.isInitialized, false);
    });

    //test2
    test('Cannot log out if not initialized', () {
      expect(
        provider.logOut(),
        throwsA(const TypeMatcher<NotInitializedException>()),
      );
    });

    //test3
    test('Should be able to be initialized', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    });

    //test4
    test('User should be null after initialization', () {
      expect(provider.currentUser, null);
    });

    //test5
    test('should be able to initialize in less than 2 seconds', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    },
      timeout: const Timeout(Duration(seconds: 2)),
    );

    //test6
    test('Create User should delegate a login function', () async {
      final badEmailUser = provider.createUser(
        email: 'medaminekoubaa4@gmail.com',
        password: 'anypassword',
      );
      expect(
        badEmailUser,
        throwsA(const TypeMatcher<UserNotFoundAuthException>()),
      );

      final badPasswordUser = provider.createUser(
        email: 'someone@gmail.com',
        password: 'amine123',
      );
      expect(
        badPasswordUser,
        throwsA(const TypeMatcher<WrongPasswordAuthException>()),
      );

      final user = await provider.createUser(
        email: 'amine',
        password: 'koubaa',
      );
      expect(provider.currentUser, user);
      expect(user.isEmailVerified, false);
    });

    //test7
    test('login user should be verified', () async {
      await provider.createUser(
        email: 'amine',
        password: 'koubaa',
      );
      await provider.sendEmailVerification();
      final user = provider.currentUser;
      expect(user, isNotNull);
      expect(user!.isEmailVerified, true);
    });

    //test8
    test('Should be able to LogOut and LogIn', () async {
      await provider.logOut();
      await provider.logIn(
        email: 'email',
        password: 'password',
      );
      final user = provider.currentUser;
      expect(user, isNotNull);
    });

    //test9
    test('Cannot send email verification without user', () async {
      await provider.logOut();
      expect(
        provider.sendEmailVerification(),
        throwsA(const TypeMatcher<UserNotLoggedInAuthException>()),
      );
    });

    //test10
    test('Should throw InvalidEmailAuthException for invalid email format', () async {
      expect(
        provider.createUser(
          email: 'invalid-email-format',
          password: 'anypassword',
        ),
        throwsA(const TypeMatcher<InvalidEmailAuthException>()),
      );
    });

    //test11
    test('Should create user and allow login', () async {
      final user = await provider.createUser(
        email: 'validuser@gmail.com',
        password: 'validpassword',
      );
      expect(provider.currentUser, user);
      expect(user.isEmailVerified, false);
    });

    //test12
    test('Should verify email for user', () async {
      await provider.sendEmailVerification();
      final user = provider.currentUser;
      expect(user, isNotNull);
      expect(user!.isEmailVerified, true);
    });

    //test13
    test('Should allow user to log out and log in again', () async {
      await provider.logOut();
      expect(provider.currentUser, null);

      await provider.logIn(
        email: 'validuser@gmail.com',
        password: 'validpassword',
      );
      final user = provider.currentUser;
      expect(user, isNotNull);
    });

    //test14
    test('Should throw UserNotLoggedInAuthException if log out without login', () async {
      await provider.logOut();
      expect(
        provider.logOut(),
        throwsA(const TypeMatcher<UserNotLoggedInAuthException>()),
      );
    });

    //test15
    test('Should throw UserNotFoundAuthException for incorrect email', () async {
      expect(
        provider.logIn(
          email: 'unknownuser@gmail.com',
          password: 'password',
        ),
        throwsA(const TypeMatcher<UserNotFoundAuthException>()),
      );
    });

    //test16
    test('Should throw WrongPasswordAuthException for incorrect password', () async {
      expect(
        provider.logIn(
          email: 'validuser@gmail.com',
          password: 'wrongpassword',
        ),
        throwsA(const TypeMatcher<WrongPasswordAuthException>()),
      );
    });

  });
}

// MockAuthProvider class (optimized)
class NotInitializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isInitialized = false;
  bool get isInitialized => _isInitialized;

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if (!isInitialized) throw NotInitializedException();
    await Future.delayed(const Duration(seconds: 1));

    if (email == 'invalid-email-format') throw InvalidEmailAuthException();
    if (email == 'medaminekoubaa4@gmail.com') throw UserNotFoundAuthException();
    if (password == 'amine123') throw WrongPasswordAuthException();

    _user = AuthUser(isEmailVerified: false);
    return _user!;
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) async {
    if (!isInitialized) throw NotInitializedException();
    if (email == 'unknownuser@gmail.com') throw UserNotFoundAuthException();
    if (password == 'wrongpassword') throw WrongPasswordAuthException();
    _user = AuthUser(isEmailVerified: false);
    return _user!;
  }

  @override
  Future<void> logOut() async {
    if (!isInitialized) throw NotInitializedException();
    if (_user == null) throw UserNotLoggedInAuthException();
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isInitialized) throw NotInitializedException();
    final user = _user;
    if (user == null) throw UserNotLoggedInAuthException();
    _user = AuthUser(isEmailVerified: true);
  }
}
