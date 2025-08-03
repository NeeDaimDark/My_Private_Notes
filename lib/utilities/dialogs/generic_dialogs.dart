import 'package:flutter/material.dart';

typedef DialogOptionBuilder<T> = Map<String, T?> Function();

Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOptionBuilder<T> optionsBuilder,
}) {
  final options = optionsBuilder();
  return showDialog<T>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: options.entries.map((entry) {
          final String optionTitle = entry.key;
          final T? value = entry.value;
          return TextButton(
            onPressed: () {
              Navigator.of(context).pop(value);
            },
            child: Text(optionTitle),
          );
        }).toList(),
      );
    },
  );
}
