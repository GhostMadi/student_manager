import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_manager/core/colors/app_colors.dart';

class AppTextStyles {
  // Заголовок большой (например, для экранов приветствия)
  static TextStyle h1 = GoogleFonts.montserrat(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.deepBlack,
    letterSpacing: -0.5,
  );

  // Заголовок секции
  static TextStyle h2 = GoogleFonts.montserrat(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.deepBlack,
  );

  // Основной текст (Body)
  static TextStyle body = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
  );

  // Вторичный текст (подписи, мелкие детали)
  static TextStyle caption = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  // Стиль для оранжевых кнопок
  static TextStyle button = GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textOnOrange,
    letterSpacing: 1.1,
  );

  // Акцентный текст (оранжевый)
  static TextStyle accent = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryOrange,
  );
}
