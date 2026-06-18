// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AdminAcademicPage]
class AdminAcademicRoute extends PageRouteInfo<void> {
  const AdminAcademicRoute({List<PageRouteInfo>? children})
    : super(AdminAcademicRoute.name, initialChildren: children);

  static const String name = 'AdminAcademicRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AdminAcademicPage();
    },
  );
}

/// generated route for
/// [AdminDashboardPage]
class AdminDashboardRoute extends PageRouteInfo<void> {
  const AdminDashboardRoute({List<PageRouteInfo>? children})
    : super(AdminDashboardRoute.name, initialChildren: children);

  static const String name = 'AdminDashboardRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AdminDashboardPage();
    },
  );
}

/// generated route for
/// [AdminHomePage]
class AdminHomeRoute extends PageRouteInfo<void> {
  const AdminHomeRoute({List<PageRouteInfo>? children})
    : super(AdminHomeRoute.name, initialChildren: children);

  static const String name = 'AdminHomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AdminHomePage();
    },
  );
}

/// generated route for
/// [AdminInsightsPage]
class AdminInsightsRoute extends PageRouteInfo<void> {
  const AdminInsightsRoute({List<PageRouteInfo>? children})
    : super(AdminInsightsRoute.name, initialChildren: children);

  static const String name = 'AdminInsightsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AdminInsightsPage();
    },
  );
}

/// generated route for
/// [AdminPeoplePage]
class AdminPeopleRoute extends PageRouteInfo<void> {
  const AdminPeopleRoute({List<PageRouteInfo>? children})
    : super(AdminPeopleRoute.name, initialChildren: children);

  static const String name = 'AdminPeopleRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AdminPeoplePage();
    },
  );
}

/// generated route for
/// [AdminProfilePage]
class AdminProfileRoute extends PageRouteInfo<void> {
  const AdminProfileRoute({List<PageRouteInfo>? children})
    : super(AdminProfileRoute.name, initialChildren: children);

  static const String name = 'AdminProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AdminProfilePage();
    },
  );
}

/// generated route for
/// [DashboardPage]
class DashboardRoute extends PageRouteInfo<void> {
  const DashboardRoute({List<PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DashboardPage();
    },
  );
}

/// generated route for
/// [ForgetPasswordPage]
class ForgetPasswordRoute extends PageRouteInfo<void> {
  const ForgetPasswordRoute({List<PageRouteInfo>? children})
    : super(ForgetPasswordRoute.name, initialChildren: children);

  static const String name = 'ForgetPasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ForgetPasswordPage();
    },
  );
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomePage();
    },
  );
}

/// generated route for
/// [LessonPage]
class LessonRoute extends PageRouteInfo<LessonRouteArgs> {
  LessonRoute({Key? key, required Lesson lesson, List<PageRouteInfo>? children})
    : super(
        LessonRoute.name,
        args: LessonRouteArgs(key: key, lesson: lesson),
        initialChildren: children,
      );

  static const String name = 'LessonRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LessonRouteArgs>();
      return LessonPage(key: args.key, lesson: args.lesson);
    },
  );
}

class LessonRouteArgs {
  const LessonRouteArgs({this.key, required this.lesson});

  final Key? key;

  final Lesson lesson;

  @override
  String toString() {
    return 'LessonRouteArgs{key: $key, lesson: $lesson}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LessonRouteArgs) return false;
    return key == other.key && lesson == other.lesson;
  }

  @override
  int get hashCode => key.hashCode ^ lesson.hashCode;
}

/// generated route for
/// [LoginPage]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LoginPage();
    },
  );
}

/// generated route for
/// [MarkPage]
class MarkRoute extends PageRouteInfo<void> {
  const MarkRoute({List<PageRouteInfo>? children})
    : super(MarkRoute.name, initialChildren: children);

  static const String name = 'MarkRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MarkPage();
    },
  );
}

/// generated route for
/// [NotificationPage]
class NotificationRoute extends PageRouteInfo<void> {
  const NotificationRoute({List<PageRouteInfo>? children})
    : super(NotificationRoute.name, initialChildren: children);

  static const String name = 'NotificationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NotificationPage();
    },
  );
}

