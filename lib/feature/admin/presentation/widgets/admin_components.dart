import 'package:flutter/material.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/style/app_text_style.dart';
import 'package:student_manager/core/widgets/snack_bar.dart';

/// Consistent horizontal padding for admin tab screens.
const EdgeInsets kAdminPagePadding = EdgeInsets.fromLTRB(20, 20, 20, 120);

class AdminSectionHeader extends StatelessWidget {
  const AdminSectionHeader({super.key, required this.title, this.trailing});

  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14, top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(child: Text(title, style: AppTextStyles.h2.copyWith(fontSize: 18))),
          ?trailing,
        ],
      ),
    );
  }
}

class AdminHeroStatusCard extends StatelessWidget {
  const AdminHeroStatusCard({
    super.key,
    required this.overviewTitle,
    required this.statusTitle,
    required this.statusMeta,
    required this.cpuLabel,
    required this.memoryLabel,
    required this.apiLabel,
  });

  final String overviewTitle;
  final String statusTitle;
  final String statusMeta;
  final String cpuLabel;
  final String memoryLabel;
  final String apiLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 20),
      decoration: BoxDecoration(
        color: AppColors.deepBlack,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(color: AppColors.primaryOrange.withOpacity(0.18), blurRadius: 28, offset: const Offset(0, 14)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryOrange.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.verified_rounded, color: AppColors.primaryOrange, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  overviewTitle,
                  style: AppTextStyles.caption.copyWith(color: Colors.white54, letterSpacing: 0.3),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(color: Color(0xFF4ADE80), shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 6),
                    Text('Live', style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 11)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(statusTitle, style: AppTextStyles.h1.copyWith(color: Colors.white, fontSize: 22, height: 1.2)),
          const SizedBox(height: 8),
          Text(statusMeta, style: AppTextStyles.caption.copyWith(color: Colors.white54)),
          const SizedBox(height: 22),
          Row(
            children: [
              Expanded(child: _metricPill('12%', cpuLabel)),
              const SizedBox(width: 10),
              Expanded(child: _metricPill('44%', memoryLabel)),
              const SizedBox(width: 10),
              Expanded(child: _metricPill('48 ms', apiLabel)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _metricPill(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          Text(value, style: AppTextStyles.h2.copyWith(color: Colors.white, fontSize: 16)),
          const SizedBox(height: 4),
          Text(label, style: AppTextStyles.caption.copyWith(color: Colors.white38, fontSize: 11), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class AdminStatMini extends StatelessWidget {
  const AdminStatMini({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.accent = false,
    this.trend,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool accent;
  final String? trend;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: accent ? AppColors.primaryOrange : AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          if (!accent)
            BoxShadow(color: AppColors.deepBlack.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 6)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: accent ? Colors.white24 : AppColors.scaffoldBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20, color: accent ? Colors.white : AppColors.primaryOrange),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: Text(
                  value,
                  style: AppTextStyles.h1.copyWith(
                    fontSize: 24,
                    color: accent ? Colors.white : AppColors.deepBlack,
                    letterSpacing: -0.5,
                    height: 1,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (trend != null) ...[
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    trend!,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: accent ? Colors.white.withOpacity(0.9) : const Color(0xFF2E7D32),
                      height: 1.1,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: accent ? Colors.white70 : AppColors.textSecondary,
              fontSize: 11,
              height: 1.2,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class AdminSparklineCard extends StatelessWidget {
  const AdminSparklineCard({super.key, required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  static const _heights = <double>[0.35, 0.55, 0.42, 0.72, 0.5, 0.62, 0.45];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: AppColors.deepBlack.withOpacity(0.05), blurRadius: 16, offset: const Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600)),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(subtitle!, style: AppTextStyles.caption.copyWith(fontSize: 12)),
          ],
          const SizedBox(height: 18),
          SizedBox(
            height: 96,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (var i = 0; i < _heights.length; i++) ...[
                  if (i > 0) const SizedBox(width: 8),
                  Expanded(
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: _heights[i]),
                      duration: Duration(milliseconds: 600 + i * 80),
                      curve: Curves.easeOutCubic,
                      builder: (context, h, _) {
                        return Container(
                          height: 96 * h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                AppColors.darkOrange,
                                AppColors.primaryOrange,
                                AppColors.lightOrange.withOpacity(0.85),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AdminFeedTile extends StatelessWidget {
  const AdminFeedTile({
    super.key,
    required this.title,
    required this.timeLabel,
    required this.dotColor,
    required this.icon,
  });

  final String title;
  final String timeLabel;
  final Color dotColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.deepBlack.withOpacity(0.04)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.scaffoldBackground,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: dotColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 4),
                Text(timeLabel, style: AppTextStyles.caption.copyWith(fontSize: 12)),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: AppColors.textSecondary.withOpacity(0.5), size: 22),
        ],
      ),
    );
  }
}

class AdminQuickAction extends StatelessWidget {
  const AdminQuickAction({super.key, required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceWhite,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: AppColors.primaryOrange, size: 26),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600, fontSize: 11, height: 1.2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdminSummaryWideCard extends StatelessWidget {
  const AdminSummaryWideCard({
    super.key,
    required this.value,
    required this.caption,
    required this.trend,
    required this.icon,
    this.dark = false,
  });

  final String value;
  final String caption;
  final String trend;
  final IconData icon;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: dark ? AppColors.deepBlack : AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          if (!dark) BoxShadow(color: AppColors.deepBlack.withOpacity(0.05), blurRadius: 12, offset: const Offset(0, 6)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: dark ? AppColors.primaryOrange : AppColors.deepBlack, size: 22),
          const SizedBox(height: 12),
          Text(
            value,
            style: AppTextStyles.h1.copyWith(fontSize: 28, color: dark ? Colors.white : AppColors.deepBlack),
          ),
          const SizedBox(height: 4),
          Text(
            caption,
            style: AppTextStyles.caption.copyWith(color: dark ? Colors.white60 : AppColors.textSecondary, fontSize: 12),
            maxLines: 2,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: dark ? Colors.white12 : const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              trend,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: dark ? const Color(0xFF86EFAC) : const Color(0xFF2E7D32),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class AdminGroupPreviewCard extends StatelessWidget {
  const AdminGroupPreviewCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.highlight,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final bool highlight;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 14),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: highlight ? AppColors.primaryOrange : AppColors.surfaceWhite,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            if (!highlight)
              BoxShadow(color: AppColors.deepBlack.withOpacity(0.06), blurRadius: 12, offset: const Offset(0, 6)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.groups_rounded, color: highlight ? Colors.white70 : AppColors.primaryOrange),
            Text(
              title,
              style: AppTextStyles.body.copyWith(
                fontWeight: FontWeight.bold,
                color: highlight ? Colors.white : AppColors.textPrimary,
                fontSize: 15,
              ),
            ),
            Text(
              subtitle,
              style: AppTextStyles.caption.copyWith(color: highlight ? Colors.white70 : AppColors.textSecondary, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class AdminInsightKpi extends StatelessWidget {
  const AdminInsightKpi({super.key, required this.label, required this.value, required this.icon});

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surfaceWhite,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [BoxShadow(color: AppColors.deepBlack.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 20, color: AppColors.primaryOrange),
            const SizedBox(height: 10),
            Text(value, style: AppTextStyles.h2.copyWith(fontSize: 18)),
            const SizedBox(height: 4),
            Text(label, style: AppTextStyles.caption.copyWith(fontSize: 11, height: 1.2)),
          ],
        ),
      ),
    );
  }
}

class AdminLargeLinkCard extends StatelessWidget {
  const AdminLargeLinkCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.accent = false,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final bool accent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: accent ? AppColors.primaryOrange : AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: accent ? Colors.white24 : AppColors.scaffoldBackground,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icon, color: accent ? Colors.white : AppColors.deepBlack),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.body.copyWith(
                          fontWeight: FontWeight.w600,
                          color: accent ? Colors.white : AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: AppTextStyles.caption.copyWith(color: accent ? Colors.white70 : AppColors.textSecondary, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded, size: 14, color: accent ? Colors.white54 : AppColors.textSecondary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AdminPersonRosterTile extends StatelessWidget {
  const AdminPersonRosterTile({
    super.key,
    required this.initials,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.accentColor = AppColors.primaryOrange,
  });

  final String initials;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: accentColor.withOpacity(0.15),
                  child: Text(
                    initials,
                    style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold, color: accentColor, fontSize: 14),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600, fontSize: 15)),
                      const SizedBox(height: 2),
                      Text(subtitle, style: AppTextStyles.caption.copyWith(fontSize: 12)),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: AppColors.textSecondary.withOpacity(0.6)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AdminGroupManagementCard extends StatelessWidget {
  const AdminGroupManagementCard({
    super.key,
    required this.title,
    required this.membersLabel,
    required this.curatorHint,
    required this.editLabel,
    required this.rosterLabel,
    required this.curatorLabel,
    required this.deleteLabel,
    required this.onEdit,
    required this.onRoster,
    required this.onCurator,
    required this.onDelete,
    this.highlight = false,
    this.showCuratorButton = true,
  });

  final String title;
  final String membersLabel;
  final String curatorHint;
  final String editLabel;
  final String rosterLabel;
  final String curatorLabel;
  final String deleteLabel;
  final VoidCallback onEdit;
  final VoidCallback onRoster;
  final VoidCallback onCurator;
  final VoidCallback onDelete;
  final bool highlight;
  final bool showCuratorButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: highlight ? AppColors.primaryOrange : AppColors.surfaceWhite,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: highlight ? Colors.transparent : AppColors.deepBlack.withOpacity(0.06)),
          boxShadow: [
            if (!highlight)
              BoxShadow(color: AppColors.deepBlack.withOpacity(0.05), blurRadius: 12, offset: const Offset(0, 6)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: highlight ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: highlight ? Colors.white24 : AppColors.scaffoldBackground,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    membersLabel,
                    style: AppTextStyles.caption.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                      color: highlight ? Colors.white : AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              curatorHint,
              style: AppTextStyles.caption.copyWith(
                fontSize: 12,
                color: highlight ? Colors.white70 : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _actionBtn(icon: Icons.edit_outlined, label: editLabel, onTap: onEdit, highlight: highlight),
                _actionBtn(icon: Icons.group_add_outlined, label: rosterLabel, onTap: onRoster, highlight: highlight),
                if (showCuratorButton)
                  _actionBtn(icon: Icons.supervisor_account_outlined, label: curatorLabel, onTap: onCurator, highlight: highlight),
                _actionBtn(icon: Icons.delete_outline_rounded, label: deleteLabel, onTap: onDelete, highlight: highlight),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionBtn({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required bool highlight,
  }) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 16),
      label: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      style: OutlinedButton.styleFrom(
        foregroundColor: highlight ? Colors.white : AppColors.deepBlack,
        side: BorderSide(color: highlight ? Colors.white38 : AppColors.deepBlack.withOpacity(0.12)),
        backgroundColor: highlight ? Colors.white12 : AppColors.scaffoldBackground,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}

class AdminWeekAttendanceStrip extends StatelessWidget {
  const AdminWeekAttendanceStrip({super.key, required this.title, required this.days});

  final String title;
  final List<(String label, int pct)> days;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [BoxShadow(color: AppColors.deepBlack.withOpacity(0.05), blurRadius: 14, offset: const Offset(0, 6))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          Row(
            children: [
              for (var i = 0; i < days.length; i++) ...[
                if (i > 0) const SizedBox(width: 6),
                Expanded(
                  child: Column(
                    children: [
                      Text('${days[i].$2}%', style: AppTextStyles.h2.copyWith(fontSize: 13, color: AppColors.primaryOrange)),
                      const SizedBox(height: 6),
                      Text(
                        days[i].$1,
                        style: AppTextStyles.caption.copyWith(fontSize: 10),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: (days[i].$2.clamp(0, 100)) / 100.0,
                          minHeight: 5,
                          backgroundColor: AppColors.scaffoldBackground,
                          color: AppColors.primaryOrange,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class AdminAttendanceRow extends StatelessWidget {
  const AdminAttendanceRow({super.key, required this.line, required this.statusColor});

  final String line;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(line, style: AppTextStyles.body.copyWith(fontSize: 14)),
          ),
        ],
      ),
    );
  }
}

void adminShowMock(BuildContext context, String label) {
  AppSnackBar.show(context, message: label, isError: false);
}
