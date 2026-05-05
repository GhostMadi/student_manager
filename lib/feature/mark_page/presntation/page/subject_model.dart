import 'package:flutter/material.dart';
import 'package:student_manager/core/colors/app_colors.dart';

// 1. Обновленная модель данных
class SubjectMarks {
  String id;
  String name;
  List<int> marks; // Теперь тут храним баллы от 0 до 100

  SubjectMarks({required this.id, required this.name, required this.marks});

  // Средний процент по предмету
  double get average => marks.isEmpty ? 0 : marks.reduce((a, b) => a + b) / marks.length;

  // Цветовая индикация по 100-балльной системе
  Color get statusColor {
    if (average >= 90) return Colors.greenAccent.shade700; // Отлично (A)
    if (average >= 75) return AppColors.primaryOrange; // Хорошо (B/C)
    if (average >= 50) return Colors.orangeAccent; // Удовлетворительно (D)
    return Colors.redAccent; // Неудовлетворительно (F)
  }

  // Конвертация среднего балла в 4.0 GPA scale (примерная)
  double get gpaContribution {
    if (average >= 90) return 4.0;
    if (average >= 80) return 3.0;
    if (average >= 70) return 2.0;
    if (average >= 50) return 1.0;
    return 0.0;
  }
}
