import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:student_manager/feature/admin/academic/presentation/admin_academic_page.dart';
import 'package:student_manager/feature/admin/home/presentation/admin_home_page.dart';
import 'package:student_manager/feature/admin/insights/presentation/admin_insights_page.dart';
import 'package:student_manager/feature/admin/people/presentation/admin_people_page.dart';
import 'package:student_manager/feature/admin/profile/presentation/admin_profile_page.dart';
import 'package:student_manager/feature/dashboard/admin_dashboard_page.dart';
import 'package:student_manager/feature/dashboard/dashboard_page.dart';
import 'package:student_manager/feature/forget_password/forget_password_page.dart';
import 'package:student_manager/feature/student/page/home_page.dart';
import 'package:student_manager/feature/student/mark_page/presntation/page/mark_page.dart';
import 'package:student_manager/feature/notification_page/notifciation_page.dart';
import 'package:student_manager/feature/profile_page/presntation/page/profile_detail_page.dart';
import 'package:student_manager/feature/profile_page/presntation/page/profile_page.dart';
import 'package:student_manager/feature/register_page/presentation/page/register_page.dart';
import 'package:student_manager/feature/student/schedule_page/presntation/page/lesson_model.dart';
import 'package:student_manager/feature/student/schedule_page/presntation/page/lesson_page.dart';
import 'package:student_manager/feature/student/schedule_page/presntation/page/schedule_page.dart';
import 'package:student_manager/feature/splash/splash_screen.dart';
import 'package:student_manager/feature/student/task_page/presntation/page/task_details_page.dart';
import 'package:student_manager/feature/student/task_page/presntation/page/task_model.dart';
import 'package:student_manager/feature/student/task_page/presntation/page/task_page.dart';
import 'package:student_manager/feature/teacher/dashboard/presentation/teacher_dashboard_page.dart';
import 'package:student_manager/feature/teacher/groups/presentation/teacher_groups_page.dart';
import 'package:student_manager/feature/teacher/home/presentation/teacher_home_page.dart';
import 'package:student_manager/feature/teacher/profile/presentation/teacher_profile_page.dart';
import 'package:student_manager/feature/teacher/schedule/presentation/teacher_schedule_page.dart';
import 'package:student_manager/feature/teacher/work/presentation/teacher_work_page.dart';

import '../../feature/login_page/login_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: RegisterRoute.page),
    AutoRoute(page: ForgetPasswordRoute.page),
    AutoRoute(page: ProfileDetailRoute.page),
    AutoRoute(page: LessonRoute.page),
    AutoRoute(page: TaskDetailsRoute.page),
    AutoRoute(page: NotificationRoute.page),
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
    AutoRoute(
      page: AdminDashboardRoute.page,
      children: [
        AutoRoute(page: AdminHomeRoute.page),
        AutoRoute(page: AdminPeopleRoute.page),
        AutoRoute(page: AdminAcademicRoute.page),
        AutoRoute(page: AdminInsightsRoute.page),
        AutoRoute(page: AdminProfileRoute.page),
      ],
    ),
    AutoRoute(
      page: TeacherDashboardRoute.page,
      children: [
        AutoRoute(page: TeacherHomeRoute.page),
        AutoRoute(page: TeacherGroupsRoute.page),
        AutoRoute(page: TeacherScheduleRoute.page),
        AutoRoute(page: TeacherWorkRoute.page),
        AutoRoute(page: TeacherProfileRoute.page),
      ],
    ),
  ];
}
