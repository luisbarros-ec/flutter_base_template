import '/data/exceptions/app_exceptions.dart';
import '../language/controller/language_controller.dart';

extension ExceptionTranslation on Exception {
  String get userMessage {
    return switch (this) {
      ServerConnectionException() =>
        LanguageController.language.errorMessagesTexts.errorServerConnection,

      ServerTimeoutException() =>
        LanguageController.language.errorMessagesTexts.errorServerTimeout,

      // O '_' é o fallback (cai aqui se for uma Exception genérica que você não mapeou)
      _ => "Ops! Algo deu errado. Tente novamente mais tarde.",
    };
  }
}
