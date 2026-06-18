import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/extension/context.dart';
import 'package:student_manager/core/style/app_text_style.dart';
import 'package:student_manager/core/widgets/button.dart';
import 'package:student_manager/feature/student/grades/presentation/cubit/student_grades_cubit.dart';
import 'package:student_manager/feature/student/mark_page/presntation/page/subject_model.dart';

@RoutePage()
class MarkPage extends StatelessWidget {
  const MarkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<StudentGradesCubit, StudentGradesState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.performanceTitle, style: AppTextStyles.h1.copyWith(fontSize: 28)),
                      const SizedBox(height: 20),
                      _buildGpaCard(context, state.overallGpa),
                    ],
                  ),
                ),
                if (state.isLoading)
                  const Expanded(child: Center(child: CircularProgressIndicator()))
                else if (state.subjects.isEmpty)
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text(
                          l10n.noGradesYet,
                          style: AppTextStyles.caption,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      itemCount: state.subjects.length,
                      itemBuilder: (context, index) => _buildSubjectCard(context, state.subjects[index]),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGpaCard(BuildContext context, double gpa) {
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: AppColors.deepBlack, borderRadius: BorderRadius.circular(28)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.overallGpa, style: AppTextStyles.caption.copyWith(color: Colors.white60)),
                const SizedBox(height: 4),
                Text(
                  gpa.toStringAsFixed(2),
                  style: AppTextStyles.h1.copyWith(color: Colors.white, fontSize: 32),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectCard(BuildContext context, SubjectMarks subject) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => _showSubjectDetails(context, subject),
        borderRadius: BorderRadius.circular(24),
        child: Ink(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: AppColors.surfaceWhite, borderRadius: BorderRadius.circular(24)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(subject.name, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold))),
                  Text(
                    '${subject.average.toInt()}%',
                    style: TextStyle(color: subject.statusColor, fontWeight: FontWeight.w900, fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: subject.average / 100,
                  backgroundColor: AppColors.scaffoldBackground,
                  color: subject.statusColor,
                  minHeight: 8,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: subject.marks.map((m) => _buildMarkBadge(m)).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSubjectDetails(BuildContext context, SubjectMarks subject) {
    final l10n = context.l10n;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(subject.name, style: AppTextStyles.h2)),
                _buildMarkBadge(subject.average.toInt()),
              ],
            ),
            const SizedBox(height: 32),
            _buildInfoRow(l10n.totalMarks, '${subject.marks.length}'),
            _buildInfoRow(l10n.averageScore, '${subject.average.toStringAsFixed(1)}%'),
            _buildInfoRow(l10n.statusLabel, subject.average >= 70 ? l10n.passingStatus : l10n.lowStatus),
            const SizedBox(height: 32),
            AppButton(text: l10n.closeButton, onPressed: () => Navigator.pop(context)),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: AppColors.textSecondary, fontSize: 16)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildMarkBadge(int mark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: AppColors.scaffoldBackground, borderRadius: BorderRadius.circular(10)),
      child: Text('$mark', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
    );
  }
}
