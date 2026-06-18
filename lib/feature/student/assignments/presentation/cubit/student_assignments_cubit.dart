import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_manager/core/academic/assignment_model.dart';
import 'package:student_manager/core/data/assignments_repository.dart';
import 'package:student_manager/core/data/user_firestore_service.dart';
import 'package:student_manager/core/utils/app_logger.dart';

class StudentAssignmentsState {
  const StudentAssignmentsState({
    this.isLoading = true,
    this.groupId,
    this.assignments = const [],
    this.submissions = const [],
    this.errorCode,
    this.isSubmitting = false,
    this.submitSuccess = false,
  });

  final bool isLoading;
  final String? groupId;
  final List<AssignmentModel> assignments;
  final List<SubmissionModel> submissions;
  final String? errorCode;
  final bool isSubmitting;
  final bool submitSuccess;

  SubmissionModel? submissionFor(String assignmentId) {
    for (final submission in submissions) {
      if (submission.assignmentId == assignmentId) return submission;
    }
    return null;
  }

  StudentAssignmentsState copyWith({
    bool? isLoading,
    String? groupId,
    List<AssignmentModel>? assignments,
    List<SubmissionModel>? submissions,
    String? errorCode,
    bool? isSubmitting,
    bool? submitSuccess,
    bool clearError = false,
    bool clearSuccess = false,
  }) {
    return StudentAssignmentsState(
      isLoading: isLoading ?? this.isLoading,
      groupId: groupId ?? this.groupId,
      assignments: assignments ?? this.assignments,
      submissions: submissions ?? this.submissions,
      errorCode: clearError ? null : (errorCode ?? this.errorCode),
      isSubmitting: isSubmitting ?? this.isSubmitting,
      submitSuccess: clearSuccess ? false : (submitSuccess ?? this.submitSuccess),
    );
  }
}

class StudentAssignmentsCubit extends Cubit<StudentAssignmentsState> {
  StudentAssignmentsCubit({
    required String studentId,
    required String studentName,
    AssignmentsRepository? assignmentsRepository,
    UserFirestoreService? userFirestoreService,
  })  : _studentId = studentId,
        _studentName = studentName,
        _assignmentsRepository = assignmentsRepository ?? AssignmentsRepository(),
        _userFirestore = userFirestoreService ?? UserFirestoreService(),
        super(const StudentAssignmentsState());

  final String _studentId;
  final String _studentName;
  final AssignmentsRepository _assignmentsRepository;
  final UserFirestoreService _userFirestore;

  StreamSubscription? _assignmentsSub;
  StreamSubscription? _submissionsSub;

  Future<void> start() async {
    emit(state.copyWith(isLoading: true, clearError: true));

    try {
      final profile = await _userFirestore.getUser(_studentId);
      final groupId = profile.groupId ?? '';

      _assignmentsSub?.cancel();
      _submissionsSub?.cancel();

      _assignmentsSub = _assignmentsRepository.watchAssignmentsForGroup(groupId).listen(
        (assignments) => emit(state.copyWith(assignments: assignments, isLoading: false, groupId: groupId)),
        onError: (Object e, StackTrace st) {
          AppLogger.error('StudentAssignmentsCubit', 'Assignments stream failed', e, st);
          emit(state.copyWith(isLoading: false, errorCode: 'unknown'));
        },
      );

      _submissionsSub = _assignmentsRepository.watchStudentSubmissions(_studentId).listen(
        (submissions) => emit(state.copyWith(submissions: submissions)),
        onError: (Object e, StackTrace st) {
          AppLogger.error('StudentAssignmentsCubit', 'Submissions stream failed', e, st);
        },
      );

      emit(state.copyWith(groupId: groupId));
    } catch (e, stackTrace) {
      AppLogger.error('StudentAssignmentsCubit', 'Start failed', e, stackTrace);
      emit(state.copyWith(isLoading: false, errorCode: 'unknown'));
    }
  }

  Future<SubmissionModel?> ensureSubmission(AssignmentModel assignment) async {
    try {
      final existing = state.submissionFor(assignment.id);
      if (existing != null) return existing;

      return await _assignmentsRepository.getOrCreateSubmission(
        assignment: assignment,
        studentId: _studentId,
        studentName: _studentName,
      );
    } catch (e, stackTrace) {
      AppLogger.error('StudentAssignmentsCubit', 'Ensure submission failed', e, stackTrace);
      emit(state.copyWith(errorCode: 'unknown'));
      return null;
    }
  }

  Future<bool> submitWork({
    required String submissionId,
    required String textAnswer,
  }) async {
    if (textAnswer.trim().isEmpty) {
      emit(state.copyWith(errorCode: 'empty-answer'));
      return false;
    }

    emit(state.copyWith(isSubmitting: true, clearError: true, clearSuccess: true));

    try {
      await _assignmentsRepository.submitWork(submissionId: submissionId, textAnswer: textAnswer);
      emit(state.copyWith(isSubmitting: false, submitSuccess: true));
      return true;
    } catch (e, stackTrace) {
      AppLogger.error('StudentAssignmentsCubit', 'Submit failed', e, stackTrace);
      emit(state.copyWith(isSubmitting: false, errorCode: 'unknown'));
      return false;
    }
  }

  void clearMessages() {
    emit(state.copyWith(clearError: true, clearSuccess: true));
  }

  @override
  Future<void> close() {
    _assignmentsSub?.cancel();
    _submissionsSub?.cancel();
    return super.close();
  }
}
