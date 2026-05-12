import 'package:auto_route/auto_route.dart';
import 'package:student_manager/core/models/user_role.dart';
import 'package:student_manager/core/router/app_router.dart';
import 'package:student_manager/core/storage/storage_service.dart';

PageRouteInfo<void> dashboardRouteForStoredRole() {
  switch (StorageService.instance.userRole) {
    case UserRole.admin:
      return const AdminDashboardRoute();
    case UserRole.teacher:
      return const TeacherDashboardRoute();
    case UserRole.student:
      return const DashboardRoute();
  }
}
