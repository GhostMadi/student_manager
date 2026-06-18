import 'package:flutter/material.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/extension/context.dart';
import 'package:student_manager/core/style/app_text_style.dart';
import 'package:student_manager/core/widgets/button.dart';
import 'package:student_manager/core/widgets/text_field.dart';

Future<void> showAdminGroupSheet({
  required BuildContext context,
  required String title,
  String? initialName,
  required Future<bool> Function(String name) onSubmit,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.scaffoldBackground,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (sheetContext) {
      return _AdminGroupSheet(
        parentContext: context,
        title: title,
        initialName: initialName,
        onSubmit: onSubmit,
      );
    },
  );
}

class _AdminGroupSheet extends StatefulWidget {
  const _AdminGroupSheet({
    required this.parentContext,
    required this.title,
    required this.initialName,
    required this.onSubmit,
  });

  final BuildContext parentContext;
  final String title;
  final String? initialName;
  final Future<bool> Function(String name) onSubmit;

  @override
  State<_AdminGroupSheet> createState() => _AdminGroupSheetState();
}

class _AdminGroupSheetState extends State<_AdminGroupSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    var success = false;
    try {
      success = await widget.onSubmit(_nameController.text.trim());
      if (!mounted) return;

      if (success) {
        if (widget.parentContext.mounted) {
          Navigator.of(context).pop();
        }
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
              const SizedBox(height: 20),
              AppTextField(
                label: l10n.adminGroupNameLabel,
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return l10n.adminGroupNameRequired;
                  }
                  return null;
                },
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
