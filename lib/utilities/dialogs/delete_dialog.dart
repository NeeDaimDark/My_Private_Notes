import 'package:flutter/material.dart';
import 'generic_dialogs.dart';

Future<bool> showDeleteDialog(
    BuildContext context,

    )  {
  return showGenericDialog<bool>(
    context: context,
    title: 'Delete',
    content: 'Are you sure you want to delete this item ?',
    optionsBuilder: () => {
      'Cancel': false,
      'Sure': true,
    },
  )!.then(
          (value) => value ?? false
  );

}