import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/extension/context.dart';
import 'package:student_manager/core/style/app_text_style.dart';
import 'package:student_manager/feature/admin/presentation/widgets/admin_components.dart';

@RoutePage()
class AdminInsightsPage extends StatelessWidget {
  const AdminInsightsPage({super.key});

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
              Text(l10n.adminInsightsTitle, style: AppTextStyles.h1.copyWith(fontSize: 24)),
              const SizedBox(height: 6),
              Text(l10n.adminHomeSubtitle, style: AppTextStyles.caption),
              const SizedBox(height: 20),
              Row(
                children: [
                  AdminInsightKpi(
                    label: l10n.adminInsightsPassRate,
                    value: '92%',
                    icon: Icons.trending_up_rounded,
                  ),
                  AdminInsightKpi(
                    label: l10n.adminInsightsAttendance,
                    value: '87%',
                    icon: Icons.event_available_rounded,
                  ),
                  AdminInsightKpi(
                    label: l10n.adminInsightsNotifications,
                    value: '128',
                    icon: Icons.mark_email_unread_outlined,
                  ),
                ],
              ),
              const SizedBox(height: 18),
              AdminSparklineCard(title: l10n.adminSectionPerformance, subtitle: l10n.adminPerfGpaStats),
              const SizedBox(height: 16),
              AdminLargeLinkCard(
                title: l10n.adminSectionPerformance,
                subtitle: l10n.adminPerfAnalytics,
                icon: Icons.insights_rounded,
                onTap: () => adminShowMock(context, l10n.adminSectionPerformance),
              ),
              AdminLargeLinkCard(
                title: l10n.adminSectionNotifications,
                subtitle: l10n.adminNotifBulk,
                icon: Icons.campaign_outlined,
                accent: true,
                onTap: () => adminShowMock(context, l10n.adminSectionNotifications),
              ),
              const SizedBox(height: 20),
              AdminSectionHeader(title: l10n.adminSectionAttendance),
              AdminWeekAttendanceStrip(
                title: l10n.adminAttWeekTitle,
                days: [
                  (l10n.mondayShort, 91),
                  (l10n.tuesdayShort, 88),
                  (l10n.wednesdayShort, 93),
                  (l10n.thursdayShort, 90),
                  (l10n.fridayShort, 86),
                  (l10n.saturdayShort, 82),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                decoration: BoxDecoration(
                  color: AppColors.deepBlack,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.adminAttTodayList,
                      style: AppTextStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 12),
                    AdminAttendanceRow(line: l10n.adminMockAttLine1, statusColor: const Color(0xFF4ADE80)),
                    AdminAttendanceRow(line: l10n.adminMockAttLine2, statusColor: AppColors.lightOrange),
                    AdminAttendanceRow(line: l10n.adminMockAttLine3, statusColor: const Color(0xFF4ADE80)),
                    AdminAttendanceRow(line: l10n.adminMockAttLine4, statusColor: const Color(0xFFF87171)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(l10n.adminPerfViewGrades, style: AppTextStyles.h2.copyWith(fontSize: 16)),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _perfChip(context, l10n.adminPerfGpaStats),
                    _perfChip(context, l10n.adminPerfAnalytics),
                    _perfChip(context, l10n.adminPerfStudentReport),
                    _perfChip(context, l10n.adminPerfExportReports),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _perfChip(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ActionChip(
        label: Text(label, style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600, fontSize: 11)),
        onPressed: () => adminShowMock(context, label),
        backgroundColor: AppColors.surfaceWhite,
        side: BorderSide(color: AppColors.deepBlack.withOpacity(0.08)),
      ),
    );
  }
}
