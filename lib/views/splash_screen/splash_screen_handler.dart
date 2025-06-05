import 'package:app_gcm_sa/views/login/login_view.dart';
import 'package:app_gcm_sa/views/splash_screen/splash_screen_view.dart';
import 'package:flutter/material.dart';

class SplashScreenHandler extends StatelessWidget {
  const SplashScreenHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      onInitializationComplete: () {
        // Navigate to your main screen after splash
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => LoginView()),
        );
      },
    );
  }
}