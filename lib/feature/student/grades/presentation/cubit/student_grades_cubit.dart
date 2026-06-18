import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_manager/core/academic/subject_marks_aggregator.dart';
import 'package:student_manager/core/data/grades_repository.dart';
import 'package:student_manager/core/utils/app_logger.dart';
import 'package:student_manager/feature/student/mark_page/presntation/page/subject_model.dart';

class StudentGradesState {
  const StudentGradesState({
    this.isLoading = true,
    this.subjects = const [],
    this.overallGpa = 0,
    this.errorCode,
  });

  final bool isLoading;
  final List<SubjectMarks> subjects;
  final double overallGpa;
  final String? errorCode;

  StudentGradesState copyWith({
    bool? isLoading,
    List<SubjectMarks>? subjects,
    double? overallGpa,
    String? errorCode,
    bool clearError = false,
  }) {
    return StudentGradesState(
      isLoading: isLoading ?? this.isLoading,
      subjects: subjects ?? this.subjects,
      overallGpa: overallGpa ?? this.overallGpa,
      errorCode: clearError ? null : (errorCode ?? this.errorCode),
    );
  }
}

class StudentGradesCubit extends Cubit<StudentGradesState> {
  StudentGradesCubit({
    required String studentId,
    GradesRepository? gradesRepository,
  })  : _studentId = studentId,
        _gradesRepository = gradesRepository ?? GradesRepository(),
        super(const StudentGradesState());

  final String _studentId;
  final GradesRepository _gradesRepository;
  StreamSubscription? _subscription;

  void start() {
    _subscription?.cancel();
    emit(state.copyWith(isLoading: true, clearError: true));

    _subscription = _gradesRepository.watchStudentGrades(_studentId).listen(
      (grades) {
        final marksBySubject = groupScoresBySubject(
          grades.map((g) => (subjectName: g.subjectName, score: g.score)),
        );
        final subjects = aggregateGradesBySubject(marksBySubject);
        final gpa = overallGpaFromSubjects(subjects);

        emit(
          StudentGradesState(
            isLoading: false,
            subjects: subjects,
            overallGpa: gpa,
          ),
        );
      },
      onError: (Object e, StackTrace stackTrace) {
        AppLogger.error('StudentGradesCubit', 'Grades stream failed', e, stackTrace);
        emit(state.copyWith(isLoading: false, errorCode: 'unknown'));
      },
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
