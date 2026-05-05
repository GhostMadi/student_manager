import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/extension/context.dart';
import 'package:student_manager/core/style/app_text_style.dart';

@RoutePage()
class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: AppColors.textPrimary),
          onPressed: () => context.router.back(),
        ),
        title: Text('Уведомления', style: AppTextStyles.h1.copyWith(fontSize: 22)),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        children: [
          _buildNotificationItem(
            // Передаем локализованный предмет в параметр
            title: l10n.newGradeTitle(l10n.math),
            subtitle: l10n.newGradeSubtitle('A', '№3'),
            time: l10n.minutesAgo(10),
            icon: CupertinoIcons.doc_text_fill,
            color: Colors.green,
            isUnread: true,
          ),
          _buildNotificationItem(
            title: l10n.deadlineTitle,
            subtitle: l10n.deadlineSubtitle(l10n.physics),
            time: l10n.hoursAgo(2),
            icon: CupertinoIcons.clock_fill,
            color: AppColors.primaryOrange,
            isUnread: true,
          ),
          const SizedBox(height: 24),
          _buildSectionHeader(l10n.yesterday),
          _buildNotificationItem(
            title: l10n.scheduleChangeTitle,
            subtitle: l10n.scheduleChangeSubtitle(l10n.history, '502'),
            time: '${l10n.yesterday}, 15:40',
            icon: CupertinoIcons.calendar_badge_plus,
            color: Colors.blue,
          ),
          _buildNotificationItem(
            title: l10n.systemUpdateTitle,
            subtitle: l10n.systemUpdateSubtitle('2.0'),
            time: '${l10n.yesterday}, 09:00',
            icon: CupertinoIcons.gear_alt_fill,
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(title, style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildNotificationItem({
    required String title,
    required String subtitle,
    required String time,
    required IconData icon,
    required Color color,
    bool isUnread = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(24),
        border: isUnread ? Border.all(color: AppColors.primaryOrange.withOpacity(0.3), width: 1) : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Иконка типа уведомления
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          // Текстовая информация
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(time, style: AppTextStyles.caption.copyWith(fontSize: 10)),
                    if (isUnread)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryOrange,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(title, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(subtitle, style: AppTextStyles.caption.copyWith(height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
