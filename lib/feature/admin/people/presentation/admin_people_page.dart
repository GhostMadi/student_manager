import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/extension/context.dart';
import 'package:student_manager/core/style/app_text_style.dart';
import 'package:student_manager/feature/admin/presentation/widgets/admin_components.dart';
import 'package:student_manager/l10n/app_localizations.dart';

@RoutePage()
class AdminPeoplePage extends StatelessWidget {
  const AdminPeoplePage({super.key});

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
              Text(l10n.adminPeopleTitle, style: AppTextStyles.h1.copyWith(fontSize: 24)),
              const SizedBox(height: 6),
              Text(l10n.adminHomeSubtitle, style: AppTextStyles.caption),
              const SizedBox(height: 18),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: AdminSummaryWideCard(
                      value: '1 847',
                      caption: l10n.adminPeopleSummaryStudents,
                      trend: l10n.adminTrendPositive('2.4'),
                      icon: Icons.school_rounded,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AdminSummaryWideCard(
                      value: '64',
                      caption: l10n.adminPeopleSummaryTeachers,
                      trend: l10n.adminTrendPositive('0.8'),
                      icon: Icons.co_present_outlined,
                      dark: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              TextField(
                readOnly: true,
                onTap: () => adminShowMock(context, l10n.adminPeopleSearchHint),
                decoration: InputDecoration(
                  hintText: l10n.adminPeopleSearchHint,
                  prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                  filled: true,
                  fillColor: AppColors.surfaceWhite,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _toolChip(context, Icons.person_add_alt_1_outlined, l10n.adminStudentAdd),
                    _toolChip(context, Icons.edit_outlined, l10n.adminStudentEdit),
                    _toolChip(context, Icons.delete_outline_rounded, l10n.adminStudentDelete),
                    _toolChip(context, Icons.search_rounded, l10n.adminStudentSearch),
                    _toolChip(context, Icons.upload_file_rounded, l10n.adminStudentImport),
                    _toolChip(context, Icons.downloading_rounded, l10n.adminStudentExport),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              AdminSectionHeader(title: l10n.adminPeopleStudentsSample),
              ..._studentTiles(l10n, context),
              const SizedBox(height: 20),
              AdminSectionHeader(title: l10n.adminPeopleTeachersSample),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _toolChip(context, Icons.person_add_outlined, l10n.adminTeacherAdd),
                    _toolChip(context, Icons.edit_outlined, l10n.adminTeacherEdit),
                    _toolChip(context, Icons.menu_book_outlined, l10n.adminTeacherAssignSubject),
                    _toolChip(context, Icons.manage_search_rounded, l10n.adminTeacherSearch),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              ..._teacherTiles(l10n, context),
            ],
          ),
        ),
      ),
    );
  }

  (String, String) _splitLine(String line) {
    final parts = line.split('·');
    if (parts.length >= 2) {
      return (parts.first.trim(), parts.sublist(1).join('·').trim());
    }
    return (line.trim(), '');
  }

  List<Widget> _studentTiles(AppLocalizations l10n, BuildContext context) {
    final lines = [
      l10n.adminMockStudentLine1,
      l10n.adminMockStudentLine2,
      l10n.adminMockStudentLine3,
      l10n.adminMockStudentLine4,
    ];
    final colors = [
      AppColors.primaryOrange,
      const Color(0xFF6366F1),
      const Color(0xFF0EA5E9),
      AppColors.primaryOrange,
    ];
    return List.generate(lines.length, (i) {
      final p = _splitLine(lines[i]);
      final ini = p.$1.isNotEmpty
          ? p.$1.split(' ').where((w) => w.isNotEmpty).map((w) => w[0]).take(2).join()
          : '?';
      return AdminPersonRosterTile(
        initials: ini.toUpperCase(),
        title: p.$1,
        subtitle: p.$2.isEmpty ? lines[i] : p.$2,
        accentColor: colors[i % colors.length],
        onTap: () => adminShowMock(context, '${l10n.adminPeopleOpenMock}: ${lines[i]}'),
      );
    });
  }

  List<Widget> _teacherTiles(AppLocalizations l10n, BuildContext context) {
    final lines = [l10n.adminMockTeacherLine1, l10n.adminMockTeacherLine2];
    final initials = ['II', 'NA'];
    return List.generate(lines.length, (i) {
      final p = _splitLine(lines[i]);
      return AdminPersonRosterTile(
        initials: initials[i],
        title: p.$1,
        subtitle: p.$2.isEmpty ? lines[i] : p.$2,
        accentColor: AppColors.deepBlack,
        onTap: () => adminShowMock(context, '${l10n.adminPeopleOpenMock}: ${lines[i]}'),
      );
    });
  }

  Widget _toolChip(BuildContext context, IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ActionChip(
        avatar: Icon(icon, size: 18, color: AppColors.primaryOrange),
        label: Text(label, style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600, fontSize: 12)),
        onPressed: () => adminShowMock(context, label),
        backgroundColor: AppColors.surfaceWhite,
        side: BorderSide(color: AppColors.deepBlack.withOpacity(0.08)),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      ),
    );
  }
}
