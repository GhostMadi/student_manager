import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/extension/context.dart';
import 'package:student_manager/core/style/app_text_style.dart';
import 'package:student_manager/core/utils/auth_error_mapper.dart';
import 'package:student_manager/core/widgets/snack_bar.dart';
import 'package:student_manager/feature/admin/academic/data/model/group_model.dart';
import 'package:student_manager/feature/admin/academic/presentation/cubit/admin_academic_cubit.dart';
import 'package:student_manager/feature/admin/academic/presentation/widgets/admin_group_sheet.dart';
import 'package:student_manager/feature/admin/presentation/widgets/admin_components.dart';
import 'package:student_manager/feature/login_page/data/model/user_model.dart';

@RoutePage()
class AdminAcademicPage extends StatefulWidget {
  const AdminAcademicPage({super.key});

  @override
  State<AdminAcademicPage> createState() => _AdminAcademicPageState();
}

class _AdminAcademicPageState extends State<AdminAcademicPage> {
  @override
  void initState() {
    super.initState();
    context.read<AdminAcademicCubit>().loadData();
  }

  Future<void> _openCreateGroupSheet() {
    final cubit = context.read<AdminAcademicCubit>();
    final l10n = context.l10n;

    return showAdminGroupSheet(
      context: context,
      title: l10n.adminGroupCreate,
      onSubmit: (name) async {
        final success = await cubit.createGroup(name: name);
        if (success && mounted) {
          AppSnackBar.show(context, message: l10n.adminGroupCreatedSuccess, isError: false);
        }
        return success;
      },
    );
  }

  Future<void> _openEditGroupSheet(GroupModel group) {
    final cubit = context.read<AdminAcademicCubit>();
    final l10n = context.l10n;

    return showAdminGroupSheet(
      context: context,
      title: l10n.adminGroupEdit,
      initialName: group.name,
      onSubmit: (name) async {
        final success = await cubit.updateGroup(groupId: group.id, name: name);
        if (success && mounted) {
          AppSnackBar.show(context, message: l10n.adminGroupUpdatedSuccess, isError: false);
        }
        return success;
      },
    );
  }

