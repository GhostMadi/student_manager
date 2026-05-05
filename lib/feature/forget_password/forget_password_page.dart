import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/style/app_text_style.dart';
import 'package:student_manager/core/validator/validators.dart';
import 'package:student_manager/core/widgets/button.dart';
import 'package:student_manager/core/widgets/text_field.dart';

enum ForgetPasswordState { email, otp, newPassword }

@RoutePage()
class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  ForgetPasswordState _currentState = ForgetPasswordState.email;
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  void _nextStep() {
    if (_currentState == ForgetPasswordState.email) {
      if (_formKey.currentState!.validate()) {
        setState(() => _currentState = ForgetPasswordState.otp);
      }
    } else if (_currentState == ForgetPasswordState.otp) {
      // Здесь можно добавить проверку заполненности всех 4 полей OTP
      setState(() => _currentState = ForgetPasswordState.newPassword);
    } else {
      if (_formKey.currentState!.validate()) {
        // Имитация сохранения и возврат
        context.router.back();
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
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
          onPressed: () {
            if (_currentState == ForgetPasswordState.email) {
              context.router.back();
            } else if (_currentState == ForgetPasswordState.otp) {
              setState(() => _currentState = ForgetPasswordState.email);
            } else {
              setState(() => _currentState = ForgetPasswordState.otp);
            }
          },
        ),
      ),
      body: SafeArea(
        child: AnimatedSwitcher(duration: const Duration(milliseconds: 300), child: _buildCurrentStep()),
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentState) {
      case ForgetPasswordState.email:
        return _buildEmailStep();
      case ForgetPasswordState.otp:
        return _buildOtpStep();
      case ForgetPasswordState.newPassword:
        return _buildNewPasswordStep();
    }
  }

  // 1. ВВОД EMAIL
  Widget _buildEmailStep() {
    return Padding(
      key: const ValueKey('email'),
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text('Восстановление', style: AppTextStyles.h1),
            const SizedBox(height: 8),
            Text('Введите вашу почту', style: AppTextStyles.caption),
            const SizedBox(height: 40),
            AppTextField(
              label: 'Email',
              controller: _emailController,
              validator: AppValidators.email,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 40),
            AppButton(text: 'Отправить код', onPressed: _nextStep),
          ],
        ),
      ),
    );
  }

  // 2. ВВОД OTP
  Widget _buildOtpStep() {
    return Padding(
      key: const ValueKey('otp'),
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text('Введите код', style: AppTextStyles.h1),
          const SizedBox(height: 8),
          Text('Код отправлен на ${_emailController.text}', style: AppTextStyles.caption),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(4, (index) => _buildOTPBox()),
          ),
          const SizedBox(height: 40),
          AppButton(text: 'Подтвердить', onPressed: _nextStep),
        ],
      ),
    );
  }

  // 3. НОВЫЙ ПАРОЛЬ
  Widget _buildNewPasswordStep() {
    return Padding(
      key: const ValueKey('password'),
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Form(
        key: _formKey, // Используем тот же ключ или создаем новый для этого этапа
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text('Новый пароль', style: AppTextStyles.h1),
            const SizedBox(height: 8),
            Text('Придумайте сложный пароль', style: AppTextStyles.caption),
            const SizedBox(height: 40),
            AppTextField(
              label: 'Новый пароль',
              controller: _passController,
              obscureText: true,
              validator: AppValidators.password,
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Повторите пароль',
              controller: _confirmPassController,
              obscureText: true,
              validator: (v) => AppValidators.confirmPassword(v, _passController.text),
            ),
            const SizedBox(height: 40),
            AppButton(text: 'Сохранить и войти', variant: AppButtonVariant.primary, onPressed: _nextStep),
          ],
        ),
      ),
    );
  }

  Widget _buildOTPBox() {
    return SizedBox(
      height: 64,
      width: 64,
      child: TextField(
        onChanged: (v) => v.length == 1 ? FocusScope.of(context).nextFocus() : null,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: AppTextStyles.h2,
        inputFormatters: [LengthLimitingTextInputFormatter(1), FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.surfaceWhite,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: AppColors.primaryOrange, width: 1.5),
          ),
        ),
      ),
    );
  }
}
