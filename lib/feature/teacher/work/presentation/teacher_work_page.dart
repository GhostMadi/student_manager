import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_manager/core/academic/assignment_model.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/extension/context.dart';
import 'package:student_manager/core/style/app_text_style.dart';
import 'package:student_manager/core/utils/auth_error_mapper.dart';
import 'package:student_manager/core/widgets/button.dart';
import 'package:student_manager/core/widgets/snack_bar.dart';
import 'package:student_manager/core/widgets/text_field.dart';
import 'package:student_manager/feature/admin/presentation/widgets/admin_components.dart';
import 'package:student_manager/feature/login_page/data/model/user_model.dart';
import 'package:student_manager/feature/teacher/grades/presentation/cubit/teacher_grades_cubit.dart';
import 'package:student_manager/feature/teacher/presentation/widgets/teacher_ui.dart';

@RoutePage()
class TeacherWorkPage extends StatelessWidget {
  const TeacherWorkPage({super.key});

  List<String> _subjects(BuildContext context) {
    final l10n = context.l10n;
    return [
      l10n.subjectMath,
      l10n.subjectPhysics,
      l10n.subjectHistory,
      l10n.subjectProgramming,
      l10n.subjectEnglish,
      l10n.subjectEconomics,
      l10n.subjectDatabases,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocConsumer<TeacherGradesCubit, TeacherGradesState>(
      listenWhen: (previous, current) =>
          previous.errorCode != current.errorCode || previous.success != current.success,
      listener: (context, state) {
        if (state.errorCode != null) {
          AppSnackBar.show(context, message: mapAuthErrorMessage(context, state.errorCode!), isError: true);
          context.read<TeacherGradesCubit>().clearMessages();
        }
        if (state.success) {
          final message = state.successIsAssignment ? l10n.assignmentCreatedSuccess : l10n.gradeAddedSuccess;
          AppSnackBar.show(context, message: message, isError: false);
          context.read<TeacherGradesCubit>().clearMessages();
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: kTeacherPagePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.teacherWorkTitle, style: AppTextStyles.h1.copyWith(fontSize: 24)),
                  const SizedBox(height: 6),
                  Text(l10n.teacherHomeSubtitle, style: AppTextStyles.caption),
                  const SizedBox(height: 18),
                  if (state.isLoading)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if (state.groups.isEmpty)
                    Text(l10n.teacherNoGroupsAssigned, style: AppTextStyles.caption)
                  else ...[
                    _buildGroupSelector(context, state),
                    const SizedBox(height: 20),
                    AdminSectionHeader(title: l10n.teacherCreateAssignmentTitle),
                    const SizedBox(height: 10),
                    AppButton(
                      text: l10n.createAssignmentButton,
                      onPressed: () {
                        if (state.isSubmitting) return;
                        _showCreateAssignmentSheet(context);
                      },
                    ),
                    const SizedBox(height: 24),
                    AdminSectionHeader(title: l10n.teacherPendingSubmissionsTitle),
                    const SizedBox(height: 10),
                    if (state.pendingSubmissions.isEmpty)
                      Text(l10n.noPendingSubmissions, style: AppTextStyles.caption)
                    else
                      ...state.pendingSubmissions.map((s) => _buildSubmissionTile(context, s)),
                    const SizedBox(height: 24),
                    AdminSectionHeader(title: l10n.teacherGradeBlockTitle),
                    const SizedBox(height: 10),
                    if (state.students.isEmpty)
                      Text(l10n.adminNoStudents, style: AppTextStyles.caption)
                    else
                      ...state.students.map((student) => _buildStudentTile(context, student)),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGroupSelector(BuildContext context, TeacherGradesState state) {
    final l10n = context.l10n;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(color: AppColors.surfaceWhite, borderRadius: BorderRadius.circular(16)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: state.selectedGroupId,
          isExpanded: true,
          hint: Text(l10n.teacherSelectGroup),
          items: state.groups.map((g) => DropdownMenuItem(value: g.id, child: Text(g.name))).toList(),
          onChanged: state.isSubmitting
              ? null
              : (groupId) {
                  if (groupId != null) {
                    context.read<TeacherGradesCubit>().selectGroup(groupId);
                  }
                },
        ),
      ),
    );
  }

  Widget _buildSubmissionTile(BuildContext context, SubmissionModel submission) {
    final l10n = context.l10n;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.deepBlack.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(submission.studentName, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(submission.assignmentTitle ?? '', style: AppTextStyles.caption),
          if (submission.textAnswer.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(l10n.viewAnswerLabel, style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text(submission.textAnswer, style: AppTextStyles.body),
          ],
          const SizedBox(height: 12),
          AppButton(
            text: l10n.gradeSubmissionButton,
            onPressed: () => _showGradeSubmissionSheet(context, submission),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentTile(BuildContext context, UserModel student) {
    final l10n = context.l10n;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.deepBlack.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(student.displayName, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600)),
          Text(student.email, style: AppTextStyles.caption),
          const SizedBox(height: 12),
          AppButton(text: l10n.teacherAddGrade, onPressed: () => _showAddGradeSheet(context, student)),
        ],
      ),
    );
  }

  void _showCreateAssignmentSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.scaffoldBackground,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (sheetContext) => _CreateAssignmentSheet(
        cubit: context.read<TeacherGradesCubit>(),
        subjects: _subjects(context),
      ),
    );
  }

  void _showGradeSubmissionSheet(BuildContext context, SubmissionModel submission) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.scaffoldBackground,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (sheetContext) => _GradeSubmissionSheet(
        cubit: context.read<TeacherGradesCubit>(),
        submission: submission,
      ),
    );
  }

  void _showAddGradeSheet(BuildContext context, UserModel student) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.scaffoldBackground,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (sheetContext) => _AddGradeSheet(
        cubit: context.read<TeacherGradesCubit>(),
        student: student,
        subjects: _subjects(context),
      ),
    );
  }
}

