import 'package:flutter/material.dart';
import 'package:Nuvio/utilities/dialogs/generic_dialogs.dart';

Future<void> showPasswordResetEmailSentDialog(
  BuildContext context,
) {
  return showGenericDialog<void>(
      context: context,
      title: 'Password Reset',
      content: 'we have sent you a password reset link. Please check your email.',
      optionsBuilder: ()=> {
        'OK': null,
      },
  );
}