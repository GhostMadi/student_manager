import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/extension/context.dart';
import 'package:student_manager/core/auth/logout_helper.dart';
import 'package:student_manager/core/router/app_router.dart';
import 'package:student_manager/core/storage/storage_service.dart';
import 'package:student_manager/core/style/app_text_style.dart';
import 'package:student_manager/core/widgets/button.dart';
import 'package:student_manager/feature/admin/presentation/widgets/admin_components.dart';
import 'package:student_manager/feature/language/language_cubit.dart';
import 'package:student_manager/feature/teacher/presentation/widgets/teacher_ui.dart';

@RoutePage()
class TeacherProfilePage extends StatefulWidget {
  const TeacherProfilePage({super.key});

  @override
  State<TeacherProfilePage> createState() => _TeacherProfilePageState();
}

class _TeacherProfilePageState extends State<TeacherProfilePage> {
  final String userName = StorageService.instance.userName ?? 'Teacher';

  Future<void> _handleLogout() => logoutAndGoToLogin(context);

  void _showLanguageSelector() {
    final cubit = context.read<LanguageCubit>();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return BlocBuilder<LanguageCubit, Locale>(
          builder: (context, locale) {
            return Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(context.l10n.selectLanguage, style: AppTextStyles.h2),
                  const SizedBox(height: 16),
                  ...cubit.availableLanguages.map((lang) {
                    final isSelected = locale.languageCode == lang['code'];
                    return ListTile(
                      title: Text(lang['name']!),
                      trailing: isSelected
                          ? const Icon(CupertinoIcons.checkmark, color: AppColors.primaryOrange)
                          : null,
                      onTap: () {
                        cubit.changeLanguage(lang['code']!);
                        Navigator.pop(context);
                      },
                    );
                  }),
                ],
              ),
            );
          },
        );
      },
    );
  }

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
              Center(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primaryOrange, width: 2),
                      ),
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.surfaceWhite,
                        child: Icon(Icons.school_rounded, size: 48, color: AppColors.deepBlack),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(userName, style: AppTextStyles.h1.copyWith(fontSize: 24)),
                    Text(l10n.teacherRoleBadge, style: AppTextStyles.caption),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.surfaceWhite,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [BoxShadow(color: AppColors.deepBlack.withOpacity(0.05), blurRadius: 12, offset: const Offset(0, 6))],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _miniStat(context, l10n.teacherMessages, '3', Icons.mail_outline),
                    ),
                    Container(width: 1, height: 40, color: AppColors.deepBlack.withOpacity(0.08)),
                    Expanded(
                      child: _miniStat(context, l10n.teacherAnalytics, '12', Icons.insights_outlined),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(l10n.teacherProfileQuickTitle, style: AppTextStyles.h2.copyWith(fontSize: 16)),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _chip(context, Icons.forum_outlined, l10n.teacherMessages),
                    _chip(context, Icons.analytics_outlined, l10n.teacherAnalytics),
                    _chip(context, Icons.settings_outlined, l10n.teacherProfileSettings),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _tile(CupertinoIcons.bell, l10n.notification, () => context.router.push(const NotificationRoute())),
              _tile(CupertinoIcons.person_crop_square, l10n.personalData, () {
                context.router.push(const ProfileDetailRoute());
              }),
              _tile(CupertinoIcons.globe, l10n.language, _showLanguageSelector),
              const SizedBox(height: 20),
              AppButton(text: l10n.logOut, variant: AppButtonVariant.primary, onPressed: _handleLogout),
            ],
          ),
        ),
      ),
    );
  }

  Widget _miniStat(BuildContext context, String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primaryOrange, size: 22),
        const SizedBox(height: 6),
        Text(value, style: AppTextStyles.h2.copyWith(fontSize: 20)),
        const SizedBox(height: 2),
        Text(label, style: AppTextStyles.caption.copyWith(fontSize: 11), textAlign: TextAlign.center),
      ],
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

  Widget _tile(IconData icon, String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              boxShadow: [BoxShadow(color: AppColors.deepBlack.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: AppColors.scaffoldBackground, borderRadius: BorderRadius.circular(14)),
                child: Icon(icon, color: AppColors.deepBlack, size: 22),
              ),
              title: Text(title, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600)),
              trailing: const Icon(CupertinoIcons.chevron_right, size: 18, color: AppColors.textSecondary),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            ),
          ),
        ),
      ),
    );
  }
}
