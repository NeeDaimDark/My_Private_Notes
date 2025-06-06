
import 'package:flutter/material.dart';
import 'package:myprivatenotes/constants/routes.dart';
import 'package:myprivatenotes/services/auth/auth_service.dart';




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
          Text("we've sent you an email of verification, please check your inbox and verify your account"),
          Text("If you haven't recieved an email of verification click the button below"),
          TextButton(
              onPressed: () async {
               await AuthService.firebase().sendEmailVerification();
          }, child: const Text('Send email Verification')
          ),
          TextButton(
              onPressed: () async {
                await AuthService.firebase().logOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    registerRoute,
                        (route)=>false);

          },
              child: const Text('Restart')
          )
        ],
      ),
    );



  }
}
