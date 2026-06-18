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

@RoutePage()
class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  String _currentFilter = 'all';

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<StudentAssignmentsCubit, StudentAssignmentsState>(
      builder: (context, state) {
        final assignments = _filterAssignments(state);

        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
                  child: Text(l10n.assignmentsTitle, style: AppTextStyles.h1.copyWith(fontSize: 28)),
                ),
                if (state.groupId == null || state.groupId!.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    child: Text(l10n.studentNoGroupAssigned, style: AppTextStyles.caption),
                  ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Row(
                    children: [
                      _filterChip(l10n.allFilter, 'all'),
                      _filterChip(l10n.inProgressFilter, 'pending'),
                      _filterChip(l10n.completedFilter, 'done'),
                    ],
                  ),
                ),
                if (state.isLoading)
                  const Expanded(child: Center(child: CircularProgressIndicator()))
                else if (assignments.isEmpty)
                  Expanded(child: _buildEmptyState(l10n.noAssignmentsYet))
                else
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 100),
                      itemCount: assignments.length,
                      itemBuilder: (context, index) => _buildAssignmentCard(
                        context,
                        assignments[index],
                        state.submissionFor(assignments[index].id),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<AssignmentModel> _filterAssignments(StudentAssignmentsState state) {
    return state.assignments.where((assignment) {
      final submission = state.submissionFor(assignment.id);
      final status = submission?.status ?? SubmissionStatus.draft;

      switch (_currentFilter) {
        case 'pending':
          return status != SubmissionStatus.graded;
        case 'done':
          return status == SubmissionStatus.graded;
        default:
          return true;
      }
    }).toList();
  }

  Widget _filterChip(String label, String key) {
    final isSelected = _currentFilter == key;
    return GestureDetector(
      onTap: () => setState(() => _currentFilter = key),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryOrange : AppColors.surfaceWhite,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: AppTextStyles.body.copyWith(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildAssignmentCard(
    BuildContext context,
    AssignmentModel assignment,
    SubmissionModel? submission,
  ) {
    final l10n = context.l10n;
    final status = submission?.status ?? SubmissionStatus.draft;
    final statusLabel = switch (status) {
      SubmissionStatus.graded => l10n.submissionGraded,
      SubmissionStatus.submitted => l10n.submissionSubmitted,
      SubmissionStatus.draft => l10n.submissionDraft,
    };
    final statusColor = switch (status) {
      SubmissionStatus.graded => Colors.green,
      SubmissionStatus.submitted => AppColors.primaryOrange,
      SubmissionStatus.draft => Colors.blueGrey,
    };

    return GestureDetector(
      onTap: () => context.router.push(TaskDetailsRoute(assignmentId: assignment.id)),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppColors.surfaceWhite, borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(assignment.title, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(assignment.subjectName, style: AppTextStyles.caption),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(CupertinoIcons.calendar, size: 12, color: AppColors.textSecondary),
                      const SizedBox(width: 4),
                      Text(
                        '${assignment.dueAt.day}.${assignment.dueAt.month}.${assignment.dueAt.year}',
                        style: AppTextStyles.caption.copyWith(fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                statusLabel,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: statusColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(CupertinoIcons.tray, size: 64, color: AppColors.textSecondary.withValues(alpha: 0.3)),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(message, style: AppTextStyles.caption, textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}
