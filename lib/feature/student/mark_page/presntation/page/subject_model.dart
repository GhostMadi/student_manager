import 'package:flutter/material.dart';
import 'package:student_manager/core/academic/gpa_calculator.dart';
import 'package:student_manager/core/colors/app_colors.dart';

class SubjectMarks {
  const SubjectMarks({required this.id, required this.name, required this.marks});

  final String id;
  final String name;
  final List<int> marks;

  double get average => marks.isEmpty ? 0 : marks.reduce((a, b) => a + b) / marks.length;

  Color get statusColor {
    if (average >= 90) return Colors.greenAccent.shade700;
    if (average >= 75) return AppColors.primaryOrange;
    if (average >= 50) return Colors.orangeAccent;
    return Colors.redAccent;
  }

  double get gpaContribution => GpaCalculator.contribution(average);
}
