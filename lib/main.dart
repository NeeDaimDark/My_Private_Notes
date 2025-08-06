import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Nuvio/helpers/loading/loading_screen.dart';
import 'package:Nuvio/services/auth/bloc/auth_bloc.dart';
import 'package:Nuvio/services/auth/bloc/auth_events.dart';
import 'package:Nuvio/services/auth/bloc/auth_state.dart';
import 'package:Nuvio/services/auth/firebase_auth_provider.dart';
import 'package:Nuvio/views/forgot_password_view.dart';
import 'package:Nuvio/views/notes/notes_view.dart';
import 'package:Nuvio/views/notes/create_update_note_view.dart';
import 'package:Nuvio/views/login_view.dart';
import 'package:Nuvio/views/register_view.dart';
import 'package:Nuvio/views/verify_email_view.dart';
import 'package:Nuvio/constants/routes.dart';
import '../L10n/app_localizations.dart'; // si le fichier est dans views/


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(FirebaseAuthProvider()),
      child: MaterialApp(
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        title: 'Private Notes',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        ),
        home: const HomePage(),
        routes: {

          CreateOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the authentication BLoC
    context.read<AuthBloc>().add(const AuthEventInitialize());

    return BlocConsumer<AuthBloc,AuthState>(
        listener:(context,state){
          if (state.isLoading){
            LoadingScreen().show(context: context, text: state.loadingText ?? 'Loading...');
          }else{
            LoadingScreen().hide();
          }

        },

      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const NotesView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        }else if(state is AuthStateForgotPassword){
          return const ForgotPasswordView();
        }else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailView();
        }else if (state is AuthStateRegistering){
          return const RegisterView();
        }
        else {
          // Default loading screen
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },

    );
  }
}
