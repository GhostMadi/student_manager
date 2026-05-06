import 'package:flutter/material.dart';
import 'package:student_manager/core/extension/context.dart';

class AppValidators {
  static String? email(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return context.l10n.enterEmail;
    }
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return context.l10n.invalidEmailFormat;
    }
    return null;
  }

  static String? password(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return context.l10n.enterPassword;
    }
    if (value.length < 6) {
      return context.l10n.passwordTooShort;
    }
    return null;
  }

  static String? confirmPassword(String? value, String password, BuildContext context) {
    if (value != password) {
      return context.l10n.passwordsDoNotMatch;
    }
    return null;
  }

  static String? name(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return context.l10n.enterName;
    }
    return null;
  }
}
