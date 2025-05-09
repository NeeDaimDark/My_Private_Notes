
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myprivatenotes/firebase_options.dart';

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
      appBar: AppBar(title:const Text('Register'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder:(context,snapshot){
          switch(snapshot.connectionState){

            case ConnectionState.done:
              return Column(
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
                        print(userCredential);
                      } on FirebaseAuthException catch (e){
                        if(e.code == 'weak-password') {
                          print('Weak password');
                        }
                        else if (e.code == 'email-already-in-use') {
                          print('this email is already in use');
                        }
                        else  if (e.code == 'invalid-email'){
                          print('Invalid email entrered');
                        }

                      }
                    },
                    child: const Text('Register'),
                  ),
                ],
              );
            default:
              return const Text('loading...');

          }
        },

      ),
    );
  }
}



