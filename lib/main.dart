import 'package:flutter/material.dart';

import 'common/themes/themes.dart' as themes;
import 'common/screens/landing_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Turcu BMI Calculator',
      theme: themes.MyAppThemes.lightTheme,
      darkTheme: themes.MyAppThemes.darkTheme,
      themeMode: ThemeMode.system,
      home: const LandingScreen(),
    );
  }
}

