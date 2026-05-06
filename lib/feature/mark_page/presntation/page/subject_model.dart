import 'package:flutter/material.dart';
import 'package:student_manager/core/colors/app_colors.dart';

class SubjectMarks {
  String id;
  String name;
  List<int> marks;

  SubjectMarks({required this.id, required this.name, required this.marks});

  double get average => marks.isEmpty ? 0 : marks.reduce((a, b) => a + b) / marks.length;

  Color get statusColor {
    if (average >= 90) return Colors.greenAccent.shade700;
    if (average >= 75) return AppColors.primaryOrange;
    if (average >= 50) return Colors.orangeAccent;
    return Colors.redAccent;
  }

  double get gpaContribution {
    if (average >= 90) return 4.0;
    if (average >= 80) return 3.0;
    if (average >= 70) return 2.0;
    if (average >= 50) return 1.0;
    return 0.0;
  }
}
