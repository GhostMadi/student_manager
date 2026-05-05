import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
          extendBody: true, // Контент будет виден под баром
          body: Stack(
            children: [
              child,
              // Плавающий бар и кнопка поиска
              Positioned(
                bottom: 24, // Отступ от низа экрана
                left: 20,
                right: 20,
                child: Row(
                  children: [
                    // Основная капсула
                    Expanded(child: _buildFloatingCapsule(tabsRouter)),
                    const SizedBox(width: 12),
                    // Отдельная кнопка поиска
                    _buildSearchButton(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Виджет основной капсулы
  Widget _buildFloatingCapsule(TabsRouter tabsRouter) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6), // Темный полупрозрачный фон
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white.withOpacity(0.1), width: 0.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, CupertinoIcons.person_2, 'Contacts', tabsRouter),
              _buildNavItem(1, CupertinoIcons.phone, 'Calls', tabsRouter),
              _buildNavItem(2, CupertinoIcons.chat_bubble_2, 'Chats', tabsRouter, badge: '1.7K'),
              _buildNavItem(3, CupertinoIcons.settings, 'Settings', tabsRouter),
            ],
          ),
        ),
      ),
    );
  }

  // Элемент навигации
  Widget _buildNavItem(int index, IconData icon, String label, TabsRouter tabsRouter, {String? badge}) {
    final isSelected = tabsRouter.activeIndex == index;
    final color = isSelected ? Colors.blueAccent : Colors.white.withOpacity(0.6);

    return GestureDetector(
      onTap: () => tabsRouter.setActiveIndex(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(icon, color: color, size: 24),
              if (badge != null)
                Positioned(
                  top: -5,
                  right: -12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
                    constraints: const BoxConstraints(minWidth: 16),
                    child: Text(
                      badge,
                      style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: color, fontSize: 10)),
        ],
      ),
    );
  }

  // Кнопка поиска
  Widget _buildSearchButton() {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.1), width: 0.5),
          ),
          child: const Icon(CupertinoIcons.search, color: Colors.white, size: 28),
        ),
      ),
    );
  }
}
