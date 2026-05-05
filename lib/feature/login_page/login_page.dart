import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/router/app_router.dart';
import 'package:student_manager/core/storage/storage_service.dart';
import 'package:student_manager/core/style/app_text_style.dart';
import 'package:student_manager/core/validator/validators.dart';
import 'package:student_manager/core/widgets/button.dart';
import 'package:student_manager/core/widgets/snack_bar.dart';
import 'package:student_manager/core/widgets/text_field.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Состояние загрузки
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    // Проверяем статус входа при инициализации экрана
    _checkAuthStatus();
  }

  void _checkAuthStatus() {
    // Ждем окончания отрисовки первого кадра, чтобы безопасно использовать context.router
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (StorageService.instance.isLoggedIn) {
        // Если флаг в StorageService равен true, сразу летим в Dashboard
        context.router.replace(const DashboardRoute());
      }
    });
  }

  Future<void> _handleLogin() async {
    // 1. Сначала проверяем валидаторы (формат почты и пароля)
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // 2. Вызываем сервис аутентификации
      final success = await AuthService.login(_emailController.text.trim(), _passwordController.text.trim());

      if (!mounted) return;
      setState(() => _isLoading = false);

      if (success) {
        // 3. Если данные верны (admin@mail.com / password123)
        AppSnackBar.show(context, message: 'Успешный вход!', isError: false);

        // Переходим на главную и очищаем стек навигации
        context.router.replace(DashboardRoute());
      } else {
        // 4. Если моковый юзер не совпал
        AppSnackBar.show(context, message: 'Неверный email или пароль', isError: true);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.school_rounded, size: 48, color: AppColors.primaryOrange),
                  const SizedBox(height: 24),
                  Text('Student Manager', style: AppTextStyles.h1.copyWith(letterSpacing: -1, fontSize: 28)),
                  const SizedBox(height: 40),

                  AppTextField(
                    label: 'Email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: AppValidators.email,
                  ),
                  const SizedBox(height: 20),

                  AppTextField(
                    label: 'Пароль',
                    controller: _passwordController,
                    obscureText: true,
                    validator: AppValidators.password,
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => context.router.push(const ForgetPasswordRoute()),
                      child: Text('Забыли пароль?', style: AppTextStyles.caption.copyWith(fontSize: 12)),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Кнопка теперь сама показывает индикатор загрузки
                  AppButton(
                    text: 'Войти',
                    isLoading: _isLoading,
                    variant: AppButtonVariant.primary,
                    onPressed: _handleLogin,
                  ),

                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Впервые здесь?', style: AppTextStyles.caption),
                      TextButton(
                        onPressed: () => context.router.push(const RegisterRoute()),
                        child: Text(
                          'Создать аккаунт',
                          style: AppTextStyles.accent.copyWith(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
