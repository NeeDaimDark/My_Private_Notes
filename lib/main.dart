import 'dart:ffi';


import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController _textController;

  @override
  void initState() {
     _textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create:(context) => CounterBloc(),
        child : Scaffold(
          appBar: AppBar(
            title: const Text('Counter Bloc Example'),
          ),
          body : BlocConsumer<CounterBloc, CounterState>(
            listener: (context, state){
              _textController.clear();

            },
            builder: (context,state){
              final invalidValue = (state is CounterStateInvalidNumber) ?
              state.invalidValue : '';
              return Column(
                children: [
                  Text('current value: ${state.value}'),
                  Visibility(child: Text('Invalid input: $invalidValue'),
                    visible: state is CounterStateInvalidNumber,
                  ),
                  TextField(controller: _textController,
                  decoration:  const InputDecoration(
                    hintText: 'Enter a number',
                  ),
                    keyboardType: TextInputType.number,
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: (){
                          context.read<CounterBloc>().add(
                            DecrementCounterEvent(_textController.text),
                          );
                        },
                        child: const Text('-'),
                      ),
                      TextButton(onPressed: (){
                        context.read<CounterBloc>().add(
                          IncrementCounterEvent(_textController.text),
                        );
                      },
                          child: const Text('+'),
                      )
                    ],
                  )
                ],
              );
            },
          ),
        )
    );
  }
}
@immutable
abstract class CounterState {
  final int value;
  const CounterState(this.value);
}

class CounterStateValid extends CounterState {
  const CounterStateValid(int value) : super(value);
}
class CounterStateInvalidNumber extends CounterState {
  final String invalidValue;

  const CounterStateInvalidNumber({
    required this.invalidValue,
    required int previousValue,
  }) : super(previousValue);
}

@immutable
abstract class CounterEvent {
  final String value;
  const CounterEvent(this.value);
}

class IncrementCounterEvent extends CounterEvent {
  const IncrementCounterEvent(String value) : super(value);
}

class DecrementCounterEvent extends CounterEvent {
  const DecrementCounterEvent(String value) : super(value);
}

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterStateValid(0)) {
    on<IncrementCounterEvent>((event, emit) {
      final integer = int.tryParse(event.value);
      if (integer == null) {
        emit(CounterStateInvalidNumber(
          invalidValue: event.value,
          previousValue: state.value,
        ),
        );
      } else {
        emit(CounterStateValid(state.value + integer));
      }
    });
    on<DecrementCounterEvent>((event, emit) {
      final integer = int.tryParse(event.value);
      if (integer == null) {
        emit(CounterStateInvalidNumber(
          invalidValue: event.value,
          previousValue: state.value,
        ),
        );
      } else {
        emit(CounterStateValid(state.value - integer));
      }
    });
  }
}
/*class HomePage extends StatelessWidget {
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
}*/



