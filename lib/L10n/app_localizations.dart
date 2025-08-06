import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'L10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('fr'),
  ];

  /// No description provided for @login_title.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get login_title;

  /// No description provided for @email_hint.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email_hint;

  /// No description provided for @password_hint.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password_hint;

  /// No description provided for @login_button.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get login_button;

  /// No description provided for @forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgot_password;

  /// No description provided for @register_redirect.
  ///
  /// In en, this message translates to:
  /// **'Not registered yet? Create an account'**
  String get register_redirect;

  /// No description provided for @user_not_found.
  ///
  /// In en, this message translates to:
  /// **'User not found.'**
  String get user_not_found;

  /// No description provided for @wrong_password.
  ///
  /// In en, this message translates to:
  /// **'Wrong password.'**
  String get wrong_password;

  /// No description provided for @invalid_email.
  ///
  /// In en, this message translates to:
  /// **'Invalid email format.'**
  String get invalid_email;

  /// No description provided for @invalid_credentials.
  ///
  /// In en, this message translates to:
  /// **'Incorrect credentials.'**
  String get invalid_credentials;

  /// No description provided for @generic_error.
  ///
  /// In en, this message translates to:
  /// **'Unknown error. Please try again.'**
  String get generic_error;

  /// No description provided for @register_title.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get register_title;

  /// No description provided for @register_button.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get register_button;

  /// No description provided for @register_redirect_login.
  ///
  /// In en, this message translates to:
  /// **'Already registered? Log in'**
  String get register_redirect_login;

  /// No description provided for @weak_password.
  ///
  /// In en, this message translates to:
  /// **'Password too weak.'**
  String get weak_password;

  /// No description provided for @email_already_used.
  ///
  /// In en, this message translates to:
  /// **'Email already in use.'**
  String get email_already_used;

  /// No description provided for @register_invalid_email.
  ///
  /// In en, this message translates to:
  /// **'Invalid email address.'**
  String get register_invalid_email;

  /// No description provided for @register_generic_error.
  ///
  /// In en, this message translates to:
  /// **'Unknown error. Please try again.'**
  String get register_generic_error;

  /// No description provided for @verify_email_title.
  ///
  /// In en, this message translates to:
  /// **'Email verification'**
  String get verify_email_title;

  /// No description provided for @verify_email_heading.
  ///
  /// In en, this message translates to:
  /// **'Verify your email'**
  String get verify_email_heading;

  /// No description provided for @verify_email_description.
  ///
  /// In en, this message translates to:
  /// **'A verification link has been sent to your email address. Please click on it to activate your account.'**
  String get verify_email_description;

  /// No description provided for @resend_info.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive it? Click the button below to resend the link.'**
  String get resend_info;

  /// No description provided for @resend_button.
  ///
  /// In en, this message translates to:
  /// **'Resend link'**
  String get resend_button;

  /// No description provided for @back_to_login.
  ///
  /// In en, this message translates to:
  /// **'Back to login'**
  String get back_to_login;

  /// No description provided for @forgot_password_title.
  ///
  /// In en, this message translates to:
  /// **'Forgot password'**
  String get forgot_password_title;

  /// No description provided for @forgot_password_heading.
  ///
  /// In en, this message translates to:
  /// **'Reset your password'**
  String get forgot_password_heading;

  /// No description provided for @forgot_password_description.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address below. A reset link will be sent to you.'**
  String get forgot_password_description;

  /// No description provided for @send_password_reset.
  ///
  /// In en, this message translates to:
  /// **'Send password reset link'**
  String get send_password_reset;

  /// No description provided for @password_reset_error.
  ///
  /// In en, this message translates to:
  /// **'Unable to process your request. Please make sure you are a registered user.'**
  String get password_reset_error;

  /// No description provided for @create_note_title.
  ///
  /// In en, this message translates to:
  /// **'New note'**
  String get create_note_title;

  /// No description provided for @create_note_hint.
  ///
  /// In en, this message translates to:
  /// **'Write your note here...'**
  String get create_note_hint;

  /// No description provided for @cannot_share_empty_note.
  ///
  /// In en, this message translates to:
  /// **'Cannot share an empty note.'**
  String get cannot_share_empty_note;

  /// No description provided for @note_share_subject.
  ///
  /// In en, this message translates to:
  /// **'Check out this note!'**
  String get note_share_subject;

  /// No description provided for @notes_appbar_title.
  ///
  /// In en, this message translates to:
  /// **'My Notes'**
  String get notes_appbar_title;

  /// No description provided for @notes_empty_message.
  ///
  /// In en, this message translates to:
  /// **'No notes saved yet.'**
  String get notes_empty_message;

  /// No description provided for @notes_popup_logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get notes_popup_logout;

  /// No description provided for @note_empty_text.
  ///
  /// In en, this message translates to:
  /// **'(Empty note)'**
  String get note_empty_text;

  /// No description provided for @delete_note_confirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this note?'**
  String get delete_note_confirmation;

  /// No description provided for @logout_confirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get logout_confirmation;

  /// No description provided for @password_reset_sent.
  ///
  /// In en, this message translates to:
  /// **'A password reset link has been sent to your email.'**
  String get password_reset_sent;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @sure.
  ///
  /// In en, this message translates to:
  /// **'Sure'**
  String get sure;

  /// No description provided for @error_title.
  ///
  /// In en, this message translates to:
  /// **'An Error Occurred'**
  String get error_title;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
