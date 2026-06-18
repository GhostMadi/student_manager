import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_manager/core/academic/assignment_model.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/extension/context.dart';
import 'package:student_manager/core/storage/storage_service.dart';
import 'package:student_manager/core/style/app_text_style.dart';
import 'package:student_manager/core/utils/auth_error_mapper.dart';
import 'package:student_manager/core/widgets/button.dart';
import 'package:student_manager/core/widgets/snack_bar.dart';
import 'package:student_manager/core/widgets/text_field.dart';
import 'package:student_manager/feature/student/task_page/presentation/cubit/task_details_cubit.dart';

@RoutePage()
class TaskDetailsPage extends StatelessWidget {
  const TaskDetailsPage({super.key, required this.assignmentId});

  final String assignmentId;

  @override
  Widget build(BuildContext context) {
    final studentId = FirebaseAuth.instance.currentUser?.uid ?? '';
    final studentName = StorageService.instance.userName ?? 'Student';

    return BlocProvider(
      create: (_) =>
          TaskDetailsCubit(assignmentId: assignmentId, studentId: studentId, studentName: studentName)
            ..load(),
      child: const _TaskDetailsView(),
    );
  }
}

class _TaskDetailsView extends StatefulWidget {
  const _TaskDetailsView();

  @override
  State<_TaskDetailsView> createState() => _TaskDetailsViewState();
}

class _TaskDetailsViewState extends State<_TaskDetailsView> {
  final _answerController = TextEditingController();
  bool _answerInitialized = false;

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  void _syncAnswer(TaskDetailsState state) {
    if (_answerInitialized || state.submission == null) return;
    _answerController.text = state.submission!.textAnswer;
    _answerInitialized = true;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocConsumer<TaskDetailsCubit, TaskDetailsState>(
      listenWhen: (p, c) =>
          p.submitSuccess != c.submitSuccess ||
          p.errorCode != c.errorCode ||
          p.submission?.textAnswer != c.submission?.textAnswer,
      listener: (context, state) {
        if (state.errorCode != null) {
          AppSnackBar.show(context, message: mapAuthErrorMessage(context, state.errorCode!), isError: true);
          context.read<TaskDetailsCubit>().clearMessages();
        }
        if (state.submitSuccess) {
          AppSnackBar.show(context, message: l10n.workSubmittedSuccess, isError: false);
          context.read<TaskDetailsCubit>().clearMessages();
        }
        if (state.submission != null && !_answerInitialized) {
          _syncAnswer(state);
        }
      },
      builder: (context, state) {
        _syncAnswer(state);

        final assignment = state.assignment;
        final submission = state.submission;

        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(CupertinoIcons.back, color: AppColors.textPrimary),
              onPressed: () => context.router.back(),
            ),
          ),
          body: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : assignment == null
              ? Center(child: Text(l10n.noAssignmentsYet, style: AppTextStyles.caption))
              : SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildStatusBadge(context, submission?.status ?? SubmissionStatus.draft),
                              const SizedBox(height: 16),
                              Text(assignment.title, style: AppTextStyles.h1.copyWith(fontSize: 28)),
                              const SizedBox(height: 8),
                              Text(assignment.subjectName, style: AppTextStyles.caption),
                              const SizedBox(height: 24),
                              _infoCard(context, assignment),
                              const SizedBox(height: 24),
                              Text(l10n.descriptionTitle, style: AppTextStyles.h2.copyWith(fontSize: 18)),
                              const SizedBox(height: 8),
                              Text(
                                assignment.description.isEmpty ? l10n.noDescription : assignment.description,
                                style: AppTextStyles.body.copyWith(
                                  color: AppColors.textSecondary,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 24),
                              if (submission?.status == SubmissionStatus.graded) ...[
                                Text(l10n.teacherFeedback, style: AppTextStyles.h2.copyWith(fontSize: 18)),
                                const SizedBox(height: 8),
                                Text(
                                  '${l10n.enterScoreTitle}: ${submission!.score}',
                                  style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
                                ),
                                if (submission.feedback != null && submission.feedback!.isNotEmpty) ...[
                                  const SizedBox(height: 8),
                                  Text(submission.feedback!, style: AppTextStyles.body),
                                ],
                              ] else if (submission?.status != SubmissionStatus.submitted) ...[
                                Text(l10n.yourAnswerLabel, style: AppTextStyles.h2.copyWith(fontSize: 18)),
                                const SizedBox(height: 12),
                                AppTextField(label: l10n.yourAnswerLabel, controller: _answerController),
                              ] else ...[
                                Text(l10n.yourAnswerLabel, style: AppTextStyles.h2.copyWith(fontSize: 18)),
                                const SizedBox(height: 8),
                                Text(submission!.textAnswer, style: AppTextStyles.body),
                              ],
                            ],
                          ),
                        ),
                      ),
                      if (submission != null &&
                          submission.status != SubmissionStatus.graded &&
                          submission.status != SubmissionStatus.submitted)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                          child: AppButton(
                            text: l10n.submitWorkButton,
                            isLoading: state.isSubmitting,
                            onPressed: () {
                              context.read<TaskDetailsCubit>().submitWork(_answerController.text);
                            },
                          ),
                        ),
                    ],
                  ),
                ),
        );
      },
    );
  }

  Widget _buildStatusBadge(BuildContext context, SubmissionStatus status) {
    final l10n = context.l10n;
    final (color, text) = switch (status) {
      SubmissionStatus.graded => (Colors.green, l10n.submissionGraded),
      SubmissionStatus.submitted => (AppColors.primaryOrange, l10n.submissionSubmitted),
      SubmissionStatus.draft => (Colors.blueGrey, l10n.submissionDraft),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: 10),
      ),
    );
  }

  Widget _infoCard(BuildContext context, AssignmentModel assignment) {
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: AppColors.surfaceWhite, borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: [
          _infoRow(
            CupertinoIcons.calendar,
            l10n.deadlineInfo,
            '${assignment.dueAt.day}.${assignment.dueAt.month}.${assignment.dueAt.year}',
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider(height: 1)),
          _infoRow(CupertinoIcons.book, l10n.categoryInfo, assignment.subjectName),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primaryOrange),
        const SizedBox(width: 12),
        Text(label, style: AppTextStyles.caption),
        const Spacer(),
        Text(value, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold, fontSize: 14)),
      ],
    );
  }
}
