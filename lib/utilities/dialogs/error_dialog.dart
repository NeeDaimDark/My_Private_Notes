import 'package:flutter/material.dart';
import 'package:Nuvio/L10n/app_localizations.dart';
import 'generic_dialogs.dart';

Future<void> showErrorDialog(
    BuildContext context,
    String text,
    ) {
  final loc = AppLocalizations.of(context)!;

  return showGenericDialog<void>(
    context: context,
    title: loc.error_title,
    content: text,
    optionsBuilder: () => {
      loc.ok: null,
    },
  );
}
