import 'package:flutter/material.dart';
import 'package:Nuvio/L10n/app_localizations.dart';
import 'generic_dialogs.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  final loc = AppLocalizations.of(context)!;

  return showGenericDialog<bool>(
    context: context,
    title: loc.delete_note_confirmation,
    content: loc.delete_note_confirmation,
    optionsBuilder: () => {
      loc.cancel: false,
      loc.sure: true,
    },
  ).then((value) => value ?? false);
}
