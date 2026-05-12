import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/extension/context.dart';
import 'package:student_manager/core/style/app_text_style.dart';
import 'package:student_manager/feature/admin/presentation/widgets/admin_components.dart';
import 'package:student_manager/feature/teacher/presentation/widgets/teacher_ui.dart';

@RoutePage()
class TeacherHomePage extends StatelessWidget {
  const TeacherHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: kTeacherPagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.teacherDashOverviewTitle, style: AppTextStyles.h2.copyWith(fontSize: 18)),
              const SizedBox(height: 6),
              Text(l10n.teacherHomeSubtitle, style: AppTextStyles.caption),
              const SizedBox(height: 20),
              TeacherHeroCard(
                overviewTitle: l10n.teacherDashOverviewTitle,
                statusTitle: l10n.teacherGreeting,
                statusMeta: '${l10n.today} · ${l10n.teacherScheduleTitle}',
                metric1Value: '3',
                metric1Label: l10n.teacherTodayClasses,
                metric2Value: '5',
                metric2Label: l10n.teacherPendingReviews,
                metric3Value: '2',
                metric3Label: l10n.teacherOfficeHoursLabel,
              ),
              const SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.28,
                children: [
                  AdminStatMini(
                    icon: Icons.groups_outlined,
                    label: l10n.teacherStatReachLabel,
                    value: '86',
                    trend: l10n.adminTrendPositive('1.2'),
                  ),
                  AdminStatMini(
                    icon: Icons.star_outline_rounded,
                    label: l10n.teacherStatGpaLabel,
                    value: '4.12',
                  ),
                  AdminStatMini(
                    icon: Icons.check_circle_outline,
                    label: l10n.teacherCheckWork,
                    value: '12',
                    accent: true,
                  ),
                  AdminStatMini(
                    icon: Icons.mail_outline,
                    label: l10n.teacherMessages,
                    value: '7',
                  ),
                ],
              ),
              const SizedBox(height: 8),
              AdminSectionHeader(title: l10n.teacherLoadMockTitle),
              AdminSparklineCard(title: l10n.teacherLoadMockTitle, subtitle: l10n.teacherStatGpaLabel),
              const SizedBox(height: 8),
              AdminSectionHeader(title: l10n.adminActivitySection),
              AdminFeedTile(
                title: l10n.teacherFeedT1,
                timeLabel: l10n.minutesAgo(25),
                dotColor: AppColors.primaryOrange,
                icon: Icons.upload_file_rounded,
              ),
              AdminFeedTile(
                title: l10n.teacherFeedT2,
                timeLabel: l10n.hoursAgo(1),
                dotColor: const Color(0xFF6366F1),
                icon: Icons.fact_check_outlined,
              ),
              AdminFeedTile(
                title: l10n.teacherFeedT3,
                timeLabel: l10n.hoursAgo(3),
                dotColor: const Color(0xFF22C55E),
                icon: Icons.how_to_reg_outlined,
              ),
              const SizedBox(height: 12),
              AdminSectionHeader(title: l10n.teacherProfileQuickTitle),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _chip(context, Icons.groups_2_outlined, l10n.teacherShortcutMyGroups),
                    _chip(context, Icons.calendar_today_outlined, l10n.teacherShortcutMySchedule),
                    _chip(context, Icons.assignment_outlined, l10n.teacherShortcutAssignments),
                    _chip(context, Icons.grade_outlined, l10n.teacherShortcutGrades),
                    _chip(context, Icons.event_available_outlined, l10n.teacherShortcutAttendance),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chip(BuildContext context, IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ActionChip(
        avatar: Icon(icon, size: 18, color: AppColors.primaryOrange),
        label: Text(label, style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600, fontSize: 11)),
        onPressed: () => adminShowMock(context, label),
        backgroundColor: AppColors.surfaceWhite,
        side: BorderSide(color: AppColors.deepBlack.withOpacity(0.08)),
      ),
    );
  }
}
