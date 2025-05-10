

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myprivatenotes/constants/routes.dart';

import 'dart:developer' as devtools show log;


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
                final userCredential = await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                    email: email,
                    password: password
                );
                devtools.log(userCredential.toString());
              } on FirebaseAuthException catch (e){
                if(e.code == 'weak-password') {
                  devtools.log('Weak password');
                }
                else if (e.code == 'email-already-in-use') {
                  devtools.log('this email is already in use');
                }
                else  if (e.code == 'invalid-email'){
                  devtools.log('Invalid email entrered');
                }

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



