import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/extension/context.dart';
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

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  void _checkAuthStatus() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (StorageService.instance.isLoggedIn) {
        context.router.replace(const DashboardRoute());
      }
    });
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final success = await AuthService.login(_emailController.text.trim(), _passwordController.text.trim());

      if (!mounted) return;
      setState(() => _isLoading = false);

      if (success) {
        // Локализация сообщения успеха
        AppSnackBar.show(context, message: context.l10n.loginSuccess, isError: false);
        context.router.replace(DashboardRoute());
      } else {
        // Локализация сообщения ошибки
        AppSnackBar.show(context, message: context.l10n.loginError, isError: true);
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
    // Вынес для удобства чтения
    final l10n = context.l10n;

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
                  Text(l10n.appTitle, style: AppTextStyles.h1.copyWith(letterSpacing: -1, fontSize: 28)),
                  const SizedBox(height: 40),

                  AppTextField(
                    label: l10n.email,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: AppValidators.email,
                  ),
                  const SizedBox(height: 20),

                  AppTextField(
                    label: l10n.password,
                    controller: _passwordController,
                    obscureText: true,
                    validator: AppValidators.password,
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => context.router.push(const ForgetPasswordRoute()),
                      child: Text(l10n.forgotPassword, style: AppTextStyles.caption.copyWith(fontSize: 12)),
                    ),
                  ),

                  const SizedBox(height: 40),

                  AppButton(
                    text: l10n.loginButton,
                    isLoading: _isLoading,
                    variant: AppButtonVariant.primary,
                    onPressed: _handleLogin,
                  ),

                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(l10n.newHere, style: AppTextStyles.caption),
                      TextButton(
                        onPressed: () => context.router.push(const RegisterRoute()),
                        child: Text(
                          l10n.createAccount,
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
