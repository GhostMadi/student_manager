class AppValidators {
  // Валидация Email
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите email';
    }
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Некорректный формат почты';
    }
    return null;
  }

  // Валидация Пароля (минимум 6 символов)
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите пароль';
    }
    if (value.length < 6) {
      return 'Пароль должен быть не менее 6 символов';
    }
    return null;
  }

  // Сравнение паролей
  static String? confirmPassword(String? value, String password) {
    if (value != password) {
      return 'Пароли не совпадают';
    }
    return null;
  }

  // Валидация имени
  static String? name(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите имя';
    }
    return null;
  }
}
