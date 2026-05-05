import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/router/app_router.dart';

@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [HomeRoute(), MarkRoute(), ScheduleRoute(), TaskRoute(), ProfileRoute()],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          extendBody: true,
          backgroundColor: AppColors.scaffoldBackground,
          body: Stack(
            children: [
              child,
              Positioned(
                bottom: 30,
                left: 60, // Сделали капсулу короче для минимализма
                right: 60,
                child: _buildMinimalCapsule(tabsRouter),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMinimalCapsule(TabsRouter tabsRouter) {
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
            children: [
              _buildIcon(0, CupertinoIcons.house_fill, tabsRouter),
              _buildIcon(1, CupertinoIcons.chart_bar_fill, tabsRouter),
              _buildIcon(2, CupertinoIcons.calendar, tabsRouter),
              _buildIcon(3, CupertinoIcons.check_mark_circled, tabsRouter),
              _buildIcon(4, CupertinoIcons.person_fill, tabsRouter),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(int index, IconData icon, TabsRouter tabsRouter) {
    final isSelected = tabsRouter.activeIndex == index;

    return GestureDetector(
      onTap: () => tabsRouter.setActiveIndex(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        scale: isSelected ? 1.25 : 0.9, // Неактивные чуть меньше
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // Мягкое оранжевое свечение только для активной иконки
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
