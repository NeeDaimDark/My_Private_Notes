import 'package:flutter/material.dart';
import 'package:myprivatenotes/constants/routes.dart';
import 'package:myprivatenotes/services/auth/auth_service.dart';
import 'package:myprivatenotes/services/auth/auth_exceptions.dart';
import 'dart:developer' as devtools show log;

import '../utilities/dialogs/error_dialog.dart';


class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}


class _RegisterViewState extends State<RegisterView> {
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
        
        title: const Text('Register'),
        backgroundColor: Colors.blue,




      ),
      body: Column(

        children :[
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
            onPressed: () async{

              final email = _email.text;
              final password =_password.text;
              try {
                await AuthService.firebase().createUser(email: email, password: password);
                AuthService.firebase().sendEmailVerification();
                Navigator.of(context).pushNamed(emailVerifyRoute);
              }on WeakPasswordAuthException {
                await showErrorDialog(
                    context,
                    'The password is too weak. Please use a stronger password.',
                );

              }on EmailAlreadyInUseAuthException{
                await showErrorDialog(
                    context,
                    'This email is already registered. Please login instead.',
                );
              }on InvalidEmailAuthException {
                await showErrorDialog(
                    context,
                    'The email address is not valid. Please enter a valid email.',
                );

              }on GenericAuthException{
                await showErrorDialog(
                  context,
                  'An unknown error occurred. Please try again.',
                );
              }



            },
            child: const Text('Register'),
          ),
          TextButton(onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);

          }, child: const Text('Already Registred? Login Here!'))
        ],
      ),
    );
  }
}



