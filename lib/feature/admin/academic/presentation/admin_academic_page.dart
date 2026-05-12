import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/extension/context.dart';
import 'package:student_manager/core/style/app_text_style.dart';
import 'package:student_manager/feature/admin/presentation/widgets/admin_components.dart';

@RoutePage()
class AdminAcademicPage extends StatelessWidget {
  const AdminAcademicPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: kAdminPagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.adminAcademicTitle, style: AppTextStyles.h1.copyWith(fontSize: 24)),
              const SizedBox(height: 6),
              Text(l10n.adminHomeSubtitle, style: AppTextStyles.caption),
              const SizedBox(height: 20),
              AdminSectionHeader(title: l10n.adminAcademicFeaturedGroups),
              SizedBox(
                height: 148,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(bottom: 4),
                  children: [
                    AdminGroupPreviewCard(
                      title: l10n.adminMockGroup1,
                      subtitle: l10n.adminSectionGroups,
                      highlight: true,
                      onTap: () => adminShowMock(context, l10n.adminMockGroup1),
                    ),
                    AdminGroupPreviewCard(
                      title: l10n.adminMockGroup2,
                      subtitle: l10n.adminSectionGroups,
                      highlight: false,
                      onTap: () => adminShowMock(context, l10n.adminMockGroup2),
                    ),
                    AdminGroupPreviewCard(
                      title: l10n.adminMockGroup3,
                      subtitle: l10n.adminSectionGroups,
                      highlight: false,
                      onTap: () => adminShowMock(context, l10n.adminMockGroup3),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceWhite,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.deepBlack.withOpacity(0.05),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.auto_stories_outlined, color: AppColors.primaryOrange),
                          const SizedBox(height: 12),
                          Text('42', style: AppTextStyles.h1.copyWith(fontSize: 26)),
                          const SizedBox(height: 4),
                          Text(
                            l10n.adminSubjectsActiveLabel,
                            style: AppTextStyles.caption.copyWith(fontSize: 12),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.adminMockSubjectCount,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: AppColors.primaryOrange,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryOrange.withOpacity(0.35),
                            blurRadius: 18,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.event_note_rounded, color: Colors.white.withOpacity(0.9)),
                          const SizedBox(height: 12),
                          Text(
                            l10n.adminSectionSchedule,
                            style: AppTextStyles.body.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            l10n.adminScheduleNextHint,
                            style: AppTextStyles.caption.copyWith(
                              color: Colors.white.withOpacity(0.88),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              AdminSectionHeader(title: l10n.adminGroupManageTitle),
              AdminGroupManagementCard(
                title: _groupTitle(l10n.adminMockGroup1),
                membersLabel: l10n.adminGroupMembers(32),
                curatorHint: l10n.adminMockCuratorShort,
                editLabel: l10n.editText,
                rosterLabel: l10n.adminStudentList,
                curatorLabel: l10n.adminGroupAssignCurator,
                deleteLabel: l10n.deleteText,
                highlight: true,
                onEdit: () => adminShowMock(context, '${l10n.adminMockGroup1} · ${l10n.editText}'),
                onRoster: () => adminShowMock(context, '${l10n.adminMockGroup1} · ${l10n.adminStudentList}'),
                onCurator: () =>
                    adminShowMock(context, '${l10n.adminMockGroup1} · ${l10n.adminGroupAssignCurator}'),
                onDelete: () => adminShowMock(context, '${l10n.adminMockGroup1} · ${l10n.deleteText}'),
              ),
              AdminGroupManagementCard(
                title: _groupTitle(l10n.adminMockGroup2),
                membersLabel: l10n.adminGroupMembers(28),
                curatorHint: l10n.adminMockCuratorShort,
                editLabel: l10n.editText,
                rosterLabel: l10n.adminStudentList,
                curatorLabel: l10n.adminGroupAssignCurator,
                deleteLabel: l10n.deleteText,
                onEdit: () => adminShowMock(context, '${l10n.adminMockGroup2} · ${l10n.editText}'),
                onRoster: () => adminShowMock(context, '${l10n.adminMockGroup2} · ${l10n.adminStudentList}'),
                onCurator: () =>
                    adminShowMock(context, '${l10n.adminMockGroup2} · ${l10n.adminGroupAssignCurator}'),
                onDelete: () => adminShowMock(context, '${l10n.adminMockGroup2} · ${l10n.deleteText}'),
              ),
              AdminGroupManagementCard(
                title: _groupTitle(l10n.adminMockGroup3),
                membersLabel: l10n.adminGroupMembers(18),
                curatorHint: l10n.adminMockCuratorShort,
                editLabel: l10n.editText,
                rosterLabel: l10n.adminStudentList,
                curatorLabel: l10n.adminGroupAssignCurator,
                deleteLabel: l10n.deleteText,
                onEdit: () => adminShowMock(context, '${l10n.adminMockGroup3} · ${l10n.editText}'),
                onRoster: () => adminShowMock(context, '${l10n.adminMockGroup3} · ${l10n.adminStudentList}'),
                onCurator: () =>
                    adminShowMock(context, '${l10n.adminMockGroup3} · ${l10n.adminGroupAssignCurator}'),
                onDelete: () => adminShowMock(context, '${l10n.adminMockGroup3} · ${l10n.deleteText}'),
              ),
              const SizedBox(height: 16),
              AdminSectionHeader(title: l10n.adminSectionSubjects),
              _actionStrip(context, [
                (Icons.post_add_outlined, l10n.adminSubjectAdd),
                (Icons.edit_outlined, l10n.adminSubjectEdit),
                (Icons.remove_circle_outline_rounded, l10n.adminSubjectDelete),
                (Icons.link_rounded, l10n.adminSubjectAssignTeacher),
                (Icons.list_alt_rounded, l10n.adminSubjectList),
              ]),
              const SizedBox(height: 16),
              AdminSectionHeader(title: l10n.adminSectionSchedule),
              _actionStrip(context, [
                (Icons.addchart_rounded, l10n.adminScheduleCreate),
                (Icons.edit_calendar_outlined, l10n.adminScheduleEdit),
                (Icons.delete_sweep_outlined, l10n.adminScheduleDelete),
                (Icons.meeting_room_outlined, l10n.adminScheduleAssignRoom),
                (Icons.person_search_rounded, l10n.adminScheduleAssignTeacher),
                (Icons.visibility_outlined, l10n.adminScheduleView),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  String _groupTitle(String line) {
    final i = line.indexOf('·');
    return i > 0 ? line.substring(0, i).trim() : line.trim();
  }

  Widget _actionStrip(BuildContext context, List<(IconData, String)> items) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items
            .map(
              (e) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ActionChip(
                  avatar: Icon(e.$1, size: 18, color: AppColors.primaryOrange),
                  label: Text(
                    e.$2,
                    style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600, fontSize: 11),
                  ),
                  onPressed: () => adminShowMock(context, e.$2),
                  backgroundColor: AppColors.surfaceWhite,
                  side: BorderSide(color: AppColors.deepBlack.withOpacity(0.08)),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
