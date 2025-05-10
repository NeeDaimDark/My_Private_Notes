

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myprivatenotes/constants/routes.dart';

import 'dart:developer' as devtools show log;
import 'package:myprivatenotes/utilities/show_error_dialog.dart';


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
                await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                    email: email,
                    password: password
                );
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
                Navigator.of(context).pushNamed(emailVerifyRoute);
              } on FirebaseAuthException catch (e){
                switch (e.code) {
                  case 'weak-password':
                    await showErrorDialog(
                    context, 'The password is too weak. Please use a stronger password.');
                    break;
                  case 'email-already-in-use':
                    await showErrorDialog(
                    context, 'This email is already registered. Please login instead.');
                    break;
                  case 'invalid-email':
                    await showErrorDialog(
                    context, 'The email address is not valid. Please enter a valid email.');
                    break;
                  case 'operation-not-allowed':
                    await showErrorDialog(
                    context, 'Registration is disabled for this app.');
                    break;
                  default:
                    await showErrorDialog(
                    context, 'An unknown error occurred. Please try again.');
                    break;
                }
              } catch (e) {
                devtools.log('Unknown Error: $e');
                await showErrorDialog(
                context, 'An unexpected error occurred. Please try again.');


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



