import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myprivatenotes/services/auth/bloc/auth_bloc.dart';
import 'package:myprivatenotes/services/auth/bloc/auth_events.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "We've sent you an email verification link. Please check your inbox and verify your account.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              "If you haven't received the verification email yet, click the button below.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(
                  const AuthEventSendEmailVerification(),
                );
              },
              child: const Text('Resend Verification Email'),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(
                  const AuthEventLogOut(),
                );
              },
              child: const Text('Restart (Go back to Login)'),
            ),
          ],
        ),
      ),
    );
  }
}
