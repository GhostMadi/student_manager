import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:student_manager/feature/dashboard/dashboard_page.dart';
import 'package:student_manager/feature/forget_password/forget_password_page.dart';
import 'package:student_manager/feature/home_page/presenatition/page/home_page.dart';
import 'package:student_manager/feature/mark_page/presntation/page/mark_page.dart';
import 'package:student_manager/feature/profile_page/presntation/page/profile_detail_page.dart';
import 'package:student_manager/feature/profile_page/presntation/page/profile_page.dart';
import 'package:student_manager/feature/register_page/register_page.dart';
import 'package:student_manager/feature/schedule_page/presntation/page/lesson_model.dart';
import 'package:student_manager/feature/schedule_page/presntation/page/lesson_page.dart';
import 'package:student_manager/feature/schedule_page/presntation/page/schedule_page.dart';
import 'package:student_manager/feature/splash/splash_screen.dart';
import 'package:student_manager/feature/task_page/presntation/page/task_details_page.dart';
import 'package:student_manager/feature/task_page/presntation/page/task_model.dart';
import 'package:student_manager/feature/task_page/presntation/page/task_page.dart';

import '../../feature/login_page/login_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    // Define your routes here
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: SplashRoute.page, initial: true),

    AutoRoute(page: RegisterRoute.page),
    AutoRoute(page: ForgetPasswordRoute.page),
    AutoRoute(page: ProfileDetailRoute.page),
    AutoRoute(page: LessonRoute.page),
    AutoRoute(page: TaskDetailsRoute.page),

    AutoRoute(
      page: DashboardRoute.page,
      children: [
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: ScheduleRoute.page),
        AutoRoute(page: MarkRoute.page),
        AutoRoute(page: TaskRoute.page),
        AutoRoute(page: ProfileRoute.page),
      ],
    ),
    // Add more routes as needed
  ];
}
