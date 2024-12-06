import 'package:flutter/material.dart';
import 'package:ubify/core/configs/theme/app_colors.dart';

class AppTheme {
  //dk theme and light theme
  static final lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.lightBackground,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(),
    ),
  );
}
