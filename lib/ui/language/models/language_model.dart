import 'package:flutter/material.dart';

class LanguageModel {
  final Map<String, dynamic> _data;

  LanguageModel(this._data);

  // --- Getters Inteligentes (Preguiçosos) ---

  ConfigMessagesTexts get configMessagesText =>
      ConfigMessagesTexts.fromMap(_data.getMap('config_messages'));

  ErrorMessagesTexts get errorMessagesTexts =>
      ErrorMessagesTexts.fromMap(_data.getMap('error_messages'));

  SplashScreenTexts get splashScreenTexts =>
      SplashScreenTexts.fromMap(_data.getMap('splash_screen'));
}

extension MapSafeGetter on Map {
  Map<String, dynamic> getMap(String key) {
    if (this[key] == null) {
      debugPrint(
        "⚠️ Alerta: A chave '$key' não foi encontrada no dicionário de idiomas.",
      );
      return {};
    }
    return Map<String, dynamic>.from(this[key]);
  }

  String getString(String key, {String defaultValue = ''}) {
    if (this[key] == null) {
      debugPrint("⚠️ Alerta: O texto para a chave '$key' está faltando.");
      return defaultValue.isNotEmpty ? defaultValue : '!!$key!!';
    }
    return this[key].toString();
  }
}

class ConfigMessagesTexts {
  final String appUnavailableTitle;
  final String appUnavailableBody;
  final String appOutdatedTitle;
  final String appOutdatedBody;

  ConfigMessagesTexts({
    required this.appUnavailableTitle,
    required this.appUnavailableBody,
    required this.appOutdatedTitle,
    required this.appOutdatedBody,
  });

  factory ConfigMessagesTexts.fromMap(Map<String, dynamic> map) {
    return ConfigMessagesTexts(
      appUnavailableTitle: map.getString(
        'app_unavailable_title',
        defaultValue: 'Ops! App Indisponível',
      ),
      appUnavailableBody: map.getString('app_unavailable_body'),
      appOutdatedTitle: map.getString(
        'app_outdated_title',
        defaultValue: 'Atualização Necessária',
      ),
      appOutdatedBody: map.getString('app_outdated_body'),
    );
  }
}

class ErrorMessagesTexts {
  final String errorServerConnection;
  final String errorServerTimeout;
  final String localizationOff;

  ErrorMessagesTexts({
    required this.errorServerConnection,
    required this.errorServerTimeout,
    required this.localizationOff,
  });

  factory ErrorMessagesTexts.fromMap(Map<String, dynamic> map) {
    return ErrorMessagesTexts(
      errorServerConnection: map.getString(
        'error_server_connection',
        defaultValue: 'Falha na conexão com o servidor.',
      ),
      errorServerTimeout: map.getString(
        'error_server_timeout',
        defaultValue: 'Tempo limite esgotado.',
      ),
      localizationOff: map.getString('localization_off'),
    );
  }
}

class SplashScreenTexts {
  final String welcomeMessage;

  SplashScreenTexts({required this.welcomeMessage});

  factory SplashScreenTexts.fromMap(Map<String, dynamic> map) {
    return SplashScreenTexts(welcomeMessage: map.getString('welcome_message'));
  }
}
