import 'package:flutter/material.dart';
import 'screens/shared/onboarding_screen.dart';
import 'screens/shared/splashscreen.dart';
void main() {
  runApp(const PharmaFinderApp());
}

class PharmaFinderApp extends StatelessWidget {
  const PharmaFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PharmaFinder',
      theme: ThemeData(
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}