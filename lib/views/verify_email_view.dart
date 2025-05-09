import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myprivatenotes/firebase_options.dart';


class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Verify email'),
        backgroundColor: Colors.blue,

      ),
      body: Column(
        children: [
          Text('Please Verify your email adress :'),
          TextButton(onPressed: () async {
            final user = FirebaseAuth.instance.currentUser;
            await  user?.sendEmailVerification();
          }, child: const Text('Send email Verification'))
        ],
      ),
    );



  }
}
