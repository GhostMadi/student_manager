import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/router/app_router.dart';
import 'package:student_manager/core/storage/storage_service.dart';
import 'package:student_manager/core/style/app_text_style.dart';
import 'package:student_manager/core/widgets/button.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Получаем имя из нашего StorageService
  final String userName = StorageService.instance.userName ?? "Студент";

  void _handleLogout() async {
    // Очищаем локальные данные через наш сервис
    await StorageService.instance.logout();
    if (!mounted) return;
    // Возвращаемся на страницу логина
    context.router.replace(const LoginRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 40),

              // 1. Секция аватара и имени
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
                      Text('ID: 220104032', style: AppTextStyles.caption),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // 2. Виджет GPA (Акцентный)
              _buildGpaCard(),

              const SizedBox(height: 32),

              // 3. Меню настроек
              _buildMenuTile(
                icon: CupertinoIcons.person_crop_square,
                title: 'Личные данные',
                onTap: () {
                  context.router.push(const ProfileDetailRoute());
                },
              ),
              _buildMenuTile(
                icon: CupertinoIcons.shield_lefthalf_fill,
                title: 'Безопасность',
                onTap: () {
                  context.router.push(const ForgetPasswordRoute());
                },
              ),

              const SizedBox(height: 40),

              // 4. Кнопка выхода (Используем наш AppButton)
              AppButton(
                text: 'Выйти из системы',
                variant: AppButtonVariant.primary, // Черная кнопка
                onPressed: _handleLogout,
              ),
              const SizedBox(height: 100), // Отступ под плавающий таб-бар
            ],
          ),
        ),
      ),
    );
  }

  // Карточка с GPA
  Widget _buildGpaCard() {
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
                Text('Общий GPA', style: AppTextStyles.caption.copyWith(color: Colors.white70)),
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
              child: Text('Топ 5%', style: AppTextStyles.button.copyWith(fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }

  // Элемент списка меню
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
