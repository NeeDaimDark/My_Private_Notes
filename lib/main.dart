import 'dart:ffi';


import 'package:flutter/material.dart';
import 'package:myprivatenotes/services/auth/auth_service.dart';
import 'package:myprivatenotes/views/notes/notes_view.dart';
import 'package:myprivatenotes/views/notes/create_update_note_view.dart';
import 'package:myprivatenotes/views/login_view.dart';
import 'package:myprivatenotes/views/register_view.dart';
import 'package:myprivatenotes/views/verify_email_view.dart';
import 'dart:developer' as devtools show log;
import 'package:myprivatenotes/constants/routes.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
      routes: {
        loginRoute : (context) => const LoginView(),
        registerRoute : (context) => const RegisterView(),
        emailVerifyRoute : (context) => const VerifyEmailView(),
        notesRoute : (context) => const NotesView(),
        CreateOrUpdateNoteRoute : (context) => const CreateUpdateNoteView(),

      },
    );
  }
}
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
          future: AuthService.firebase().initialize(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
              final user = AuthService.firebase().currentUser;
              if (user != null){
                if(user.isEmailVerified){
                  return const NotesView();

                }
                else{
                  return const VerifyEmailView();

                }
              }
              else {return const LoginView();}

              default:
                return const CircularProgressIndicator();
            }
          },

        );
  }
}




