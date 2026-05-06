import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/extension/context.dart';
import 'package:student_manager/core/router/app_router.dart';
import 'package:student_manager/core/storage/storage_service.dart';
import 'package:student_manager/core/style/app_text_style.dart';
import 'package:student_manager/core/widgets/button.dart';
import 'package:student_manager/feature/language/language_cubit.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String userName = StorageService.instance.userName ?? "Студент";

  void _handleLogout() async {
    await StorageService.instance.logout();
    if (!mounted) return;

    context.router.replace(const LoginRoute());
  }

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
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 40),

              GestureDetector(
                onTap: () {
                  context.router.push(const ProfileDetailRoute());
                },
                child: Center(
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
                          child: CircleAvatar(
                            radius: 46,
                            backgroundImage: AssetImage('assets/jpg/profile.jpg'),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(userName, style: AppTextStyles.h1.copyWith(fontSize: 24)),
                      Text(l10n.idLabel('220104032'), style: AppTextStyles.caption),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              _buildGpaCard(),

              const SizedBox(height: 32),
              _buildMenuTile(
                icon: CupertinoIcons.bell,
                title: l10n.notification,
                onTap: () {
                  context.router.push(const NotificationRoute());
                },
              ),

              _buildMenuTile(
                icon: CupertinoIcons.person_crop_square,
                title: l10n.personalData,
                onTap: () {
                  context.router.push(const ProfileDetailRoute());
                },
              ),
              _buildMenuTile(
                icon: CupertinoIcons.shield_lefthalf_fill,
                title: l10n.security,
                onTap: () {
                  context.router.push(const ForgetPasswordRoute());
                },
              ),
              _buildMenuTile(icon: CupertinoIcons.globe, title: l10n.language, onTap: _showLanguageSelector),

              const SizedBox(height: 40),

              AppButton(text: l10n.logOut, variant: AppButtonVariant.primary, onPressed: _handleLogout),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGpaCard() {
    final l10n = context.l10n;

    return GestureDetector(
      onTap: () {
        context.tabsRouter.setActiveIndex(1);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: AppColors.deepBlack, borderRadius: BorderRadius.circular(24)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.overallGpa, style: AppTextStyles.caption.copyWith(color: Colors.white70)),
                const SizedBox(height: 4),
                Text('4.46', style: AppTextStyles.h1.copyWith(color: Colors.white, fontSize: 32)),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primaryOrange,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(l10n.topPercentage, style: AppTextStyles.button.copyWith(fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuTile({required IconData icon, required String title, required VoidCallback onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: AppColors.surfaceWhite, borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: AppColors.deepBlack),
        title: Text(title, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w500)),
        trailing: const Icon(CupertinoIcons.chevron_right, size: 18, color: AppColors.textSecondary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
