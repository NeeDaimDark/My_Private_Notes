import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myprivatenotes/firebase_options.dart';
import 'package:myprivatenotes/views/register_view.dart';

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
              final email = _email.text;
              final password = _password.text;
              try {
                final userCredential = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                    email: email,
                    password: password
                );
                print(userCredential);
              }on FirebaseAuthException catch (e){
                if(e.code == 'user-not-found') {
                  print('User not found');
                }
                else if (e.code == 'wrong-password') {
                  print('Wrong Password');
                }
                else  if (e.code == 'invalid-credential'){
                  print('wrong email or password');
                }
              }
            },
            child: const Text('Login'),
          ),
          TextButton(onPressed: ()  { 
            Navigator.of(context).pushNamedAndRemoveUntil('/Register/', (route) => false);
          },
              child: const Text('Not Register yet ? Register Here!'))
        ],
      ),
    );
  }

 
}