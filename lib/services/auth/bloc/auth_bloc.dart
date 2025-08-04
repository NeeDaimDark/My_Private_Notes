import 'package:bloc/bloc.dart';
import 'package:myprivatenotes/services/auth/bloc/auth_state.dart';
import '../auth_provider.dart';
import 'auth_events.dart';

class AuthBloc extends Bloc <AuthEvent,AuthState>{
  AuthBloc(AuthProvider provider) : super (const AuthStateUninitialized(isLoading: true)) {
    //SEND EMAIL VERIFICATION
    on<AuthEventSendEmailVerification>((event, emit) async {
      await provider.sendEmailVerification();
      emit(state);

    });
    //forgot password
    on<AuthEventForgotPassword>((event, emit) async {
      emit(const AuthStateForgotPassword(
        exception: null,
        hasSentEmail: false,
        isLoading: true,
      ));

      final email = event.email;
      if (email == null) {
        emit(const AuthStateForgotPassword(
          exception: null,
          hasSentEmail: false,
          isLoading: false,
        ));
        return;
      }

      try {
        await provider.sendPasswordReset(toEmail: email);
        emit(const AuthStateForgotPassword(
          exception: null,
          hasSentEmail: true,
          isLoading: false,
        ));
      } on Exception catch (e) {
        emit(AuthStateForgotPassword(
          exception: e,
          hasSentEmail: false,
          isLoading: false,
        ));
      }
    });

    on<AuthEventShouldRegister>((event, emit) {
      emit(const AuthStateRegistering(
        exception: null,
        isLoading: false,
      ));
    });
    //register
    on<AuthEventRegister>((event, emit) async {
      final email = event.email;
      final password = event.password;
      try {
        await provider.createUser(
          email: email,
          password: password,
        );
        await provider.sendEmailVerification();
        emit(const AuthStateNeedsVerification(isLoading: false));
        
      } on Exception catch (e) {
        emit(AuthStateRegistering(
          exception: e,
          isLoading: false,
        ));
      }
    });
    //initialize
    on<AuthEventInitialize>((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;
      if (user == null) {
        emit(const AuthStateLoggedOut(
            exception: null,
            isLoading: false,
        ));
      } else if (!user.isEmailVerified) {
        emit(const AuthStateNeedsVerification(isLoading: false));
      } else {
        emit(AuthStateLoggedIn(
            user:user,
            isLoading: false,
        ));
      }
    });
    //log in
    on<AuthEventLogIn>((event, emit) async {
      emit(const AuthStateLoggedOut(
          exception: null,
          isLoading: true,
          loadingText: 'Please wait while we log you in...',
      ));
      final email = event.email;
      final password = event.password;
      try {
        final user = await provider.logIn(
          email: email,
          password: password,
        );
        emit(AuthStateLoggedIn(
            user:user,
            isLoading: false,
        ));
        if (!user.isEmailVerified) {
          emit(const AuthStateLoggedOut(
              exception: null,
              isLoading: false
          ));
          emit(const AuthStateNeedsVerification(
            isLoading: false,
          ));
        }else {
          emit (const AuthStateLoggedOut(
              exception: null,
              isLoading: false,
          ));
          emit(AuthStateLoggedIn(
              user:user,
              isLoading: false
          ));
        }
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(
            exception: e,
            isLoading: false,
        ));
      }
    });


    //log out
    on<AuthEventLogOut>((event , emit) async {

      try {

        await provider.logOut();
        emit(const AuthStateLoggedOut(
            exception: null,
            isLoading: false,
        ));
      }on Exception catch (e) {
        emit(AuthStateLoggedOut(
            exception: e,
            isLoading: false,
        ));
      }
    });
  }

}