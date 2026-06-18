import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/extension/context.dart';
import 'package:student_manager/core/router/app_router.dart';
import 'package:student_manager/core/router/role_dashboard_route.dart';
import 'package:student_manager/core/style/app_text_style.dart';
import 'package:student_manager/core/utils/auth_error_mapper.dart';
import 'package:student_manager/core/validator/validators.dart';
import 'package:student_manager/core/widgets/button.dart';
import 'package:student_manager/core/widgets/snack_bar.dart';
import 'package:student_manager/core/widgets/text_field.dart';
import 'package:student_manager/feature/login_page/presentation/cubit/login_cubit.dart';

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<LoginCubit>();
      cubit.checkAdminBootstrap();
      cubit.restoreSession().then((role) {
        if (!mounted || role == null) return;
        context.router.replace(dashboardRouteForStoredRole());
      });
    });
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<LoginCubit>().login(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
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
    final l10n = context.l10n;

    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) =>
          previous.errorCode != current.errorCode ||
          previous.user != current.user ||
          previous.adminCreated != current.adminCreated,
      listener: (context, state) {
        if (state.errorCode != null) {
          AppSnackBar.show(context, message: mapAuthErrorMessage(context, state.errorCode!), isError: true);
          context.read<LoginCubit>().clearError();
        }

        if (state.adminCreated && state.isSuccess) {
          AppSnackBar.show(context, message: l10n.adminCreatedSuccess, isError: false);
          context.read<LoginCubit>().clearAdminCreated();
          context.router.replace(dashboardRouteForStoredRole());
          return;
        }

        if (state.isSuccess) {
          AppSnackBar.show(context, message: l10n.loginSuccess, isError: false);
          context.router.replace(dashboardRouteForStoredRole());
        }
      },
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
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
                        Text(
                          l10n.appTitle,
                          style: AppTextStyles.h1.copyWith(letterSpacing: -1, fontSize: 28),
                        ),
                        const SizedBox(height: 40),
                        AppTextField(
                          label: l10n.email,
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => AppValidators.email(value, context),
                        ),
                        const SizedBox(height: 20),
                        AppTextField(
                          label: l10n.password,
                          controller: _passwordController,
                          obscureText: true,
                          validator: (value) => AppValidators.password(value, context),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => context.router.push(const ForgetPasswordRoute()),
                            child: Text(
                              l10n.forgotPassword,
                              style: AppTextStyles.caption.copyWith(fontSize: 12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        AppButton(
                          text: l10n.loginButton,
                          isLoading: state.isLoading,
                          variant: AppButtonVariant.primary,
                          onPressed: _handleLogin,
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(l10n.newHere, style: AppTextStyles.caption),
                            TextButton(
                              onPressed: state.isLoading
                                  ? null
                                  : () => context.router.push(const RegisterRoute()),
                              child: Text(
                                l10n.createAccount,
                                style: AppTextStyles.accent.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // if (!state.adminAlreadyExists) ...[
                        //   const SizedBox(height: 8),
                        //   TextButton(
                        //     onPressed: state.isLoading
                        //         ? null
                        //         : () => context.read<LoginCubit>().createBootstrapAdmin(),
                        //     child: Text(
                        //       l10n.createAdminButton,
                        //       style: AppTextStyles.caption.copyWith(
                        //         color: AppColors.textSecondary,
                        //         fontSize: 12,
                        //       ),
                        //     ),
                        //   ),
                        // ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
