import 'package:flutter/material.dart';
import 'generic_dialogs.dart';

Future<void> showErrorDialog(
    BuildContext context,
    String text,
) async {
  return showGenericDialog <void> (
    context: context,
    title: 'An Error Occurred',
    content: text,
    optionsBuilder: () => {
      'OK': null,
    },
  );
}