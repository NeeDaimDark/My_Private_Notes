
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as devtools show log;
import 'package:myprivatenotes/constants/routes.dart';
import 'package:myprivatenotes/utilities/show_error_dialog.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.blue,

      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
                hintText: 'Please Enter Your Email Here'
            ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
                hintText: 'Please Enter Your Password Here'
            ),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text.trim();
              final password = _password.text;
              try {
                final userCredential = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                devtools.log(userCredential.toString());
                Navigator.of(context).pushNamedAndRemoveUntil(notesRoute, (route) => false);
              } on FirebaseAuthException catch (e) {
                devtools.log('Firebase Error: ${e.code}');
                switch (e.code) {
                  case 'user-not-found':
                    await showErrorDialog(context, 'User not found. Please register first.');
                    break;
                  case 'wrong-password':
                    await showErrorDialog(context, 'Incorrect password. Please try again.');
                    break;
                  case 'invalid-email':
                    await showErrorDialog(context, 'Invalid email format. Please enter a valid email.');
                    break;
                  case 'invalid-credential':
                    await showErrorDialog(context, 'The email or password is incorrect.');
                    break;
                  default:
                    await showErrorDialog(context, 'An unknown error occurred. Please try again.');
                    break;
                }
              } catch (e) {
                devtools.log('Unknown Error: $e');
                await showErrorDialog(context, 'An unexpected error occurred. Please try again.');
              }
            },
            child: const Text('Login'),
          ),

          TextButton(onPressed: ()  { 
            Navigator.of(context).pushNamedAndRemoveUntil(registerRoute, (route) => false);
          },
              child: const Text('Not Register yet ? Register Here!'))
        ],
      ),
    );
  }
}
