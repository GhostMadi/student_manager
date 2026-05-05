import 'package:flutter/material.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/style/app_text_style.dart';

enum AppButtonVariant { primary, secondary }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final AppButtonVariant variant;
  final bool isLoading;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    // Выбираем цвет в зависимости от варианта
    final backgroundColor = variant == AppButtonVariant.primary
        ? AppColors.deepBlack
        : AppColors.primaryOrange;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
              )
            : Text(text, style: AppTextStyles.button.copyWith(color: Colors.white)),
      ),
    );
  }
}
