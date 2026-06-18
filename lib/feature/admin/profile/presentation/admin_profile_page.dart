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
import 'package:student_manager/feature/language/language_cubit.dart';

@RoutePage()
class AdminProfilePage extends StatefulWidget {
  const AdminProfilePage({super.key});

  @override
  State<AdminProfilePage> createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  final String userName = StorageService.instance.userName ?? 'Admin';

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
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
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
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.surfaceWhite,
                        child: Icon(Icons.admin_panel_settings, size: 48, color: AppColors.deepBlack),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(userName, style: AppTextStyles.h1.copyWith(fontSize: 24)),
                    Text(l10n.adminRoleBadge, style: AppTextStyles.caption),
                  ],
                ),
              ),
              const SizedBox(height: 28),
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

  Widget _tile(IconData icon, String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(18),
        elevation: 0,
        shadowColor: AppColors.deepBlack.withOpacity(0.08),
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
