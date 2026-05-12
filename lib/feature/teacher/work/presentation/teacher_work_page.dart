import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/extension/context.dart';
import 'package:student_manager/core/style/app_text_style.dart';
import 'package:student_manager/feature/admin/presentation/widgets/admin_components.dart';
import 'package:student_manager/feature/teacher/presentation/widgets/teacher_ui.dart';

@RoutePage()
class TeacherWorkPage extends StatelessWidget {
  const TeacherWorkPage({super.key});

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
              Text(l10n.teacherWorkTitle, style: AppTextStyles.h1.copyWith(fontSize: 24)),
              const SizedBox(height: 6),
              Text(l10n.teacherHomeSubtitle, style: AppTextStyles.caption),
              const SizedBox(height: 18),
              Row(
                children: [
                  AdminInsightKpi(label: l10n.teacherAssignments, value: '14', icon: Icons.assignment_outlined),
                  AdminInsightKpi(label: l10n.teacherCheckWork, value: '5', icon: Icons.rate_review_outlined),
                  AdminInsightKpi(label: l10n.teacherGrades, value: '32', icon: Icons.grade_outlined),
                ],
              ),
              const SizedBox(height: 20),
              AdminSectionHeader(title: l10n.teacherWorkDueTitle),
              TeacherTaskCard(
                title: l10n.teacherMockTaskLine1,
                subtitle: l10n.teacherMockTaskSub1,
                highlight: true,
                onTap: () => adminShowMock(context, l10n.teacherMockTaskLine1),
              ),
              TeacherTaskCard(
                title: l10n.teacherMockTaskLine2,
                subtitle: l10n.teacherMockTaskSub2,
                onTap: () => adminShowMock(context, l10n.teacherMockTaskLine2),
              ),
              TeacherTaskCard(
                title: l10n.teacherMockTaskLine3,
                subtitle: l10n.teacherMockTaskSub3,
                onTap: () => adminShowMock(context, l10n.teacherMockTaskLine3),
              ),
              const SizedBox(height: 12),
              AdminSectionHeader(title: l10n.teacherGradeBlockTitle),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.surfaceWhite,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [BoxShadow(color: AppColors.deepBlack.withOpacity(0.05), blurRadius: 12, offset: const Offset(0, 6))],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.teacherMockGradeLine1, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(value: 0.82, minHeight: 8, backgroundColor: AppColors.scaffoldBackground, color: AppColors.primaryOrange),
                    ),
                    const SizedBox(height: 16),
                    Text(l10n.teacherMockGradeLine2, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(value: 0.74, minHeight: 8, backgroundColor: AppColors.scaffoldBackground, color: AppColors.darkOrange),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              AdminSectionHeader(title: l10n.teacherAttYourGroupsTitle),
              AdminWeekAttendanceStrip(
                title: l10n.teacherAttYourGroupsTitle,
                days: [
                  (l10n.mondayShort, 94),
                  (l10n.tuesdayShort, 91),
                  (l10n.wednesdayShort, 89),
                  (l10n.thursdayShort, 93),
                  (l10n.fridayShort, 88),
                  (l10n.saturdayShort, 80),
                ],
              ),
              const SizedBox(height: 14),
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
                    Text(l10n.teacherAttendance, style: AppTextStyles.body.copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10),
                    AdminAttendanceRow(line: l10n.teacherGroupSampleStu1, statusColor: const Color(0xFF4ADE80)),
                    AdminAttendanceRow(line: l10n.teacherGroupSampleStu2, statusColor: AppColors.lightOrange),
                    AdminAttendanceRow(line: l10n.teacherGroupSampleStu3, statusColor: const Color(0xFFF87171)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _chip(context, l10n.teacherAssignments),
                    _chip(context, l10n.teacherCheckWork),
                    _chip(context, l10n.teacherGrades),
                    _chip(context, l10n.teacherAttendance),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chip(BuildContext context, String label) {
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
