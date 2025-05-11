import 'dart:developer' as devtools show log;
import 'package:flutter/material.dart';
import '../constants/routes.dart';
import 'package:myprivatenotes/services/auth/auth_service.dart';
import '../enums/menu_actiom.dart' show MenuAction;

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My notes'),
        backgroundColor: Colors.blue,
        actions: [
          PopupMenuButton<MenuAction>(onSelected: (value) async {
            switch(value){
              case MenuAction.logout:
                final shouldLogout = await showLogOutDialog(context);
                devtools.log(shouldLogout.toString());
                if(shouldLogout){
                  AuthService.firebase().logOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (_)=> false,
                  );
                }
                break;


            }
          },itemBuilder: (context){
            return const  [
              PopupMenuItem<MenuAction>(
                value: MenuAction.logout,
                child: Text('Log Out'),
              ),
            ];
          },)
        ],

      ),
      body: const Text('Hello World'),
    );
  }
}
Future<bool> showLogOutDialog(BuildContext context)  {
  return showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: const Text('Sign Out'),
          content: const Text('Are you sure you want to sign out'),
          actions: [
            TextButton(onPressed:(){
              Navigator.of(context).pop(false);
            }, child: const Text('Cancel')),
            TextButton(onPressed: (){
              Navigator.of(context).pop(true);
            }, child: const Text('Log Out')),
          ],
        );
      }
  ).then((value)=> value ?? false);
}
