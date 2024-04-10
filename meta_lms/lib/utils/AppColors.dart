import 'package:flutter/material.dart';

class AppColors {
  static const primaryColor = Color(0xFF4F46E5);
  static const primaryVariantColor = Color(0xFF3700B3);
  static const secondaryColor = Color(0xFF03DAC6);
  static const secondaryVariantColor = Color(0xFF018786);
  static const backgroundColor = Color(0xFFFFFFFF);
  static const surfaceColor = Color.fromARGB(255, 246, 246, 246);
  static const errorColor = Color(0xFFB00020);
  static const onPrimaryColor = Color.fromARGB(255, 182, 182, 182);
  static const onSecondaryColor = Color(0xFF000000);
  static const onBackgroundColor = Color(0xFF000000);
  static const onSurfaceColor = Color(0xFF000000);
  static const onErrorColor = Color(0xFFFFFFFF);

  static const textColor = Color.fromARGB(255, 88, 88, 88);
  static const dividerColor = Color.fromARGB(255, 93, 93, 93);

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
