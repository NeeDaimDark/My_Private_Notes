import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myprivatenotes/constants/routes.dart';
import 'package:myprivatenotes/services/auth/auth_service.dart';
import 'package:myprivatenotes/services/auth/auth_exceptions.dart';
import 'dart:developer' as devtools show log;

import '../services/auth/bloc/auth_bloc.dart';
import '../services/auth/bloc/auth_events.dart';
import '../services/auth/bloc/auth_state.dart';
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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async{
        if (state is AuthStateRegistering){
          if (state.exception is WeakPasswordAuthException) {
             await showErrorDialog(
              context,
              'The password is too weak. Please use a stronger password.',
            );
          } else if (state.exception is EmailAlreadyInUseAuthException) {
            await showErrorDialog(
              context,
              'This email is already registered. Please login instead.',
            );
          } else if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(
              context,
              'The email address is not valid. Please enter a valid email.',
            );
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(
              context,
              'An unknown error occurred. Please try again.',
            );
          }
        }
      },


      child: Scaffold(
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
                context.read<AuthBloc>().add(
                  AuthEventRegister(email,password),
                );
                },
              child: const Text('Register'),
            ),
            TextButton(onPressed: () {
              context.read<AuthBloc>().add(
                const AuthEventLogOut(),
              );
      
            }, child: const Text('Already Registred? Login Here!'))
          ],
        ),
      ),
    );
  }
}



