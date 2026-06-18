import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/extension/context.dart';
import 'package:student_manager/core/router/role_dashboard_route.dart';
import 'package:student_manager/core/style/app_text_style.dart';
import 'package:student_manager/core/utils/auth_error_mapper.dart';
import 'package:student_manager/core/validator/validators.dart';
import 'package:student_manager/core/widgets/button.dart';
import 'package:student_manager/core/widgets/snack_bar.dart';
import 'package:student_manager/core/widgets/text_field.dart';
import 'package:student_manager/feature/register_page/presentation/cubit/register_cubit.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      context.read<RegisterCubit>().register(
            name: _nameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
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
    final l10n = context.l10n;

    return BlocListener<RegisterCubit, RegisterState>(
      listenWhen: (previous, current) =>
          previous.errorCode != current.errorCode ||
          previous.user != current.user ||
          (previous.isLoading && !current.isLoading),
      listener: (context, state) {
        if (state.errorCode != null) {
          AppSnackBar.show(
            context,
            message: mapAuthErrorMessage(context, state.errorCode!),
            isError: true,
          );
          context.read<RegisterCubit>().clearError();
        }

        if (state.isSuccess && !state.isLoading) {
          AppSnackBar.show(context, message: l10n.registerSuccess, isError: false);
          context.router.replace(dashboardRouteForStoredRole());
          context.read<RegisterCubit>().reset();
        }
      },
      child: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.scaffoldBackground,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: AppColors.deepBlack),
                onPressed: state.isLoading ? null : () => context.router.back(),
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
                      Text(
                        l10n.createAccount,
                        style: AppTextStyles.h1.copyWith(fontSize: 28, letterSpacing: -1),
                      ),
                      const SizedBox(height: 8),
                      Text(l10n.registerSubtitle, style: AppTextStyles.caption),
                      const SizedBox(height: 40),
                      AppTextField(
                        label: l10n.fullName,
                        controller: _nameController,
                        validator: (value) => AppValidators.name(value, context),
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        label: l10n.email,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => AppValidators.email(value, context),
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        label: l10n.password,
                        controller: _passwordController,
                        obscureText: true,
                        validator: (value) => AppValidators.password(value, context),
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        label: l10n.confirmPassword,
                        controller: _confirmPasswordController,
                        obscureText: true,
                        validator: (value) =>
                            AppValidators.confirmPassword(value, _passwordController.text, context),
                      ),
                      const SizedBox(height: 40),
                      AppButton(
                        text: l10n.registerButton,
                        variant: AppButtonVariant.secondary,
                        isLoading: state.isLoading,
                        onPressed: _handleRegister,
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            l10n.termsAndPrivacyDisclamer,
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
        },
      ),
    );
  }
}
