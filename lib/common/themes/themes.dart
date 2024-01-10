import 'package:flutter/material.dart';

class MyAppColors {
  static const darkBlue = Color(0xFF1E1E2C);
  static const darkerBlue = Color.fromARGB(255, 15, 15, 21);
  static const contrastDarkBlue = Color.fromARGB(255, 157, 157, 196);
  static const lightBlue = Color(0xFF2D2D44);
  static const lighterBlue = Color.fromARGB(255, 68, 68, 101);
}


class MyAppThemes {
  static final lightTheme = ThemeData(
    primaryColor: MyAppColors.lightBlue,
    brightness: Brightness.light,
  );

  static final darkTheme = ThemeData(
    primaryColor: MyAppColors.darkBlue,
    brightness: Brightness.dark,
  );
}