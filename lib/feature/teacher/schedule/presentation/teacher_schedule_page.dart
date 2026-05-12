import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/extension/context.dart';
import 'package:student_manager/core/style/app_text_style.dart';
import 'package:student_manager/feature/admin/presentation/widgets/admin_components.dart';
import 'package:student_manager/feature/teacher/presentation/widgets/teacher_ui.dart';

@RoutePage()
class TeacherSchedulePage extends StatelessWidget {
  const TeacherSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final items = [
      (l10n.teacherScheduleItem1Time, l10n.teacherScheduleItem1Title, l10n.teacherScheduleItem1Room),
      (l10n.teacherScheduleItem2Time, l10n.teacherScheduleItem2Title, l10n.teacherScheduleItem2Room),
      (l10n.teacherScheduleItem3Time, l10n.teacherScheduleItem3Title, l10n.teacherScheduleItem3Room),
    ];
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: ListView(
          padding: kTeacherPagePadding,
          children: [
            Text(l10n.teacherScheduleTitle, style: AppTextStyles.h1.copyWith(fontSize: 24)),
            const SizedBox(height: 6),
            Text(l10n.teacherScheduleSubtitle, style: AppTextStyles.caption),
            const SizedBox(height: 18),
            AdminWeekAttendanceStrip(
              title: l10n.teacherScheduleBusyTitle,
              days: [
                (l10n.mondayShort, 6),
                (l10n.tuesdayShort, 5),
                (l10n.wednesdayShort, 4),
                (l10n.thursdayShort, 6),
                (l10n.fridayShort, 3),
                (l10n.saturdayShort, 2),
              ],
            ),
            const SizedBox(height: 20),
            AdminSectionHeader(title: l10n.teacherScheduleTitle),
            ...List.generate(items.length, (index) {
              final row = items[index];
              final highlight = index == 0;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Material(
                  color: highlight ? AppColors.primaryOrange : AppColors.surfaceWhite,
                  borderRadius: BorderRadius.circular(24),
                  elevation: 0,
                  shadowColor: AppColors.deepBlack.withOpacity(0.06),
                  child: InkWell(
                    onTap: () => adminShowMock(context, row.$2),
                    borderRadius: BorderRadius.circular(24),
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          if (!highlight)
                            BoxShadow(
                              color: AppColors.deepBlack.withOpacity(0.05),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    row.$2,
                                    style: AppTextStyles.body.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: highlight ? Colors.white : AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.time,
                                        size: 14,
                                        color: highlight ? Colors.white70 : AppColors.textSecondary,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        row.$1,
                                        style: AppTextStyles.caption.copyWith(
                                          color: highlight ? Colors.white70 : AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              row.$3,
                              style: TextStyle(
                                color: highlight ? Colors.white : AppColors.primaryOrange,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
