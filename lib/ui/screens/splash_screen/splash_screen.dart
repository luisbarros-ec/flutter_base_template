import 'package:flutter/material.dart';
import '/ui/routes/app_routes.dart';
import '/ui/language/controller/language_controller.dart';
import '/ui/theme/custom_text_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _startInitialization();
  }

  Future<void> _startInitialization() async {
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.example);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          LanguageController.language.splashScreenTexts.welcomeMessage,
          style: CustomTextStyles.largeTitle,
        ),
      ),
    );
  }
}
