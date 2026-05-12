import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/extension/context.dart';
import 'package:student_manager/core/style/app_text_style.dart';
import 'package:student_manager/feature/admin/presentation/widgets/admin_components.dart';

@RoutePage()
class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

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
              Text(l10n.adminGreeting, style: AppTextStyles.h1.copyWith(fontSize: 24)),
              const SizedBox(height: 6),
              Text(l10n.adminHomeSubtitle, style: AppTextStyles.caption),
              const SizedBox(height: 22),
              AdminHeroStatusCard(
                overviewTitle: l10n.adminSystemOverviewTitle,
                statusTitle: l10n.adminHealthGood,
                statusMeta: l10n.adminHealthMeta,
                cpuLabel: l10n.adminMetricCpu,
                memoryLabel: l10n.adminMetricMemory,
                apiLabel: l10n.adminMetricApi,
              ),
              const SizedBox(height: 22),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.28,
                children: [
                  AdminStatMini(
                    icon: Icons.school_outlined,
                    label: l10n.adminDashStudentsCount,
                    value: '1 847',
                    trend: l10n.adminTrendPositive('2.4'),
                  ),
                  AdminStatMini(
                    icon: Icons.person_outline,
                    label: l10n.adminDashTeachersCount,
                    value: '64',
                    trend: l10n.adminTrendPositive('1.1'),
                  ),
                  AdminStatMini(
                    icon: Icons.groups_outlined,
                    label: l10n.adminDashGroupsCount,
                    value: '42',
                  ),
                  AdminStatMini(
                    icon: Icons.online_prediction_outlined,
                    label: l10n.adminDashUserActivity,
                    value: '128',
                    accent: true,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              AdminSectionHeader(title: l10n.adminLoadOverviewTitle),
              AdminSparklineCard(title: l10n.adminLoadOverviewTitle, subtitle: l10n.adminDashUserActivity),
              const SizedBox(height: 8),
              AdminSectionHeader(title: l10n.adminActivitySection),
              AdminFeedTile(
                title: l10n.adminFeed1,
                timeLabel: l10n.minutesAgo(12),
                dotColor: AppColors.primaryOrange,
                icon: Icons.person_add_alt_1_rounded,
              ),
              AdminFeedTile(
                title: l10n.adminFeed2,
                timeLabel: l10n.hoursAgo(2),
                dotColor: const Color(0xFF6366F1),
                icon: Icons.calendar_month_rounded,
              ),
              AdminFeedTile(
                title: l10n.adminFeed3,
                timeLabel: l10n.hoursAgo(5),
                dotColor: const Color(0xFF22C55E),
                icon: Icons.shield_outlined,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
