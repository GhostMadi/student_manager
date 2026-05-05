import 'package:flutter/material.dart';
import 'package:student_manager/l10n/app_localizations.dart';

extension ContextExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
