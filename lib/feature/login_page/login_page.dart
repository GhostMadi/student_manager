import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/router/app_router.dart';
import 'package:student_manager/core/style/app_text_style.dart';
import 'package:student_manager/core/validator/validators.dart';
import 'package:student_manager/core/widgets/button.dart';
import 'package:student_manager/core/widgets/text_field.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Ключ для валидации формы
  final _formKey = GlobalKey<FormState>();

  // Контроллеры для получения текста
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _handleLogin() {
    // Проверка всех валидаторов в форме
    if (_formKey.currentState!.validate()) {
      // Если всё ок — логика входа
      print("Email: ${_emailController.text}");
      print("Password: ${_passwordController.text}");
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
              key: _formKey, // Привязываем ключ формы
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.school_rounded, size: 48, color: AppColors.primaryOrange),
                  const SizedBox(height: 24),

                  Text('Student Manager', style: AppTextStyles.h1.copyWith(letterSpacing: -1, fontSize: 28)),
                  const SizedBox(height: 40),

                  // Использование переиспользуемого виджета AppTextField
                  AppTextField(
                    label: 'Email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: AppValidators.email, // Валидатор из файла
                  ),
                  const SizedBox(height: 20),

                  AppTextField(
                    label: 'Пароль',
                    controller: _passwordController,
                    obscureText: true,
                    validator: AppValidators.password, // Валидатор из файла
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => context.router.push(const ForgetPasswordRoute()),
                      child: Text('Забыли пароль?', style: AppTextStyles.caption.copyWith(fontSize: 12)),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Использование переиспользуемого виджета AppButton
                  AppButton(
                    text: 'Войти',
                    variant: AppButtonVariant.primary, // Черная по дизайну
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
