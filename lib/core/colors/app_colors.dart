import 'package:flutter/material.dart';

class AppColors {
  // Основные цвета
  static const Color primaryOrange = Color(0xFFFF6B00); // Яркий акцентный оранжевый
  static const Color lightOrange = Color(0xFFFF9E5E); // Для градиентов или подсветки
  static const Color darkOrange = Color(0xFFE65100); // Для нажатых состояний (hover/pressed)

  // Фон и поверхности
  static const Color scaffoldBackground = Color(0xFFFFFFFF); // Чистый белый фон
  static const Color surfaceWhite = Color(0xFFF5F5F5); // Светло-серый для карточек

  // Черный и нейтральные
  static const Color deepBlack = Color(0xFF1A1A1A); // Мягкий черный (лучше для глаз, чем 000000)
  static const Color charcoal = Color(0xFF333333); // Для вторичного текста

  // Текст
  static const Color textPrimary = Color(0xFF1A1A1A); // Основной текст
  static const Color textSecondary = Color(0xFF757575); // Вспомогательный текст
  static const Color textOnOrange = Color(0xFFFFFFFF); // Текст на оранжевых кнопках
}
