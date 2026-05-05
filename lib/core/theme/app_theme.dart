import 'package:flutter/material.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/style/app_text_style.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.scaffoldBackground,

      // Цветовая схема приложения
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryOrange,
        onPrimary: AppColors.textOnOrange,
        secondary: AppColors.deepBlack,
        onSecondary: Colors.white,
        surface: AppColors.surfaceWhite,
        onSurface: AppColors.textPrimary,
        error: Colors.redAccent,
        onError: Colors.white,
      ),

      // Тема для AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.scaffoldBackground,
        foregroundColor: AppColors.deepBlack,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextStyles.h2,
        iconTheme: const IconThemeData(color: AppColors.deepBlack),
      ),

      // Тема для кнопок
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryOrange,
          foregroundColor: AppColors.textOnOrange,
          textStyle: AppTextStyles.button,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),

      // Тема для текстовых полей (InputDecoration)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceWhite,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryOrange, width: 2),
        ),
        labelStyle: AppTextStyles.caption,
      ),

      // Глобальная тема текста
      textTheme: TextTheme(
        displayLarge: AppTextStyles.h1,
        headlineMedium: AppTextStyles.h2,
        bodyLarge: AppTextStyles.body,
        bodyMedium: AppTextStyles.body,
        bodySmall: AppTextStyles.caption,
      ),
    );
  }
}
