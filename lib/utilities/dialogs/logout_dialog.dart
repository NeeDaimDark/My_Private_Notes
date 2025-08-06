import 'package:flutter/material.dart';
import 'package:Nuvio/L10n/app_localizations.dart';
import 'generic_dialogs.dart';

Future<bool> showLogOutDialog(BuildContext context) {
  final loc = AppLocalizations.of(context)!;

  return showGenericDialog<bool>(
    context: context,
    title: loc.notes_popup_logout,
    content: loc.logout_confirmation,
    optionsBuilder: () => {
      loc.cancel: false,
      loc.notes_popup_logout: true,
    },
  ).then((value) => value ?? false);
}