class _CreateAssignmentSheet extends StatefulWidget {
  const _CreateAssignmentSheet({required this.cubit, required this.subjects});

  final TeacherGradesCubit cubit;
  final List<String> subjects;

  @override
  State<_CreateAssignmentSheet> createState() => _CreateAssignmentSheetState();
}

class _CreateAssignmentSheetState extends State<_CreateAssignmentSheet> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late String _selectedSubject;
  late DateTime _dueAt;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _selectedSubject = widget.subjects.first;
    _dueAt = DateTime.now().add(const Duration(days: 7));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.viewInsetsOf(context).bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.teacherCreateAssignmentTitle, style: AppTextStyles.h2),
          const SizedBox(height: 16),
          AppTextField(label: l10n.assignmentTitleLabel, controller: _titleController),
          const SizedBox(height: 12),
          AppTextField(label: l10n.assignmentDescriptionLabel, controller: _descriptionController),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.surfaceWhite,
              borderRadius: BorderRadius.circular(16),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedSubject,
                isExpanded: true,
                items: widget.subjects.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _selectedSubject = value);
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.assignmentDueDateLabel, style: AppTextStyles.caption),
            subtitle: Text('${_dueAt.day}.${_dueAt.month}.${_dueAt.year}', style: AppTextStyles.body),
            trailing: const Icon(Icons.calendar_today, color: AppColors.primaryOrange),
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _dueAt,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (picked != null) setState(() => _dueAt = picked);
            },
          ),
          const SizedBox(height: 20),
          AppButton(
            text: l10n.createAssignmentButton,
            onPressed: () async {
              final title = _titleController.text.trim();
              if (title.isEmpty) return;

              final success = await widget.cubit.createAssignment(
                title: title,
                description: _descriptionController.text.trim(),
                subjectName: _selectedSubject,
                dueAt: _dueAt,
              );

              if (success && mounted) {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}

class _GradeSubmissionSheet extends StatefulWidget {
  const _GradeSubmissionSheet({required this.cubit, required this.submission});

  final TeacherGradesCubit cubit;
  final SubmissionModel submission;

  @override
  State<_GradeSubmissionSheet> createState() => _GradeSubmissionSheetState();
}

class _GradeSubmissionSheetState extends State<_GradeSubmissionSheet> {
  late final TextEditingController _scoreController;
  late final TextEditingController _feedbackController;

  @override
  void initState() {
    super.initState();
    _scoreController = TextEditingController();
    _feedbackController = TextEditingController();
  }

  @override
  void dispose() {
    _scoreController.dispose();
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final submission = widget.submission;

    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.viewInsetsOf(context).bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.gradeSubmissionFor(submission.studentName), style: AppTextStyles.h2),
          const SizedBox(height: 8),
          Text(submission.assignmentTitle ?? '', style: AppTextStyles.caption),
          if (submission.textAnswer.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(l10n.viewAnswerLabel, style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600)),
            Text(submission.textAnswer, style: AppTextStyles.body),
          ],
          const SizedBox(height: 16),
          AppTextField(
            label: l10n.enterScoreTitle,
            controller: _scoreController,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          AppTextField(label: l10n.feedbackLabel, controller: _feedbackController),
          const SizedBox(height: 20),
          AppButton(
            text: l10n.gradeSubmissionButton,
            onPressed: () async {
              final score = int.tryParse(_scoreController.text.trim());
              if (score == null || score < 0 || score > 100) return;

              final success = await widget.cubit.gradeSubmission(
                submission: submission,
                score: score,
                feedback: _feedbackController.text.trim(),
              );

              if (success && mounted) {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}

class _AddGradeSheet extends StatefulWidget {
  const _AddGradeSheet({
    required this.cubit,
    required this.student,
    required this.subjects,
  });

  final TeacherGradesCubit cubit;
  final UserModel student;
  final List<String> subjects;

  @override
  State<_AddGradeSheet> createState() => _AddGradeSheetState();
}

class _AddGradeSheetState extends State<_AddGradeSheet> {
  late final TextEditingController _scoreController;
  late final TextEditingController _workController;
  late String _selectedSubject;

  @override
  void initState() {
    super.initState();
    _scoreController = TextEditingController();
    _workController = TextEditingController();
    _selectedSubject = widget.subjects.first;
  }

  @override
  void dispose() {
    _scoreController.dispose();
    _workController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final student = widget.student;

    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.viewInsetsOf(context).bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.teacherAddGradeFor(student.displayName), style: AppTextStyles.h2),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.surfaceWhite,
              borderRadius: BorderRadius.circular(16),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedSubject,
                isExpanded: true,
                items: widget.subjects.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _selectedSubject = value);
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
          AppTextField(
            label: l10n.enterScoreTitle,
            controller: _scoreController,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          AppTextField(label: l10n.gradeWorkNameLabel, controller: _workController),
          const SizedBox(height: 20),
          AppButton(
            text: l10n.addButton,
            onPressed: () async {
              final score = int.tryParse(_scoreController.text.trim());
              if (score == null || score < 0 || score > 100) return;

              final success = await widget.cubit.addGrade(
                studentId: student.uid,
                studentName: student.displayName,
                subjectName: _selectedSubject,
                score: score,
                workName: _workController.text.trim(),
              );

              if (success && mounted) {
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}

