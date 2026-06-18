import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:student_manager/core/router/app_router.dart';
import 'package:student_manager/core/storage/storage_service.dart';
import 'package:student_manager/core/theme/app_theme.dart';
import 'package:student_manager/feature/admin/academic/presentation/cubit/admin_academic_cubit.dart';
import 'package:student_manager/feature/admin/people/presentation/cubit/admin_people_cubit.dart';
import 'package:student_manager/feature/forget_password/presentation/cubit/forget_password_cubit.dart';
import 'package:student_manager/feature/language/language_cubit.dart';
import 'package:student_manager/feature/login_page/presentation/cubit/login_cubit.dart';
import 'package:student_manager/feature/register_page/presentation/cubit/register_cubit.dart';
import 'package:student_manager/l10n/app_localizations.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await StorageService.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppRouter appRouter;
  @override
  initState() {
    super.initState();
    appRouter = AppRouter();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LanguageCubit()),
        BlocProvider(create: (_) => LoginCubit()),
        BlocProvider(create: (_) => RegisterCubit()),
        BlocProvider(create: (_) => ForgetPasswordCubit()),
        BlocProvider(create: (_) => AdminPeopleCubit()),
        BlocProvider(create: (_) => AdminAcademicCubit()),
      ],
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp.router(
            onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            locale: locale,
            theme: AppTheme.lightTheme,
            debugShowCheckedModeBanner: false,
            routerConfig: appRouter.config(),
          );
        },
      ),
    );
  }
}
// Техническое задание по доработке приложения Student Manager

// 1. Реализовать функцию регистрации (Создать аккаунт).
// 2. Реализовать функцию «Забыли пароль»:
//     * отправка кода подтверждения на электронную почту;
//     * возможность смены пароля после подтверждения кода.
// 1. В кабинете администратора:
//     * сделать рабочей кнопку «добавить студенты»;
//     * реализовать функцию «Добавить куратора»;
//     * куратор должен назначаться только через кабинет администратора.

// 1. В кабинете преподавателя:
//     * убрать кнопку «Назначить куратора»;
//     * функция назначения куратора должна быть недоступна.

// 1. В кабинете студента:
//     * студент не должен иметь возможность самостоятельно выставлять или изменять оценки;
//     * оценки должны отображаться автоматически из базы данных;
//     * GPA должен рассчитываться автоматически на основе оценок.

// 2. Реализовать корректную работу приложения с сервером и синхронизацию данных между всеми ролями (Администратор, Преподаватель, Студент)

/// Учётные данные единственного администратора (создаётся кнопкой на экране входа).
abstract final class AdminCredentials {
  static const String email = 'admin@student.manager';
  static const String password = 'Admin123!';
  static const String displayName = 'System Administrator';
}
// Student123!