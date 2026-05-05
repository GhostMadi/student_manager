import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_manager/core/storage/storage_service.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(const Locale('en')) {
    _loadLanguage();
  }

  final List<Map<String, String>> availableLanguages = [
    {'code': 'en', 'name': 'English'},
    {'code': 'ru', 'name': 'Русский'},
    {'code': 'kk', 'name': 'Қазақша'},
  ];

  void _loadLanguage() {
    final code = StorageService.instance.languageCode;
    emit(Locale(code));
  }

  Future<void> changeLanguage(String code) async {
    await StorageService.instance.setLanguageCode(code);
    emit(Locale(code));
  }
}
