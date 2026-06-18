import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/extension/context.dart';
import 'package:student_manager/core/style/app_text_style.dart';
import 'package:student_manager/core/utils/auth_error_mapper.dart';
import 'package:student_manager/core/widgets/snack_bar.dart';
import 'package:student_manager/feature/admin/people/presentation/cubit/admin_people_cubit.dart';
import 'package:student_manager/feature/admin/people/presentation/widgets/add_user_sheet.dart';
import 'package:student_manager/feature/admin/presentation/widgets/admin_components.dart';
import 'package:student_manager/feature/login_page/data/model/user_model.dart';

@RoutePage()
class AdminPeoplePage extends StatefulWidget {
  const AdminPeoplePage({super.key});

  @override
  State<AdminPeoplePage> createState() => _AdminPeoplePageState();
}

class _AdminPeoplePageState extends State<AdminPeoplePage> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AdminPeopleCubit>().loadUsers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty);
    return parts.take(2).map((w) => w[0]).join().toUpperCase();
  }

  Future<void> _openAddStudentSheet() {
    final cubit = context.read<AdminPeopleCubit>();
    return showAdminAddUserSheet(
      context: context,
      title: context.l10n.adminAddStudentTitle,
      onSubmit: (name, email, password) => cubit.addStudent(
        displayName: name,
        email: email,
        password: password,
      ),
    );
  }

  Future<void> _openAddCuratorSheet() {
    final cubit = context.read<AdminPeopleCubit>();
    return showAdminAddUserSheet(
      context: context,
      title: context.l10n.adminAddCuratorTitle,
      onSubmit: (name, email, password) => cubit.addCurator(
        displayName: name,
        email: email,
        password: password,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocConsumer<AdminPeopleCubit, AdminPeopleState>(
      listenWhen: (previous, current) => previous.errorCode != current.errorCode,
      listener: (context, state) {
        if (state.errorCode != null) {
          AppSnackBar.show(
            context,
            message: mapAuthErrorMessage(context, state.errorCode!),
            isError: true,
          );
          context.read<AdminPeopleCubit>().clearError();
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldBackground,
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () => context.read<AdminPeopleCubit>().loadUsers(force: true),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: kAdminPagePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.adminPeopleTitle, style: AppTextStyles.h1.copyWith(fontSize: 24)),
                    const SizedBox(height: 6),
                    Text(l10n.adminHomeSubtitle, style: AppTextStyles.caption),
                    const SizedBox(height: 18),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: AdminSummaryWideCard(
                            value: '${state.students.length}',
                            caption: l10n.adminPeopleSummaryStudents,
                            trend: l10n.adminSectionStudents,
                            icon: Icons.school_rounded,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AdminSummaryWideCard(
                            value: '${state.teachers.length}',
                            caption: l10n.adminPeopleSummaryTeachers,
                            trend: l10n.adminSectionTeachers,
                            icon: Icons.co_present_outlined,
                            dark: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    TextField(
                      controller: _searchController,
                      onChanged: context.read<AdminPeopleCubit>().updateSearch,
                      decoration: InputDecoration(
                        hintText: l10n.adminPeopleSearchHint,
                        prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                        filled: true,
                        fillColor: AppColors.surfaceWhite,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _toolChip(
                            context,
                            Icons.person_add_alt_1_outlined,
                            l10n.adminStudentAdd,
                            state.isSubmitting ? null : _openAddStudentSheet,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    AdminSectionHeader(title: l10n.adminSectionStudents),
                    if (state.isLoading)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    else if (state.filteredStudents.isEmpty)
                      _emptyLabel(l10n.adminNoStudents)
                    else
                      ..._userTiles(state.filteredStudents, AppColors.primaryOrange),
                    const SizedBox(height: 20),
                    AdminSectionHeader(title: l10n.adminSectionTeachers),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _toolChip(
                            context,
                            Icons.person_add_outlined,
                            l10n.adminAddCuratorTitle,
                            state.isSubmitting ? null : _openAddCuratorSheet,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (!state.isLoading && state.filteredTeachers.isEmpty)
                      _emptyLabel(l10n.adminNoTeachers)
                    else if (!state.isLoading)
                      ..._userTiles(state.filteredTeachers, AppColors.deepBlack),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _emptyLabel(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(text, style: AppTextStyles.caption),
    );
  }

  List<Widget> _userTiles(List<UserModel> users, Color accentColor) {
    return users.map((user) {
      return AdminPersonRosterTile(
        initials: _initials(user.displayName).isEmpty ? '?' : _initials(user.displayName),
        title: user.displayName,
        subtitle: user.email,
        accentColor: accentColor,
        onTap: () {},
      );
    }).toList();
  }

  Widget _toolChip(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback? onPressed,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ActionChip(
        avatar: Icon(icon, size: 18, color: AppColors.primaryOrange),
        label: Text(label, style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600, fontSize: 12)),
        onPressed: onPressed,
        backgroundColor: AppColors.surfaceWhite,
        side: BorderSide(color: AppColors.deepBlack.withValues(alpha: 0.08)),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      ),
    );
  }
}
