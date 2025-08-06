// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get login_title => 'Sign in';

  @override
  String get email_hint => 'Email';

  @override
  String get password_hint => 'Password';

  @override
  String get login_button => 'Sign in';

  @override
  String get forgot_password => 'Forgot password?';

  @override
  String get register_redirect => 'Not registered yet? Create an account';

  @override
  String get user_not_found => 'User not found.';

  @override
  String get wrong_password => 'Wrong password.';

  @override
  String get invalid_email => 'Invalid email format.';

  @override
  String get invalid_credentials => 'Incorrect credentials.';

  @override
  String get generic_error => 'Unknown error. Please try again.';

  @override
  String get register_title => 'Create an account';

  @override
  String get register_button => 'Create account';

  @override
  String get register_redirect_login => 'Already registered? Log in';

  @override
  String get weak_password => 'Password too weak.';

  @override
  String get email_already_used => 'Email already in use.';

  @override
  String get register_invalid_email => 'Invalid email address.';

  @override
  String get register_generic_error => 'Unknown error. Please try again.';

  @override
  String get verify_email_title => 'Email verification';

  @override
  String get verify_email_heading => 'Verify your email';

  @override
  String get verify_email_description =>
      'A verification link has been sent to your email address. Please click on it to activate your account.';

  @override
  String get resend_info =>
      'Didn\'t receive it? Click the button below to resend the link.';

  @override
  String get resend_button => 'Resend link';

  @override
  String get back_to_login => 'Back to login';

  @override
  String get forgot_password_title => 'Forgot password';

  @override
  String get forgot_password_heading => 'Reset your password';

  @override
  String get forgot_password_description =>
      'Enter your email address below. A reset link will be sent to you.';

  @override
  String get send_password_reset => 'Send password reset link';

  @override
  String get password_reset_error =>
      'Unable to process your request. Please make sure you are a registered user.';

  @override
  String get create_note_title => 'New note';

  @override
  String get create_note_hint => 'Write your note here...';

  @override
  String get cannot_share_empty_note => 'Cannot share an empty note.';

  @override
  String get note_share_subject => 'Check out this note!';

  @override
  String get notes_appbar_title => 'My Notes';

  @override
  String get notes_empty_message => 'No notes saved yet.';

  @override
  String get notes_popup_logout => 'Logout';

  @override
  String get note_empty_text => '(Empty note)';

  @override
  String get delete_note_confirmation =>
      'Are you sure you want to delete this note?';

  @override
  String get logout_confirmation => 'Are you sure you want to log out?';

  @override
  String get password_reset_sent =>
      'A password reset link has been sent to your email.';

  @override
  String get loading => 'Loading...';

  @override
  String get cancel => 'Cancel';

  @override
  String get sure => 'Sure';

  @override
  String get error_title => 'An Error Occurred';

  @override
  String get ok => 'OK';
}
