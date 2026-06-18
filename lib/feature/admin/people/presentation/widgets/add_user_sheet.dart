import 'package:flutter/material.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/extension/context.dart';
import 'package:student_manager/core/style/app_text_style.dart';
import 'package:student_manager/core/validator/validators.dart';
import 'package:student_manager/core/widgets/button.dart';
import 'package:student_manager/core/widgets/snack_bar.dart';
import 'package:student_manager/core/widgets/text_field.dart';
import 'package:student_manager/feature/admin/people/data/repository/users_repository.dart';

Future<void> showAdminAddUserSheet({
  required BuildContext context,
  required String title,
  required Future<bool> Function(String name, String email, String password) onSubmit,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.scaffoldBackground,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (sheetContext) {
      return _AddUserSheet(
        parentContext: context,
        title: title,
        onSubmit: onSubmit,
      );
    },
  );
}

class _AddUserSheet extends StatefulWidget {
  const _AddUserSheet({
    required this.parentContext,
    required this.title,
    required this.onSubmit,
  });

  final BuildContext parentContext;
  final String title;
  final Future<bool> Function(String name, String email, String password) onSubmit;

  @override
  State<_AddUserSheet> createState() => _AddUserSheetState();
}

class _AddUserSheetState extends State<_AddUserSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController(text: UsersRepository.defaultUserPassword);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    var success = false;
    try {
      success = await widget.onSubmit(
        _nameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (!mounted) return;

      if (success) {
        if (widget.parentContext.mounted) {
          AppSnackBar.show(
            widget.parentContext,
            message: widget.parentContext.l10n.adminUserAddedSuccess,
            isError: false,
          );
        }
        Navigator.of(context).pop();
      }
    } finally {
      if (mounted && !success) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.title, style: AppTextStyles.h1.copyWith(fontSize: 22)),
              const SizedBox(height: 8),
              Text(l10n.adminDefaultPasswordHint, style: AppTextStyles.caption),
              const SizedBox(height: 20),
              AppTextField(
                label: l10n.fullName,
                controller: _nameController,
                validator: (value) => AppValidators.name(value, context),
              ),
              const SizedBox(height: 12),
              AppTextField(
                label: l10n.email,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => AppValidators.email(value, context),
              ),
              const SizedBox(height: 12),
              AppTextField(
                label: l10n.password,
                controller: _passwordController,
                obscureText: true,
                validator: (value) => AppValidators.password(value, context),
              ),
              const SizedBox(height: 24),
              AppButton(
                text: widget.title,
                isLoading: _isLoading,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