/// generated route for
/// [ProfileDetailPage]
class ProfileDetailRoute extends PageRouteInfo<void> {
  const ProfileDetailRoute({List<PageRouteInfo>? children})
    : super(ProfileDetailRoute.name, initialChildren: children);

  static const String name = 'ProfileDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfileDetailPage();
    },
  );
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfilePage();
    },
  );
}

/// generated route for
/// [RegisterPage]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RegisterPage();
    },
  );
}

/// generated route for
/// [SchedulePage]
class ScheduleRoute extends PageRouteInfo<void> {
  const ScheduleRoute({List<PageRouteInfo>? children})
    : super(ScheduleRoute.name, initialChildren: children);

  static const String name = 'ScheduleRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SchedulePage();
    },
  );
}

/// generated route for
/// [SplashPage]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SplashPage();
    },
  );
}

/// generated route for
/// [TaskDetailsPage]
class TaskDetailsRoute extends PageRouteInfo<TaskDetailsRouteArgs> {
  TaskDetailsRoute({
    Key? key,
    required String assignmentId,
    List<PageRouteInfo>? children,
  }) : super(
         TaskDetailsRoute.name,
         args: TaskDetailsRouteArgs(key: key, assignmentId: assignmentId),
         initialChildren: children,
       );

  static const String name = 'TaskDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TaskDetailsRouteArgs>();
      return TaskDetailsPage(key: args.key, assignmentId: args.assignmentId);
    },
  );
}

class TaskDetailsRouteArgs {
  const TaskDetailsRouteArgs({this.key, required this.assignmentId});

  final Key? key;

  final String assignmentId;

  @override
  String toString() {
    return 'TaskDetailsRouteArgs{key: $key, assignmentId: $assignmentId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TaskDetailsRouteArgs) return false;
    return key == other.key && assignmentId == other.assignmentId;
  }

  @override
  int get hashCode => key.hashCode ^ assignmentId.hashCode;
}

/// generated route for
/// [TaskPage]
class TaskRoute extends PageRouteInfo<void> {
  const TaskRoute({List<PageRouteInfo>? children})
    : super(TaskRoute.name, initialChildren: children);

  static const String name = 'TaskRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TaskPage();
    },
  );
}

/// generated route for
/// [TeacherDashboardPage]
class TeacherDashboardRoute extends PageRouteInfo<void> {
  const TeacherDashboardRoute({List<PageRouteInfo>? children})
    : super(TeacherDashboardRoute.name, initialChildren: children);

  static const String name = 'TeacherDashboardRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TeacherDashboardPage();
    },
  );
}

/// generated route for
/// [TeacherGroupsPage]
class TeacherGroupsRoute extends PageRouteInfo<void> {
  const TeacherGroupsRoute({List<PageRouteInfo>? children})
    : super(TeacherGroupsRoute.name, initialChildren: children);

  static const String name = 'TeacherGroupsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TeacherGroupsPage();
    },
  );
}

/// generated route for
/// [TeacherHomePage]
class TeacherHomeRoute extends PageRouteInfo<void> {
  const TeacherHomeRoute({List<PageRouteInfo>? children})
    : super(TeacherHomeRoute.name, initialChildren: children);

  static const String name = 'TeacherHomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TeacherHomePage();
    },
  );
}

/// generated route for
/// [TeacherProfilePage]
class TeacherProfileRoute extends PageRouteInfo<void> {
  const TeacherProfileRoute({List<PageRouteInfo>? children})
    : super(TeacherProfileRoute.name, initialChildren: children);

  static const String name = 'TeacherProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TeacherProfilePage();
    },
  );
}

/// generated route for
/// [TeacherSchedulePage]
class TeacherScheduleRoute extends PageRouteInfo<void> {
  const TeacherScheduleRoute({List<PageRouteInfo>? children})
    : super(TeacherScheduleRoute.name, initialChildren: children);

  static const String name = 'TeacherScheduleRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TeacherSchedulePage();
    },
  );
}

/// generated route for
/// [TeacherWorkPage]
class TeacherWorkRoute extends PageRouteInfo<void> {
  const TeacherWorkRoute({List<PageRouteInfo>? children})
    : super(TeacherWorkRoute.name, initialChildren: children);

  static const String name = 'TeacherWorkRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const TeacherWorkPage();
    },
  );
}
