import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/extension/context.dart';
import 'package:student_manager/core/router/app_router.dart';
import 'package:student_manager/core/style/app_text_style.dart';
import 'package:student_manager/core/utils/auth_error_mapper.dart';
import 'package:student_manager/core/validator/validators.dart';
import 'package:student_manager/core/widgets/button.dart';
import 'package:student_manager/core/widgets/snack_bar.dart';
import 'package:student_manager/core/widgets/text_field.dart';
import 'package:student_manager/feature/forget_password/presentation/cubit/forget_password_cubit.dart';

@RoutePage()
class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  void _handleSendEmail(ForgetPasswordState state) {
    if (_formKey.currentState!.validate()) {
      context.read<ForgetPasswordCubit>().sendResetEmail(_emailController.text.trim());
    }
  }

  void _goToLogin() {
    context.read<ForgetPasswordCubit>().reset();
    context.router.replace(const LoginRoute());
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listenWhen: (previous, current) => previous.errorCode != current.errorCode,
      listener: (context, state) {
        if (state.errorCode != null) {
          AppSnackBar.show(
            context,
            message: mapAuthErrorMessage(context, state.errorCode!),
            isError: true,
          );
          context.read<ForgetPasswordCubit>().clearError();
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: AppColors.deepBlack),
              onPressed: state.isLoading
                  ? null
                  : () {
                      if (state.isEmailStep) {
                        context.router.back();
                      } else {
                        context.read<ForgetPasswordCubit>().goBackToEmail();
                      }
                    },
            ),
          ),
          body: SafeArea(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: state.isEmailStep ? _buildEmailStep(state) : _buildSuccessStep(state),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmailStep(ForgetPasswordState state) {
    final l10n = context.l10n;

    return Padding(
      key: const ValueKey('email'),
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(l10n.forgetPasswordTitle, style: AppTextStyles.h1),
            const SizedBox(height: 8),
            Text(l10n.forgetPasswordEnterEmail, style: AppTextStyles.caption),
            const SizedBox(height: 40),
            AppTextField(
              label: l10n.email,
              controller: _emailController,
              validator: (value) => AppValidators.email(value, context),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 40),
            AppButton(
              text: l10n.sendCodeButton,
              isLoading: state.isLoading,
              onPressed: () => _handleSendEmail(state),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessStep(ForgetPasswordState state) {
    final l10n = context.l10n;
    final email = state.email.isNotEmpty ? state.email : _emailController.text;

    return Padding(
      key: const ValueKey('success'),
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Container(
            height: 72,
            width: 72,
            decoration: BoxDecoration(
              color: AppColors.primaryOrange.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.mark_email_read_outlined,
              size: 36,
              color: AppColors.primaryOrange,
            ),
          ),
          const SizedBox(height: 24),
          Text(l10n.resetEmailSuccessTitle, style: AppTextStyles.h1),
          const SizedBox(height: 12),
          Text(
            l10n.resetEmailSuccessMessage(email),
            style: AppTextStyles.body.copyWith(height: 1.5),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.resetEmailSpamHint,
            style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary, height: 1.4),
          ),
          const SizedBox(height: 48),
          AppButton(
            text: l10n.backToLogin,
            variant: AppButtonVariant.primary,
            onPressed: _goToLogin,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
