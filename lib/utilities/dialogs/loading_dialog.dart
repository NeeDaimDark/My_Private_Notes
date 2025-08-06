import 'package:flutter/material.dart';
import 'package:Nuvio/L10n/app_localizations.dart';

typedef CloseDialog = void Function();

CloseDialog showLoadingDialog({
  required BuildContext context,
  String? text,
}) {
  final loc = AppLocalizations.of(context)!;
  final loadingText = text ?? loc.loading;

  final dialog = AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: 16),
        Text(loadingText),
      ],
    ),
  );

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => dialog,
  );

  return () => Navigator.of(context).pop();
}
