import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:student_manager/core/colors/app_colors.dart';

class DashboardCapsule extends StatelessWidget {
  const DashboardCapsule({super.key, required this.tabsRouter, required this.icons});

  final TabsRouter tabsRouter;
  final List<IconData> icons;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.deepBlack.withOpacity(0.9),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(icons.length, (i) => _buildIcon(i, icons[i])),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(int index, IconData icon) {
    final isSelected = tabsRouter.activeIndex == index;

    return GestureDetector(
      onTap: () => tabsRouter.setActiveIndex(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        scale: isSelected ? 1.25 : 0.9,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              if (isSelected)
                BoxShadow(color: AppColors.primaryOrange.withOpacity(0.3), blurRadius: 15, spreadRadius: 2),
            ],
          ),
          child: Icon(
            icon,
            color: isSelected ? AppColors.primaryOrange : Colors.white.withOpacity(0.3),
            size: 24,
          ),
        ),
      ),
    );
  }
}
