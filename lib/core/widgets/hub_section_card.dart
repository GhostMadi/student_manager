import 'package:flutter/material.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/style/app_text_style.dart';
import 'package:student_manager/core/widgets/snack_bar.dart';

class HubSectionCard extends StatelessWidget {
  const HubSectionCard({super.key, required this.title, required this.actionLabels});

  final String title;
  final List<String> actionLabels;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.h2.copyWith(fontSize: 20)),
        const SizedBox(height: 12),
        ...actionLabels.map(
          (label) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _HubActionTile(label: label),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _HubActionTile extends StatelessWidget {
  const _HubActionTile({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceWhite,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () => AppSnackBar.show(context, message: label, isError: false),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Expanded(child: Text(label, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w500))),
              const Icon(Icons.chevron_right, color: AppColors.textSecondary, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
