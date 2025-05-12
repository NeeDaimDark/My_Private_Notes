
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;
import 'package:myprivatenotes/constants/routes.dart';
import 'package:myprivatenotes/services/auth/auth_user.dart';
import 'package:myprivatenotes/utilities/show_error_dialog.dart';

import 'package:myprivatenotes/services/auth/auth_service.dart';
import 'package:myprivatenotes/services/auth/auth_exceptions.dart';

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
                AuthService.firebase().logIn(
                    email: email,
                    password: password
                );

                final user = AuthService.firebase().currentUser;

                if (user?.isEmailVerified ?? false){
                  //user email verified
                  Navigator.of(context).pushNamedAndRemoveUntil(notesRoute, (route) => false);


                }else {
                  //user email not verified
                  Navigator.of(context).pushNamedAndRemoveUntil(emailVerifyRoute, (route) => false);

                }
              }on UserNotFoundAuthException {
                await showErrorDialog(
                    context,
                    'User not found. Please register first.',
                );
              }on WrongPasswordAuthException{
                await showErrorDialog
                  (context,
                    'Incorrect password. Please try again.',
                );
              }on InvalidEmailAuthException{
                 await showErrorDialog(
                     context,
                     'Invalid email format. Please enter a valid email.',
                 );
              }on InvalidCredentialAuthException{
                await showErrorDialog(
                    context,
                    'The email or password is incorrect.',
                );
              }on GenericAuthException {
                await showErrorDialog(
                  context,
                  'An unknown error occurred. Please try again.',
                );
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
