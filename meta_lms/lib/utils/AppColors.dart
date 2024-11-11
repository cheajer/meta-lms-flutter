import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppColors {
  // Light Theme Colors
  static const Color primaryColor = Color(0xFF4F46E5);
  static const Color backgroundColorLight = Color.fromARGB(255, 228, 228, 228);
  static const Color surfaceColorLight = Color.fromARGB(255, 255, 255, 255);
  static const Color textColorLight = Color.fromARGB(255, 46, 46, 46);
  static const Color iconColorLight = Color(0xFF000000);

  // Dark Theme Colors
  static const Color backgroundColorDark = Color(0xFF121212);
  static const Color surfaceColorDark = Color(0xFF1F1B24);
  static const Color textColorDark = Color(0xFFFFFFFF);
  static const Color iconColorDark = Color(0xFFFFFFFF);

  static const Color textColor =  Color.fromARGB(255, 60, 60, 60);

  static MaterialColor createPrimaryMaterialColor() {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = primaryColor.red, g = primaryColor.green, b = primaryColor.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }

    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(primaryColor.value, swatch);
  }



}
