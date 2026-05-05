import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/style/app_text_style.dart';
import 'package:student_manager/core/validator/validators.dart';
import 'package:student_manager/core/widgets/button.dart';
import 'package:student_manager/core/widgets/text_field.dart';

@RoutePage()
@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  // Контроллеры
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      // Логика регистрации (API запрос)
      print("Регистрация пользователя: ${_nameController.text}");
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: AppColors.deepBlack),
          onPressed: () => context.router.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text('Создать аккаунт', style: AppTextStyles.h1.copyWith(fontSize: 28, letterSpacing: -1)),
                const SizedBox(height: 8),
                Text('Заполните данные, чтобы начать работу', style: AppTextStyles.caption),
                const SizedBox(height: 40),

                // Поле Имя
                AppTextField(label: 'Полное имя', controller: _nameController, validator: AppValidators.name),
                const SizedBox(height: 16),

                // Поле Email
                AppTextField(
                  label: 'Email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: AppValidators.email,
                ),
                const SizedBox(height: 16),

                // Поле Пароль
                AppTextField(
                  label: 'Пароль',
                  controller: _passwordController,
                  obscureText: true,
                  validator: AppValidators.password,
                ),
                const SizedBox(height: 16),

                // Повтор пароля
                AppTextField(
                  label: 'Подтвердите пароль',
                  controller: _confirmPasswordController,
                  obscureText: true,
                  validator: (value) => AppValidators.confirmPassword(value, _passwordController.text),
                ),

                const SizedBox(height: 40),

                // Кнопка регистрации (Оранжевая)
                AppButton(
                  text: 'Зарегистрироваться',
                  variant: AppButtonVariant.secondary, // Наша оранжевая кнопка
                  onPressed: _handleRegister,
                ),

                const SizedBox(height: 24),

                // Условия использования
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Регистрируясь, вы соглашаетесь с условиями использования и политикой конфиденциальности.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.caption.copyWith(fontSize: 11),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
