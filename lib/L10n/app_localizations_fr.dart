// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get login_title => 'Connectez-vous';

  @override
  String get email_hint => 'Email';

  @override
  String get password_hint => 'Mot de passe';

  @override
  String get login_button => 'Se connecter';

  @override
  String get forgot_password => 'Mot de passe oublié ?';

  @override
  String get register_redirect => 'Pas encore inscrit ? Créez un compte';

  @override
  String get user_not_found => 'Utilisateur introuvable.';

  @override
  String get wrong_password => 'Mot de passe incorrect.';

  @override
  String get invalid_email => 'Format email invalide.';

  @override
  String get invalid_credentials => 'Identifiants incorrects.';

  @override
  String get generic_error => 'Erreur inconnue. Réessayez.';

  @override
  String get register_title => 'Créer un compte';

  @override
  String get register_button => 'Créer un compte';

  @override
  String get register_redirect_login => 'Déjà inscrit ? Se connecter';

  @override
  String get weak_password => 'Mot de passe trop faible.';

  @override
  String get email_already_used => 'Email déjà utilisé.';

  @override
  String get register_invalid_email => 'Adresse email invalide.';

  @override
  String get register_generic_error => 'Erreur inconnue. Veuillez réessayer.';

  @override
  String get verify_email_title => 'Vérification de l’email';

  @override
  String get verify_email_heading => 'Vérifiez votre email';

  @override
  String get verify_email_description =>
      'Un lien de vérification a été envoyé à votre adresse email. Veuillez cliquer sur ce lien pour activer votre compte.';

  @override
  String get resend_info =>
      'Vous ne l\'avez pas reçu ? Cliquez sur le bouton ci-dessous pour renvoyer le lien.';

  @override
  String get resend_button => 'Renvoyer le lien';

  @override
  String get back_to_login => 'Retour à la connexion';

  @override
  String get forgot_password_title => 'Mot de passe oublié';

  @override
  String get forgot_password_heading => 'Réinitialiser le mot de passe';

  @override
  String get forgot_password_description =>
      'Entrez votre adresse e-mail ci-dessous. Un lien de réinitialisation vous sera envoyé.';

  @override
  String get send_password_reset => 'Envoyer le lien de réinitialisation';

  @override
  String get password_reset_error =>
      'Impossible de traiter votre demande. Veuillez vérifier que vous êtes un utilisateur inscrit.';

  @override
  String get create_note_title => 'Nouvelle note';

  @override
  String get create_note_hint => 'Écrivez votre note ici...';

  @override
  String get cannot_share_empty_note => 'Impossible de partager une note vide.';

  @override
  String get note_share_subject => 'Découvrez cette note !';

  @override
  String get notes_appbar_title => 'Mes Notes';

  @override
  String get notes_empty_message => 'Aucune note enregistrée pour le moment.';

  @override
  String get notes_popup_logout => 'Déconnexion';

  @override
  String get note_empty_text => '(Note vide)';

  @override
  String get delete_note_confirmation =>
      'Êtes-vous sûr de vouloir supprimer cette note ?';

  @override
  String get logout_confirmation =>
      'Êtes-vous sûr de vouloir vous déconnecter ?';

  @override
  String get password_reset_sent =>
      'Un lien de réinitialisation a été envoyé à votre email.';

  @override
  String get loading => 'Chargement...';

  @override
  String get cancel => 'Annuler';

  @override
  String get sure => 'Oui';

  @override
  String get error_title => 'Une erreur s\'est produite';

  @override
  String get ok => 'OK';
}
