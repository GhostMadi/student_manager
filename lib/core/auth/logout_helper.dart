import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_manager/core/router/app_router.dart';
import 'package:student_manager/feature/login_page/data/repository/auth_repository.dart';
import 'package:student_manager/feature/login_page/presentation/cubit/login_cubit.dart';

Future<void> logoutAndGoToLogin(BuildContext context) async {
  await AuthRepository().signOut();
  if (!context.mounted) return;

  context.read<LoginCubit>().clearSession();
  await context.router.root.replaceAll([const LoginRoute()]);
}
