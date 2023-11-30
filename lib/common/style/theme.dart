import 'package:flutter/material.dart';

class MyTheme {
  Color? primaryColor;
  ColorScheme? colorScheme;
  String? fontFamily;

  MyTheme({
    this.primaryColor,
    this.colorScheme,
  }) : assert(colorScheme == null || primaryColor == null);

  get lightThemeData {
    return ThemeData(
        useMaterial3: true, colorSchemeSeed: primaryColor, colorScheme: colorScheme, brightness: Brightness.light);
  }

  get darkThemeData {
    return ThemeData(
        useMaterial3: true,
        colorSchemeSeed: primaryColor,
        colorScheme: colorScheme?.copyWith(
          error: const Color.fromARGB(255, 255, 99, 71),
        ),
        brightness: Brightness.dark);
  }
}
