import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/core/dependency_injection/dependency_injection.dart';
import '/ui/routes/app_routes.dart';
import '/ui/routes/app_routes_generator.dart';
import '/ui/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Trava a orientação da tela em retrato
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    // Trava a escala do texto para não ser afetada pelo tamanho da fonte do dispositivo
    Builder(
      builder: (context) {
        final mediaQueryData = MediaQuery.of(context);
        final mediaQueryDataWithLinearTextScaling = mediaQueryData.copyWith(
          textScaler: const TextScaler.linear(1),
        );
        return MediaQuery(
          data: mediaQueryDataWithLinearTextScaling,
          child: DependencyInjection(child: const MyApp()),
        );
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Template',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      navigatorKey: AppRoutes.navigatorKey,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRoutesGenerator.generateRoute,
    );
  }
}