  Future<void> _confirmDeleteGroup(GroupModel group) async {
    final l10n = context.l10n;
    final cubit = context.read<AdminAcademicCubit>();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.adminGroupDelete),
        content: Text(l10n.adminDeleteGroupConfirm(group.name)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l10n.cancelButton)),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.deleteText, style: const TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );

    if (!mounted || confirmed != true) return;

    final success = await cubit.deleteGroup(group: group);
    if (!mounted) return;

    if (success) {
      AppSnackBar.show(context, message: l10n.adminGroupDeletedSuccess, isError: false);
    }
  }

  Future<void> _showCuratorPicker(GroupModel group) async {
    final l10n = context.l10n;
    final cubit = context.read<AdminAcademicCubit>();
    final teachers = cubit.state.teachers;

    if (teachers.isEmpty && group.curatorId == null) {
      AppSnackBar.show(context, message: l10n.adminNoTeachers, isError: true);
      return;
    }

    final selected = await showModalBottomSheet<_CuratorPickerResult>(
      context: context,
      backgroundColor: AppColors.scaffoldBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
                child: Text(l10n.adminSelectCuratorTitle, style: AppTextStyles.h1.copyWith(fontSize: 20)),
              ),
              if (group.curatorId != null)
                ListTile(
                  leading: const Icon(Icons.person_off_outlined, color: Colors.redAccent),
                  title: Text(l10n.adminRemoveCurator),
                  onTap: () => Navigator.of(context).pop(_CuratorPickerResult.remove()),
                ),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: teachers.length,
                  separatorBuilder: (_, index) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final teacher = teachers[index];
                    final isCurrent = teacher.uid == group.curatorId;
                    return ListTile(
                      title: Text(teacher.displayName),
                      subtitle: Text(teacher.email, style: AppTextStyles.caption),
                      trailing: isCurrent
                          ? const Icon(Icons.check_circle, color: AppColors.primaryOrange)
                          : null,
                      onTap: () => Navigator.of(context).pop(_CuratorPickerResult.select(teacher)),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );

    if (!mounted || selected == null) return;

    if (selected.removeCurator) {
      final success = await cubit.removeCurator(groupId: group.id);
      if (!mounted) return;
      if (success) {
        AppSnackBar.show(context, message: l10n.adminCuratorRemovedSuccess, isError: false);
      }
      return;
    }

    final teacher = selected.teacher;
    if (teacher == null) return;

    final success = await cubit.assignCurator(groupId: group.id, curator: teacher);
    if (!mounted) return;

    if (success) {
      AppSnackBar.show(context, message: l10n.adminCuratorAssignedSuccess, isError: false);
    }
  }

  Future<void> _showRosterSheet(GroupModel group) async {
    final l10n = context.l10n;
    final cubit = context.read<AdminAcademicCubit>();

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.scaffoldBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return BlocProvider.value(
          value: cubit,
          child: BlocBuilder<AdminAcademicCubit, AdminAcademicState>(
            builder: (context, state) {
              final currentGroup = state.groups.where((g) => g.id == group.id).isEmpty
                  ? group
                  : state.groups.firstWhere((g) => g.id == group.id);
              final inGroup = state.students.where((s) => currentGroup.memberIds.contains(s.uid)).toList();
              final available = state.students.where((s) => !currentGroup.memberIds.contains(s.uid)).toList();

              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${group.name} · ${l10n.adminStudentList}', style: AppTextStyles.h1.copyWith(fontSize: 20)),
                      const SizedBox(height: 16),
                      if (inGroup.isEmpty)
                        Text(l10n.adminNoStudents, style: AppTextStyles.caption)
                      else
                        Flexible(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: inGroup.length,
                            separatorBuilder: (_, index) => const Divider(height: 1),
                            itemBuilder: (context, index) {
                              final student = inGroup[index];
                              return ListTile(
                                title: Text(student.displayName),
                                subtitle: Text(student.email, style: AppTextStyles.caption),
                                trailing: IconButton(
                                  icon: const Icon(Icons.remove_circle_outline, color: Colors.redAccent),
                                  onPressed: state.isUpdatingRoster
                                      ? null
                                      : () async {
                                          final ok = await cubit.removeStudentFromGroup(
                                            groupId: group.id,
                                            student: student,
                                          );
                                          if (ok && context.mounted) {
                                            AppSnackBar.show(context, message: l10n.adminStudentRemovedSuccess, isError: false);
                                          }
                                        },
                                ),
                              );
                            },
                          ),
                        ),
                      const SizedBox(height: 12),
                      Text(l10n.adminAddStudentToGroup, style: AppTextStyles.h2.copyWith(fontSize: 16)),
                      const SizedBox(height: 8),
                      if (available.isEmpty)
                        Text(l10n.adminAllStudentsAssigned, style: AppTextStyles.caption)
                      else
                        Flexible(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: available.length,
                            separatorBuilder: (_, index) => const Divider(height: 1),
                            itemBuilder: (context, index) {
                              final student = available[index];
                              return ListTile(
                                title: Text(student.displayName),
                                subtitle: Text(student.email, style: AppTextStyles.caption),
                                trailing: IconButton(
                                  icon: const Icon(Icons.add_circle_outline, color: AppColors.primaryOrange),
                                  onPressed: state.isUpdatingRoster
                                      ? null
                                      : () async {
                                          final ok = await cubit.assignStudentToGroup(
                                            groupId: group.id,
                                            student: student,
                                          );
                                          if (ok && context.mounted) {
                                            AppSnackBar.show(context, message: l10n.adminStudentAssignedSuccess, isError: false);
                                          }
                                        },
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isBusy = context.select<AdminAcademicCubit, bool>(
      (cubit) => cubit.state.isAssigning || cubit.state.isUpdatingRoster || cubit.state.isSavingGroup,
    );

    return BlocConsumer<AdminAcademicCubit, AdminAcademicState>(
      listenWhen: (previous, current) => previous.errorCode != current.errorCode,
      listener: (context, state) {
        if (state.errorCode != null) {
          AppSnackBar.show(
            context,
            message: mapAuthErrorMessage(context, state.errorCode!),
            isError: true,
          );
          context.read<AdminAcademicCubit>().clearError();
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () => context.read<AdminAcademicCubit>().loadData(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: kAdminPagePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.adminAcademicTitle, style: AppTextStyles.h1.copyWith(fontSize: 24)),
                    const SizedBox(height: 6),
                    Text(l10n.adminHomeSubtitle, style: AppTextStyles.caption),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: AdminSectionHeader(title: l10n.adminAcademicFeaturedGroups)),
                        TextButton.icon(
                          onPressed: isBusy ? null : _openCreateGroupSheet,
                          icon: const Icon(Icons.add_circle_outline, size: 20),
                          label: Text(l10n.adminGroupCreate),
                        ),
                      ],
                    ),
                    if (state.isLoading)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    else if (state.groups.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(l10n.adminNoGroups, style: AppTextStyles.caption),
                      )
                    else
                      SizedBox(
                        height: 148,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(bottom: 4),
                          itemCount: state.groups.length,
                          separatorBuilder: (_, index) => const SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            final group = state.groups[index];
                            return AdminGroupPreviewCard(
                              title: group.name,
                              subtitle: group.curatorName ?? l10n.adminCuratorNotAssigned,
                              highlight: index == 0,
                              onTap: isBusy ? () {} : () => _openEditGroupSheet(group),
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 22),
                    AdminSectionHeader(title: l10n.adminGroupManageTitle),
                    if (!state.isLoading && state.groups.isEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Text(l10n.adminNoGroups, style: AppTextStyles.caption),
                      ),
                    if (!state.isLoading)
                      ...state.groups.asMap().entries.map((entry) {
                        final index = entry.key;
                        final group = entry.value;
                        return AdminGroupManagementCard(
                          title: group.name,
                          membersLabel: l10n.adminGroupMembers(group.memberCount),
                          curatorHint: group.curatorName == null
                              ? l10n.adminCuratorNotAssigned
                              : '${l10n.adminGroupAssignCurator}: ${group.curatorName}',
                          editLabel: l10n.editText,
                          rosterLabel: l10n.adminStudentList,
                          curatorLabel: l10n.adminGroupAssignCurator,
                          deleteLabel: l10n.deleteText,
                          highlight: index == 0,
                          onEdit: isBusy ? () {} : () => _openEditGroupSheet(group),
                          onRoster: isBusy ? () {} : () => _showRosterSheet(group),
                          onCurator: isBusy ? () {} : () => _showCuratorPicker(group),
                          onDelete: isBusy ? () {} : () => _confirmDeleteGroup(group),
                        );
                      }),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CuratorPickerResult {
  const _CuratorPickerResult._({this.teacher, this.removeCurator = false});

  final UserModel? teacher;
  final bool removeCurator;

  factory _CuratorPickerResult.select(UserModel teacher) => _CuratorPickerResult._(teacher: teacher);

  factory _CuratorPickerResult.remove() => const _CuratorPickerResult._(removeCurator: true);
}
