import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_manager/core/academic/assignment_model.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/extension/context.dart';
import 'package:student_manager/core/router/app_router.dart';
import 'package:student_manager/core/style/app_text_style.dart';
import 'package:student_manager/feature/student/assignments/presentation/cubit/student_assignments_cubit.dart';

import 'package:student_manager/feature/student/grades/presentation/cubit/student_grades_cubit.dart';
import 'package:student_manager/feature/student/schedule_page/presntation/page/lesson_model.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: const EdgeInsets.symmetric(horizontal: 24), child: _buildHeader()),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _buildSectionHeader(l10n.upcomingLessons, () {
                  context.tabsRouter.setActiveIndex(2);
                }),
              ),
              const SizedBox(height: 16),
              _buildUpcomingLessons(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 32),
                    _buildSectionHeader(l10n.currentTasks, () {
                      context.tabsRouter.setActiveIndex(3);
                    }),
                    const SizedBox(height: 16),
                    _buildCurrentAssignments(),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final l10n = context.l10n;

    return BlocBuilder<StudentGradesCubit, StudentGradesState>(
      builder: (context, gradesState) {
        final gpaText = gradesState.overallGpa.toStringAsFixed(2);

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.greeting, style: AppTextStyles.h1.copyWith(fontSize: 24)),
                const SizedBox(height: 4),
                Text(l10n.todayStudyDay, style: AppTextStyles.caption),
              ],
            ),
            GestureDetector(
              onTap: () => context.tabsRouter.setActiveIndex(1),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(color: AppColors.deepBlack, borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Text('GPA', style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 10)),
                    Text(
                      gpaText,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCurrentAssignments() {
    return BlocBuilder<StudentAssignmentsCubit, StudentAssignmentsState>(
      builder: (context, state) {
        final items = state.assignments.take(2).toList();
        if (items.isEmpty) {
          return Text(context.l10n.noAssignmentsYet, style: AppTextStyles.caption);
        }

        return Column(
          children: items.map((assignment) {
            final submission = state.submissionFor(assignment.id);
            return GestureDetector(
              onTap: () => context.router.push(TaskDetailsRoute(assignmentId: assignment.id)),
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: AppColors.surfaceWhite, borderRadius: BorderRadius.circular(24)),
                child: Row(
                  children: [
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: AppColors.scaffoldBackground,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(CupertinoIcons.doc_text, color: AppColors.primaryOrange),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(assignment.title, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(
                            _statusLabel(context, submission?.status ?? SubmissionStatus.draft),
                            style: AppTextStyles.caption,
                          ),
                        ],
                      ),
                    ),
                    const Icon(CupertinoIcons.chevron_right, size: 16, color: AppColors.textSecondary),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  String _statusLabel(BuildContext context, SubmissionStatus status) {
    final l10n = context.l10n;
    return switch (status) {
      SubmissionStatus.graded => l10n.submissionGraded,
      SubmissionStatus.submitted => l10n.submissionSubmitted,
      SubmissionStatus.draft => l10n.submissionDraft,
    };
  }

  Widget _buildSectionHeader(String title, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.h2.copyWith(fontSize: 20)),
        TextButton(
          onPressed: onTap,
          child: const Text('Все', style: TextStyle(color: AppColors.primaryOrange)),
        ),
      ],
    );
  }

  Widget _buildUpcomingLessons() {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: 3,
        itemBuilder: (context, index) {
          final subjectName = index == 0 ? 'Математика' : 'Физика';

          return GestureDetector(
            onTap: () {
              final lessonToOpen = Lesson(
                id: DateTime.now().toString(),
                subject: subjectName,
                time: '09:00 - 10:30',
                room: 'Ауд. 402',
                dayIndex: 0,
              );

              context.router.push(LessonRoute(lesson: lessonToOpen));
            },
            child: Container(
              width: 220,
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: index == 0 ? AppColors.primaryOrange : AppColors.surfaceWhite,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    subjectName,
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.bold,
                      color: index == 0 ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.time,
                        size: 14,
                        color: index == 0 ? Colors.white70 : AppColors.textSecondary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '09:00 - 10:30',
                        style: AppTextStyles.caption.copyWith(
                          color: index == 0 ? Colors.white70 : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Ауд. 402',
                    style: TextStyle(
                      color: index == 0 ? Colors.white : AppColors.primaryOrange,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
