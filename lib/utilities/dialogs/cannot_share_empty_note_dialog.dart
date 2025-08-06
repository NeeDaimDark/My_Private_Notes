import 'package:flutter/material.dart';
import 'package:Nuvio/utilities/dialogs/generic_dialogs.dart';
import 'package:Nuvio/L10n/app_localizations.dart';

Future<void> showCannotShareEmptyNoteDialog(BuildContext context) async {
  final loc = AppLocalizations.of(context)!;
  return showGenericDialog(
    context: context,
    title: loc.note_share_subject,
    content: loc.cannot_share_empty_note,
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
