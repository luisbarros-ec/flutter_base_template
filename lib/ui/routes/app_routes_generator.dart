import 'package:flutter/material.dart';
import '/ui/routes/app_routes.dart';
import '/ui/screens/app_unavailable_screen/app_unavailable_screen.dart';
import '/ui/screens/example_screen/example_screen.dart';
import '/ui/screens/splash_screen/splash_screen.dart';

class AppRoutesGenerator {
  AppRoutesGenerator._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    // Caso uma tela precise receber argumentos no futuro, descomente essa linha
    //final args = settings.arguments;

    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );

      case AppRoutes.example:
        return MaterialPageRoute(
          builder: (_) => const ExampleScreen(),
          settings: settings,
        );

      case AppRoutes.appUnavailable:
        return MaterialPageRoute(
          builder: (_) => AppUnavailableScreen(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Rota não encontrada: ${settings.name}')),
          ),
        );
    }
  }
}
