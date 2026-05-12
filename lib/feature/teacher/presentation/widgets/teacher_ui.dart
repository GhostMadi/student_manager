import 'package:flutter/material.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/style/app_text_style.dart';

/// Bottom padding aligned with admin role tabs (floating capsule).
const EdgeInsets kTeacherPagePadding = EdgeInsets.fromLTRB(20, 20, 20, 120);

class TeacherHeroCard extends StatelessWidget {
  const TeacherHeroCard({
    super.key,
    required this.overviewTitle,
    required this.statusTitle,
    required this.statusMeta,
    required this.metric1Value,
    required this.metric1Label,
    required this.metric2Value,
    required this.metric2Label,
    required this.metric3Value,
    required this.metric3Label,
  });

  final String overviewTitle;
  final String statusTitle;
  final String statusMeta;
  final String metric1Value;
  final String metric1Label;
  final String metric2Value;
  final String metric2Label;
  final String metric3Value;
  final String metric3Label;

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
                child: const Icon(Icons.auto_stories_rounded, color: AppColors.primaryOrange, size: 22),
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
              Expanded(child: _pill(metric1Value, metric1Label)),
              const SizedBox(width: 10),
              Expanded(child: _pill(metric2Value, metric2Label)),
              const SizedBox(width: 10),
              Expanded(child: _pill(metric3Value, metric3Label)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _pill(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          Text(value, style: AppTextStyles.h2.copyWith(color: Colors.white, fontSize: 16), textAlign: TextAlign.center),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(color: Colors.white38, fontSize: 10),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class TeacherTaskCard extends StatelessWidget {
  const TeacherTaskCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.highlight = false,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: highlight ? AppColors.primaryOrange : AppColors.surfaceWhite,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: highlight ? Colors.white24 : AppColors.scaffoldBackground,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(Icons.assignment_outlined, color: highlight ? Colors.white : AppColors.primaryOrange),
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
                          color: highlight ? Colors.white : AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: AppTextStyles.caption.copyWith(
                          color: highlight ? Colors.white70 : AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: highlight ? Colors.white54 : AppColors.textSecondary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String teacherGroupTitleLine(String line) {
  final i = line.indexOf('·');
  return i > 0 ? line.substring(0, i).trim() : line.trim();
}

String? teacherGroupMembersLine(String line) {
  final i = line.indexOf('·');
  if (i < 0 || i >= line.length - 1) return null;
  return line.substring(i + 1).trim();
}
