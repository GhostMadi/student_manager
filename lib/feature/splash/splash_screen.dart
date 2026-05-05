import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/router/app_router.dart';
import 'package:student_manager/core/storage/storage_service.dart';
import 'package:student_manager/core/style/app_text_style.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _visible = false;
  double _scale = 0.8;

  @override
  void initState() {
    super.initState();
    _startAnimation();
    _checkAuthStatus();
  }

  void _startAnimation() {
    // Запускаем анимацию проявления через короткую задержку
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        setState(() {
          _visible = true;
          _scale = 1.0;
        });
      }
    });
  }

  void _checkAuthStatus() {
    // Даем пользователю насладиться анимацией (минимум 2 секунды)
    Timer(const Duration(seconds: 2), () {
      if (!mounted) return;

      if (StorageService.instance.isLoggedIn) {
        context.router.replace(const DashboardRoute());
      } else {
        // Если не залогинен — отправляем на логин
        context.router.replace(const LoginRoute());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepBlack, // Черный фон в твоем стиле
      body: Center(
        child: AnimatedScale(
          duration: const Duration(milliseconds: 1000),
          scale: _scale,
          curve: Curves.easeOutBack,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 800),
            opacity: _visible ? 1.0 : 0.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Твой логотип или иконка
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: AppColors.primaryOrange,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(Icons.school_rounded, size: 50, color: Colors.white),
                ),
                const SizedBox(height: 24),
                Text(
                  'STUDENT MANAGER',
                  style: AppTextStyles.h1.copyWith(color: Colors.white, letterSpacing: 4, fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
