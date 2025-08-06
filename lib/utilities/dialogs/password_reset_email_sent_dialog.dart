import 'package:flutter/material.dart';
import 'package:Nuvio/L10n/app_localizations.dart';
import 'generic_dialogs.dart';

Future<void> showPasswordResetEmailSentDialog(BuildContext context) {
  final loc = AppLocalizations.of(context)!;

  return showGenericDialog<void>(
    context: context,
    title: loc.forgot_password_title,
    content: loc.password_reset_sent,
    optionsBuilder: () => {
      loc.ok: null,
    },
  );
}
