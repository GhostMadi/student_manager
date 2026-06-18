import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/extension/context.dart';
import 'package:student_manager/core/style/app_text_style.dart';
import 'package:student_manager/feature/admin/academic/data/model/group_model.dart';
import 'package:student_manager/feature/admin/presentation/widgets/admin_components.dart';
import 'package:student_manager/feature/login_page/data/model/user_model.dart';
import 'package:student_manager/feature/teacher/grades/presentation/cubit/teacher_grades_cubit.dart';
import 'package:student_manager/feature/teacher/presentation/widgets/teacher_ui.dart';

@RoutePage()
class TeacherGroupsPage extends StatefulWidget {
  const TeacherGroupsPage({super.key});

  @override
  State<TeacherGroupsPage> createState() => _TeacherGroupsPageState();
}

class _TeacherGroupsPageState extends State<TeacherGroupsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<TeacherGradesCubit>().loadGroups();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<TeacherGradesCubit, TeacherGradesState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () => context.read<TeacherGradesCubit>().loadGroups(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: kTeacherPagePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.teacherGroupsTitle, style: AppTextStyles.h1.copyWith(fontSize: 24)),
                    const SizedBox(height: 6),
                    Text(l10n.teacherHomeSubtitle, style: AppTextStyles.caption),
                    const SizedBox(height: 18),
                    AdminSectionHeader(title: l10n.teacherSectionMyGroups),
                    if (state.isLoading && state.groups.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    else if (state.groups.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(l10n.teacherNoGroupsAssigned, style: AppTextStyles.caption),
                      )
                    else ...[
                      SizedBox(
                        height: 132,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.groups.length,
                          separatorBuilder: (_, index) => const SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            final group = state.groups[index];
                            final count = state.studentsForGroup(group.id).length;
                            return AdminGroupPreviewCard(
                              title: group.name,
                              subtitle: l10n.adminGroupMembers(count),
                              highlight: state.selectedGroupId == group.id,
                              onTap: () => context.read<TeacherGradesCubit>().selectGroup(group.id),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      for (final group in state.groups)
                        _groupDetailCard(context, l10n, group, state),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _groupDetailCard(
    BuildContext context,
    dynamic l10n,
    GroupModel group,
    TeacherGradesState state,
  ) {
    final students = state.studentsForGroup(group.id);
    final memberCount = students.isNotEmpty ? students.length : group.memberCount;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AdminGroupManagementCard(
            title: group.name,
            membersLabel: l10n.adminGroupMembers(memberCount),
            curatorHint: l10n.teacherCuratorYouBadge,
            editLabel: l10n.editText,
            rosterLabel: l10n.adminStudentList,
            curatorLabel: l10n.adminGroupAssignCurator,
            deleteLabel: l10n.deleteText,
            highlight: state.selectedGroupId == group.id,
            onEdit: () {},
            onRoster: () => context.read<TeacherGradesCubit>().selectGroup(group.id),
            onCurator: () {},
            onDelete: () {},
            showCuratorButton: false,
          ),
          const SizedBox(height: 8),
          AdminSectionHeader(title: l10n.teacherRosterPreview),
          if (state.isLoading && state.selectedGroupId == group.id)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (students.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(l10n.adminNoStudents, style: AppTextStyles.caption),
            )
          else
            ...students.map(
              (student) => AdminPersonRosterTile(
                initials: _initials(student.displayName),
                title: student.displayName,
                subtitle: student.email,
                onTap: () {},
              ),
            ),
        ],
      ),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty);
    return parts.take(2).map((w) => w[0]).join().toUpperCase();
  }
}
