import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_manager/core/models/user_role.dart';

class StorageService {
  StorageService._internal();
  static final StorageService _instance = StorageService._internal();
  static StorageService get instance => _instance;

  late SharedPreferences _prefs;

  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyUserToken = 'user_token';
  static const String _keyUserName = 'user_name';
  static const String _keyLanguageCode = 'language_code';
  static const String _keyUserRole = 'user_role';

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

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

  Future<bool> setUserRole(UserRole role) async {
    return await _prefs.setString(_keyUserRole, role.storageValue);
  }

  bool get isLoggedIn => _prefs.getBool(_keyIsLoggedIn) ?? false;
  String? get token => _prefs.getString(_keyUserToken);
  String? get userName => _prefs.getString(_keyUserName);
  String get languageCode => _prefs.getString(_keyLanguageCode) ?? 'en';

  UserRole get userRole => userRoleFromStorage(_prefs.getString(_keyUserRole)) ?? UserRole.student;

  Future<void> clearAll() async {
    await _prefs.clear();
  }

  Future<void> logout() async {
    await _prefs.remove(_keyIsLoggedIn);
    await _prefs.remove(_keyUserToken);
    await _prefs.remove(_keyUserRole);
    await _prefs.remove(_keyUserName);
  }
}

class AuthService {
  static const String _studentEmail = 'student@gmail.com';
  static const String _adminEmail = 'admin@gmail.com';
  static const String _teacherEmail = 'teacher@gmail.com';
  static const String _mockPassword = 'password123';

  static Future<UserRole?> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 800));

    final normalized = email.trim().toLowerCase();
    if (password != _mockPassword) return null;

    if (normalized == _studentEmail) {
      await _persistSession(UserRole.student, 'Alex Student', 'mock_jwt_student');
      return UserRole.student;
    }
    if (normalized == _adminEmail) {
      await _persistSession(UserRole.admin, 'System Administrator', 'mock_jwt_admin');
      return UserRole.admin;
    }
    if (normalized == _teacherEmail) {
      await _persistSession(UserRole.teacher, 'Maria Teacher', 'mock_jwt_teacher');
      return UserRole.teacher;
    }
    return null;
  }

  static Future<void> _persistSession(UserRole role, String displayName, String token) async {
    await StorageService.instance.setLoggedIn(true);
    await StorageService.instance.setUserRole(role);
    await StorageService.instance.setUserName(displayName);
    await StorageService.instance.setToken(token);
  }
}
