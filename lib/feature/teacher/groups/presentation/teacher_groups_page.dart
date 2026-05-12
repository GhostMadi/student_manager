import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/extension/context.dart';
import 'package:student_manager/core/style/app_text_style.dart';
import 'package:student_manager/feature/admin/presentation/widgets/admin_components.dart';
import 'package:student_manager/feature/teacher/presentation/widgets/teacher_ui.dart';
import 'package:student_manager/l10n/app_localizations.dart';

@RoutePage()
class TeacherGroupsPage extends StatelessWidget {
  const TeacherGroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final groups = [l10n.teacherGroupCs101, l10n.teacherGroupMath202, l10n.teacherGroupPhysicsLab];
    final counts = [28, 22, 18];
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: kTeacherPagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.teacherGroupsTitle, style: AppTextStyles.h1.copyWith(fontSize: 24)),
              const SizedBox(height: 6),
              Text(l10n.teacherHomeSubtitle, style: AppTextStyles.caption),
              const SizedBox(height: 18),
              AdminSectionHeader(title: l10n.teacherSectionMyGroups),
              SizedBox(
                height: 132,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (var i = 0; i < groups.length; i++)
                      AdminGroupPreviewCard(
                        title: groups[i],
                        subtitle: l10n.teacherGroupsNextClass,
                        highlight: i == 0,
                        onTap: () => adminShowMock(context, '${l10n.teacherGroupOpenMock}: ${teacherGroupTitleLine(groups[i])}'),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              for (var i = 0; i < groups.length; i++) ...[
                _groupDetailCard(context, l10n, groups[i], counts[i], i == 0),
                if (i == 0) ...[
                  const SizedBox(height: 8),
                  AdminSectionHeader(title: l10n.teacherRosterPreview),
                  AdminPersonRosterTile(
                    initials: 'AI',
                    title: 'Alex Ivanov',
                    subtitle: l10n.teacherGroupSampleStu1,
                    onTap: () => adminShowMock(context, l10n.teacherGroupSampleStu1),
                  ),
                  AdminPersonRosterTile(
                    initials: 'MK',
                    title: 'Maria Kim',
                    subtitle: l10n.teacherGroupSampleStu2,
                    accentColor: const Color(0xFF6366F1),
                    onTap: () => adminShowMock(context, l10n.teacherGroupSampleStu2),
                  ),
                  AdminPersonRosterTile(
                    initials: 'DO',
                    title: 'Daniyar Ospan',
                    subtitle: l10n.teacherGroupSampleStu3,
                    accentColor: const Color(0xFF0EA5E9),
                    onTap: () => adminShowMock(context, l10n.teacherGroupSampleStu3),
                  ),
                ],
                const SizedBox(height: 14),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _groupDetailCard(BuildContext context, AppLocalizations l10n, String line, int members, bool highlight) {
    final title = teacherGroupTitleLine(line);
    return AdminGroupManagementCard(
      title: title,
      membersLabel: l10n.adminGroupMembers(members),
      curatorHint: l10n.adminMockCuratorShort,
      editLabel: l10n.editText,
      rosterLabel: l10n.adminStudentList,
      curatorLabel: l10n.adminGroupAssignCurator,
      deleteLabel: l10n.deleteText,
      highlight: highlight,
      onEdit: () => adminShowMock(context, '$title · ${l10n.editText}'),
      onRoster: () => adminShowMock(context, '$title · ${l10n.adminStudentList}'),
      onCurator: () => adminShowMock(context, '$title · ${l10n.adminGroupAssignCurator}'),
      onDelete: () => adminShowMock(context, '$title · ${l10n.deleteText}'),
    );
  }
}
