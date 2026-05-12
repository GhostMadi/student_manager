import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/router/app_router.dart';
import 'package:student_manager/core/widgets/dashboard_capsule.dart';

@RoutePage()
class TeacherDashboardPage extends StatelessWidget {
  const TeacherDashboardPage({super.key});

  static const _icons = <IconData>[
    CupertinoIcons.house_fill,
    CupertinoIcons.person_3_fill,
    CupertinoIcons.calendar,
    CupertinoIcons.doc_text_fill,
    CupertinoIcons.person_fill,
  ];

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        TeacherHomeRoute(),
        TeacherGroupsRoute(),
        TeacherScheduleRoute(),
        TeacherWorkRoute(),
        TeacherProfileRoute(),
      ],
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
    );
  }
}
