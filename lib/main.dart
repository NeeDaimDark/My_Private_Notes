import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myprivatenotes/views/login_view.dart';
import 'package:myprivatenotes/views/register_view.dart';
import 'package:myprivatenotes/views/verify_email_view.dart';
import 'dart:developer' as devtools show log;
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
        '/login/' : (context) => const LoginView(),
        '/register/' : (context) => const RegisterView(),
        '/verifyEmail/' : (context) => const VerifyEmailView(),
        '/notes/' : (context) => const NotesView(),

      },
    );
  }
}
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              if (user != null){
                if(user.emailVerified){
                  return const NotesView();

                }
                else{
                  return const VerifyEmailView();

                }
              }
              else {return const LoginView();}
              return const Text('done');
             /* final emailVerified = user?.emailVerified ?? false;
              if(emailVerified){
                print('You are a verified user');
                return const Text('Done');
              }else {
                print('you need to verify your email first');
                return VerifyEmailView() ;
              }*/

              default:
                return const CircularProgressIndicator();
            }
          },

        );
  }
}
enum MenuAction {logout}
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
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil('/login/', (_)=> false,
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



