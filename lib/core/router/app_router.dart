import 'package:auto_route/auto_route.dart';
import 'package:student_manager/feature/forget_password/forget_password_page.dart';
import 'package:student_manager/feature/register_page/register_page.dart';

import '../../feature/login_page/login_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    // Define your routes here
    AutoRoute(page: LoginRoute.page, initial: true),
    AutoRoute(page: RegisterRoute.page),
    AutoRoute(page: ForgetPasswordRoute.page),
    // Add more routes as needed
  ];
}
