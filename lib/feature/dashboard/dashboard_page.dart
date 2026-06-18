import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/router/app_router.dart';
import 'package:student_manager/core/storage/storage_service.dart';
import 'package:student_manager/core/widgets/dashboard_capsule.dart';
import 'package:student_manager/feature/student/assignments/presentation/cubit/student_assignments_cubit.dart';
import 'package:student_manager/feature/student/grades/presentation/cubit/student_grades_cubit.dart';

@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  static const _icons = <IconData>[
    CupertinoIcons.house_fill,
    CupertinoIcons.chart_bar_fill,
    CupertinoIcons.calendar,
    CupertinoIcons.check_mark_circled,
    CupertinoIcons.person_fill,
  ];

  @override
  Widget build(BuildContext context) {
    final studentId = FirebaseAuth.instance.currentUser?.uid ?? '';
    final studentName = StorageService.instance.userName ?? 'Student';

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => StudentGradesCubit(studentId: studentId)..start()),
        BlocProvider(
          create: (_) => StudentAssignmentsCubit(studentId: studentId, studentName: studentName)..start(),
        ),
      ],
      child: AutoTabsRouter(
        routes: const [HomeRoute(), MarkRoute(), ScheduleRoute(), TaskRoute(), ProfileRoute()],
        builder: (context, child) {
          final tabsRouter = AutoTabsRouter.of(context);

          return Scaffold(
            extendBody: true,
            backgroundColor: AppColors.scaffoldBackground,
            body: Stack(
              children: [
                child,
                Positioned(
                  bottom: 30,
                  left: 60,
                  right: 60,
                  child: DashboardCapsule(tabsRouter: tabsRouter, icons: _icons),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
