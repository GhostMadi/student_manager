import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  // Приватный конструктор для синглтона
  StorageService._internal();
  static final StorageService _instance = StorageService._internal();
  static StorageService get instance => _instance;

  late SharedPreferences _prefs;

  // Ключи для хранения (выносим в константы, чтобы не опечататься)
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyUserToken = 'user_token';
  static const String _keyUserName = 'user_name';
  static const String _keyLanguageCode = 'language_code';

  // Инициализация (вызываем один раз в main.dart)
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // --- МЕТОДЫ ЗАПИСИ ---

  Future<bool> setLoggedIn(bool value) async {
    return await _prefs.setBool(_keyIsLoggedIn, value);
  }

  Future<bool> setToken(String token) async {
    return await _prefs.setString(_keyUserToken, token);
  }

  Future<bool> setUserName(String name) async {
    return await _prefs.setString(_keyUserName, name);
  }

  Future<bool> setLanguageCode(String code) async {
    return await _prefs.setString(_keyLanguageCode, code);
  }

  // --- МЕТОДЫ ЧТЕНИЯ ---

  bool get isLoggedIn => _prefs.getBool(_keyIsLoggedIn) ?? false;
  String? get token => _prefs.getString(_keyUserToken);
  String? get userName => _prefs.getString(_keyUserName);
  String get languageCode => _prefs.getString(_keyLanguageCode) ?? 'en';

  // --- УДАЛЕНИЕ ---

  Future<void> clearAll() async {
    await _prefs.clear();
  }

  Future<void> logout() async {
    await _prefs.remove(_keyIsLoggedIn);
    await _prefs.remove(_keyUserToken);
  }
}

class AuthService {
  // Моковые данные пользователя
  static const String _mockEmail = "aruka@gmail.com";
  static const String _mockPassword = "password123";

  static Future<bool> login(String email, String password) async {
    // Имитация задержки сети
    await Future.delayed(const Duration(milliseconds: 800));

    if (email == _mockEmail && password == _mockPassword) {
      // Сохраняем состояние в SharedPreferences
      await StorageService.instance.setLoggedIn(true);
      await StorageService.instance.setUserName("Student Admin");
      await StorageService.instance.setToken("mock_jwt_token_2026");
      return true;
    }
    return false;
  }
}
