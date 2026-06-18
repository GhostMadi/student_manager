import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_manager/core/academic/assignment_model.dart';
import 'package:student_manager/core/data/assignments_repository.dart';
import 'package:student_manager/core/utils/app_logger.dart';

class TaskDetailsState {
  const TaskDetailsState({
    this.isLoading = true,
    this.assignment,
    this.submission,
    this.errorCode,
    this.isSubmitting = false,
    this.submitSuccess = false,
  });

  final bool isLoading;
  final AssignmentModel? assignment;
  final SubmissionModel? submission;
  final String? errorCode;
  final bool isSubmitting;
  final bool submitSuccess;

  TaskDetailsState copyWith({
    bool? isLoading,
    AssignmentModel? assignment,
    SubmissionModel? submission,
    String? errorCode,
    bool? isSubmitting,
    bool? submitSuccess,
    bool clearError = false,
    bool clearSuccess = false,
  }) {
    return TaskDetailsState(
      isLoading: isLoading ?? this.isLoading,
      assignment: assignment ?? this.assignment,
      submission: submission ?? this.submission,
      errorCode: clearError ? null : (errorCode ?? this.errorCode),
      isSubmitting: isSubmitting ?? this.isSubmitting,
      submitSuccess: clearSuccess ? false : (submitSuccess ?? this.submitSuccess),
    );
  }
}

class TaskDetailsCubit extends Cubit<TaskDetailsState> {
  TaskDetailsCubit({
    required String assignmentId,
    required String studentId,
    required String studentName,
    AssignmentsRepository? assignmentsRepository,
  })  : _assignmentId = assignmentId,
        _studentId = studentId,
        _studentName = studentName,
        _assignmentsRepository = assignmentsRepository ?? AssignmentsRepository(),
        super(const TaskDetailsState());

  final String _assignmentId;
  final String _studentId;
  final String _studentName;
  final AssignmentsRepository _assignmentsRepository;

  StreamSubscription? _submissionSub;

  Future<void> load() async {
    emit(state.copyWith(isLoading: true, clearError: true, clearSuccess: true));

    try {
      final assignment = await _assignmentsRepository.fetchAssignmentById(_assignmentId);
      if (assignment == null) {
        emit(state.copyWith(isLoading: false, errorCode: 'assignment-not-found'));
        return;
      }

      final submission = await _assignmentsRepository.getOrCreateSubmission(
        assignment: assignment,
        studentId: _studentId,
        studentName: _studentName,
      );

      emit(state.copyWith(isLoading: false, assignment: assignment, submission: submission));
      _watchSubmission(submission.id);
    } catch (e, stackTrace) {
      AppLogger.error('TaskDetailsCubit', 'Load failed', e, stackTrace);
      emit(state.copyWith(isLoading: false, errorCode: 'unknown'));
    }
  }

  void _watchSubmission(String submissionId) {
    _submissionSub?.cancel();
    _submissionSub = _assignmentsRepository.watchSubmission(submissionId).listen(
      (submission) {
        if (submission != null) {
          emit(state.copyWith(submission: submission));
        }
      },
      onError: (Object e, StackTrace st) {
        AppLogger.error('TaskDetailsCubit', 'Submission stream failed', e, st);
      },
    );
  }

  Future<bool> submitWork(String textAnswer) async {
    final submission = state.submission;
    if (submission == null) return false;

    if (textAnswer.trim().isEmpty) {
      emit(state.copyWith(errorCode: 'empty-answer'));
      return false;
    }

    emit(state.copyWith(isSubmitting: true, clearError: true, clearSuccess: true));

    try {
      await _assignmentsRepository.submitWork(
        submissionId: submission.id,
        textAnswer: textAnswer,
      );
      emit(state.copyWith(isSubmitting: false, submitSuccess: true));
      return true;
    } catch (e, stackTrace) {
      AppLogger.error('TaskDetailsCubit', 'Submit failed', e, stackTrace);
      emit(state.copyWith(isSubmitting: false, errorCode: 'unknown'));
      return false;
    }
  }

  void clearMessages() {
    emit(state.copyWith(clearError: true, clearSuccess: true));
  }

  @override
  Future<void> close() {
    _submissionSub?.cancel();
    return super.close();
  }
}
