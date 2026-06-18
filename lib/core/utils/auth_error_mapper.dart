import 'package:flutter/widgets.dart';
import 'package:student_manager/core/extension/context.dart';

String mapAuthErrorMessage(BuildContext context, String code) {
  final l10n = context.l10n;

  switch (code) {
    case 'invalid-email':
      return l10n.loginError;
    case 'user-not-found':
      return l10n.userNotFound;
    case 'wrong-password':
    case 'invalid-credential':
    case 'user-disabled':
      return l10n.loginError;
    case 'email-already-in-use':
      return l10n.emailAlreadyInUse;
    case 'email-already-in-use-other-password':
      return l10n.emailAlreadyInUseOtherPassword;
    case 'cannot-modify-admin':
      return l10n.cannotModifyAdmin;
    case 'invalid-score':
      return l10n.enterScoreTitle;
    case 'empty-answer':
      return l10n.emptyAnswerError;
    case 'assignment-not-found':
      return l10n.noAssignmentsYet;
    case 'no-group-selected':
      return l10n.teacherSelectGroup;
    case 'group-name-empty':
      return l10n.adminGroupNameRequired;
    case 'admin-already-exists':
      return l10n.adminAlreadyExists;
    case 'profile-not-found':
      return l10n.profileNotFound;
    case 'weak-password':
      return l10n.passwordValidationError;
    case 'invalid-action-code':
    case 'expired-action-code':
      return l10n.invalidResetCode;
    case 'permission-denied':
      return l10n.firestorePermissionDenied;
    case 'network-request-failed':
      return l10n.unexpectedError;
    default:
      return l10n.authGenericError;
  }
}
