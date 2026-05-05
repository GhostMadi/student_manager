import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/style/app_text_style.dart';

// Состояния экрана
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  // Валидация Email
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Введите email';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Некорректный формат почты';
    }
    return null;
  }

  void _nextStep() {
    setState(() {
      if (_currentState == ForgetPasswordState.email) {
        if (_formKey.currentState!.validate()) {
          _currentState = ForgetPasswordState.otp;
        }
      } else if (_currentState == ForgetPasswordState.otp) {
        _currentState = ForgetPasswordState.newPassword;
      } else {
        // После сохранения пароля — на страницу логина
        Navigator.pop(context);
      }
    });
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
              Navigator.pop(context);
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
            TextFormField(
              controller: _emailController,
              validator: _validateEmail,
              decoration: _inputDecoration('Email'),
            ),
            const SizedBox(height: 40),
            _buildButton('Отправить код', _nextStep),
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
            children: List.generate(4, (index) => _buildOTPBox(context)),
          ),
          const SizedBox(height: 40),
          _buildButton('Подтвердить', _nextStep),
        ],
      ),
    );
  }

  // 3. НОВЫЙ ПАРОЛЬ
  Widget _buildNewPasswordStep() {
    return Padding(
      key: const ValueKey('password'),
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text('Новый пароль', style: AppTextStyles.h1),
          const SizedBox(height: 8),
          Text('Придумайте сложный пароль', style: AppTextStyles.caption),
          const SizedBox(height: 40),
          TextField(
            controller: _passController,
            obscureText: true,
            decoration: _inputDecoration('Новый пароль'),
          ),
          const SizedBox(height: 16),
          TextField(obscureText: true, decoration: _inputDecoration('Повторите пароль')),
          const SizedBox(height: 40),
          _buildButton('Сохранить и войти', _nextStep),
        ],
      ),
    );
  }

  // ВСПОМОГАТЕЛЬНЫЕ ВИДЖЕТЫ
  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: AppColors.surfaceWhite,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.deepBlack,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: Text(text, style: AppTextStyles.button.copyWith(color: Colors.white)),
      ),
    );
  }

  Widget _buildOTPBox(BuildContext context) {
    return SizedBox(
      height: 64,
      width: 64,
      child: TextField(
        onChanged: (v) => v.length == 1 ? FocusScope.of(context).nextFocus() : null,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [LengthLimitingTextInputFormatter(1), FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.surfaceWhite,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
