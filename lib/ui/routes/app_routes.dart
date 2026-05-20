import 'package:flutter/material.dart';

class AppRoutes {
  AppRoutes._();

  // Chave global que dá acesso ao Navigator do MaterialApp de qualquer lugar do app
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static const String splash = '/';
  static const String example = '/example';
  static const String appUnavailable = '/app_unavailable';
}
