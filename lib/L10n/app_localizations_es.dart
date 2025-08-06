// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get login_title => 'Iniciar sesión';

  @override
  String get email_hint => 'Correo electrónico';

  @override
  String get password_hint => 'Contraseña';

  @override
  String get login_button => 'Iniciar sesión';

  @override
  String get forgot_password => '¿Olvidaste tu contraseña?';

  @override
  String get register_redirect => '¿Aún no estás registrado? Crea una cuenta';

  @override
  String get user_not_found => 'Usuario no encontrado.';

  @override
  String get wrong_password => 'Contraseña incorrecta.';

  @override
  String get invalid_email => 'Formato de correo inválido.';

  @override
  String get invalid_credentials => 'Credenciales incorrectas.';

  @override
  String get generic_error => 'Error desconocido. Inténtalo de nuevo.';

  @override
  String get register_title => 'Crear una cuenta';

  @override
  String get register_button => 'Crear cuenta';

  @override
  String get register_redirect_login => '¿Ya tienes una cuenta? Inicia sesión';

  @override
  String get weak_password => 'Contraseña demasiado débil.';

  @override
  String get email_already_used => 'Correo ya en uso.';

  @override
  String get register_invalid_email => 'Correo electrónico inválido.';

  @override
  String get register_generic_error => 'Error desconocido. Inténtalo de nuevo.';

  @override
  String get verify_email_title => 'Verificación de correo';

  @override
  String get verify_email_heading => 'Verifica tu correo';

  @override
  String get verify_email_description =>
      'Se ha enviado un enlace de verificación a tu dirección de correo. Haz clic en él para activar tu cuenta.';

  @override
  String get resend_info =>
      '¿No lo has recibido? Haz clic en el botón de abajo para reenviarlo.';

  @override
  String get resend_button => 'Reenviar enlace';

  @override
  String get back_to_login => 'Volver a iniciar sesión';

  @override
  String get forgot_password_title => 'Contraseña olvidada';

  @override
  String get forgot_password_heading => 'Restablecer la contraseña';

  @override
  String get forgot_password_description =>
      'Introduce tu dirección de correo electrónico. Se te enviará un enlace de restablecimiento.';

  @override
  String get send_password_reset => 'Enviar enlace de restablecimiento';

  @override
  String get password_reset_error =>
      'No se pudo procesar la solicitud. Asegúrate de estar registrado.';

  @override
  String get create_note_title => 'Nueva nota';

  @override
  String get create_note_hint => 'Escribe tu nota aquí...';

  @override
  String get cannot_share_empty_note => 'No se puede compartir una nota vacía.';

  @override
  String get note_share_subject => '¡Mira esta nota!';

  @override
  String get notes_appbar_title => 'Mis Notas';

  @override
  String get notes_empty_message => 'Aún no hay notas guardadas.';

  @override
  String get notes_popup_logout => 'Cerrar sesión';

  @override
  String get note_empty_text => '(Nota vacía)';

  @override
  String get delete_note_confirmation =>
      '¿Estás seguro de que deseas eliminar esta nota?';

  @override
  String get logout_confirmation =>
      '¿Estás seguro de que deseas cerrar sesión?';

  @override
  String get password_reset_sent =>
      'Se ha enviado un enlace de restablecimiento de contraseña.';

  @override
  String get loading => 'Cargando...';

  @override
  String get cancel => 'Cancelar';

  @override
  String get sure => 'Sí';

  @override
  String get error_title => 'Ha ocurrido un error';

  @override
  String get ok => 'OK';
}
