import 'package:flutter/material.dart';
import 'package:meta_lms/utils/AppColors.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    backgroundColor: AppColors.backgroundColorLight,
    scaffoldBackgroundColor: AppColors.backgroundColorLight,
    iconTheme: const IconThemeData(color: AppColors.iconColorLight),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColors.textColorLight),
    ),
    cardColor: AppColors.surfaceColorLight,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    backgroundColor: AppColors.backgroundColorDark,
    scaffoldBackgroundColor: AppColors.backgroundColorDark,
    iconTheme: const IconThemeData(color: AppColors.iconColorDark),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColors.textColorDark),
    ),
    cardColor: AppColors.surfaceColorDark,
  );
}
