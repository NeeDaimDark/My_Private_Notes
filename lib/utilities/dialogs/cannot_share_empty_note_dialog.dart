import 'package:flutter/material.dart';
import 'package:Nuvio/utilities/dialogs/generic_dialogs.dart';


Future<void> showCannotShareEmptyNoteDialog(BuildContext context) async {
 return showGenericDialog(
     context: context,
     title: 'Sharing',
     content: 'You cannot share an empty note.',
     optionsBuilder: () => {
         'OK': null,
     },
 );
}