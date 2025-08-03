
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as devtools show log;
import 'package:myprivatenotes/constants/routes.dart';
import 'package:myprivatenotes/services/auth/auth_user.dart';

import 'package:myprivatenotes/services/auth/auth_service.dart';
import 'package:myprivatenotes/services/auth/auth_exceptions.dart';
import 'package:myprivatenotes/services/auth/bloc/auth_bloc.dart';
import 'package:myprivatenotes/services/auth/bloc/auth_events.dart';

import '../services/auth/bloc/auth_state.dart';
import '../utilities/dialogs/error_dialog.dart';

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
          BlocListener<AuthBloc,AuthState>(
            listener : (context,state){
              if(state is AuthStateLoggedOut){
                if (state.exception is UserNotFoundAuthException) {
                  showErrorDialog(
                    context,
                    'User not found. Please register first.',
                  );
                } else if (state.exception is WrongPasswordAuthException) {
                  showErrorDialog(
                    context,
                    'Wrong Credentials! Please try again.',
                  );
                } else if (state.exception is InvalidEmailAuthException) {
                  showErrorDialog(
                    context,
                    'Invalid email format. Please enter a valid email.',
                  );
                } else if (state.exception is InvalidCredentialAuthException) {
                  showErrorDialog(
                    context,
                    'The email or password is incorrect.',
                  );
                } else if (state.exception is GenericAuthException) {
                  showErrorDialog(
                    context,
                    'An unknown error occurred. Please try again.',
                  );
                }
              }
            },
            child: TextButton(
              onPressed: () async {
                final email = _email.text.trim();
                final password = _password.text;
                context.read<AuthBloc>().add(
                  AuthEventLogIn(email, password),
                );

              },
              child: const Text('Login'),
            ),
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
