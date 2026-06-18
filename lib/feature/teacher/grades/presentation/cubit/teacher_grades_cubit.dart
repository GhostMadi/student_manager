import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_manager/core/academic/assignment_model.dart';
import 'package:student_manager/core/data/assignments_repository.dart';
import 'package:student_manager/core/data/grades_repository.dart';
import 'package:student_manager/core/data/user_firestore_service.dart';
import 'package:student_manager/core/storage/storage_service.dart';
import 'package:student_manager/core/utils/app_logger.dart';
import 'package:student_manager/feature/login_page/data/model/user_model.dart';
import 'package:student_manager/feature/admin/academic/data/model/group_model.dart';
import 'package:student_manager/feature/admin/academic/data/repository/groups_repository.dart';
import 'package:student_manager/feature/admin/people/data/repository/users_repository.dart';

class TeacherGradesState {
  const TeacherGradesState({
    this.isLoading = false,
    this.isSubmitting = false,
    this.groups = const [],
    this.studentsByGroupId = const {},
    this.assignments = const [],
    this.submissions = const [],
    this.selectedGroupId,
    this.errorCode,
    this.success = false,
    this.successIsAssignment = false,
  });

  final bool isLoading;
  final bool isSubmitting;
  final List<GroupModel> groups;
  final Map<String, List<UserModel>> studentsByGroupId;
  final List<AssignmentModel> assignments;
  final List<SubmissionModel> submissions;
  final String? selectedGroupId;
  final String? errorCode;
  final bool success;
  final bool successIsAssignment;

  List<UserModel> get students {
    if (selectedGroupId == null) return const [];
    return studentsByGroupId[selectedGroupId] ?? const [];
  }

  List<UserModel> studentsForGroup(String groupId) => studentsByGroupId[groupId] ?? const [];

  List<SubmissionModel> get pendingSubmissions =>
      submissions.where((s) => s.status == SubmissionStatus.submitted).toList();

  GroupModel? get selectedGroup {
    if (selectedGroupId == null) return null;
    for (final group in groups) {
      if (group.id == selectedGroupId) return group;
    }
    return null;
  }

  TeacherGradesState copyWith({
    bool? isLoading,
    bool? isSubmitting,
    List<GroupModel>? groups,
    Map<String, List<UserModel>>? studentsByGroupId,
    List<AssignmentModel>? assignments,
    List<SubmissionModel>? submissions,
    String? selectedGroupId,
    String? errorCode,
    bool? success,
    bool? successIsAssignment,
    bool clearError = false,
    bool clearSuccess = false,
  }) {
    return TeacherGradesState(
      isLoading: isLoading ?? this.isLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      groups: groups ?? this.groups,
      studentsByGroupId: studentsByGroupId ?? this.studentsByGroupId,
      assignments: assignments ?? this.assignments,
      submissions: submissions ?? this.submissions,
      selectedGroupId: selectedGroupId ?? this.selectedGroupId,
      errorCode: clearError ? null : (errorCode ?? this.errorCode),
      success: clearSuccess ? false : (success ?? this.success),
      successIsAssignment: clearSuccess ? false : (successIsAssignment ?? this.successIsAssignment),
    );
  }
}

class TeacherGradesCubit extends Cubit<TeacherGradesState> {
  TeacherGradesCubit({
    required String teacherId,
    GroupsRepository? groupsRepository,
    UsersRepository? usersRepository,
    GradesRepository? gradesRepository,
    AssignmentsRepository? assignmentsRepository,
  })  : _teacherId = teacherId,
        _groupsRepository = groupsRepository ?? GroupsRepository(),
        _usersRepository = usersRepository ?? UsersRepository(),
        _gradesRepository = gradesRepository ?? GradesRepository(),
        _assignmentsRepository = assignmentsRepository ?? AssignmentsRepository(),
        super(const TeacherGradesState());

  final String _teacherId;
  final GroupsRepository _groupsRepository;
  final UsersRepository _usersRepository;
  final GradesRepository _gradesRepository;
  final AssignmentsRepository _assignmentsRepository;
  final UserFirestoreService _userFirestore = UserFirestoreService();

  StreamSubscription? _assignmentsSub;
  StreamSubscription? _submissionsSub;

  Future<void> loadGroups() async {
    emit(state.copyWith(isLoading: true, clearError: true, clearSuccess: true));

    try {
      var teacherName = StorageService.instance.userName ?? '';
      var teacherEmail = '';

      try {
        final profile = await _userFirestore.getUser(_teacherId);
        teacherName = profile.displayName;
        teacherEmail = profile.email;
      } catch (e, stackTrace) {
        AppLogger.error('TeacherGradesCubit', 'Load teacher profile failed', e, stackTrace);
      }

      final groups = await _groupsRepository.fetchGroupsForTeacher(
        teacherId: _teacherId,
        teacherName: teacherName,
        teacherEmail: teacherEmail,
      );
      final studentsByGroupId = await _loadStudentsForGroups(groups);
      final selectedGroupId = state.selectedGroupId ?? (groups.isNotEmpty ? groups.first.id : null);

      emit(
        TeacherGradesState(
          isLoading: false,
          groups: groups,
          studentsByGroupId: studentsByGroupId,
          selectedGroupId: selectedGroupId,
          assignments: state.assignments,
          submissions: state.submissions,
        ),
      );

      if (selectedGroupId != null) {
        _watchGroupData(selectedGroupId);
      }
    } catch (e, stackTrace) {
      AppLogger.error('TeacherGradesCubit', 'Load groups failed', e, stackTrace);
      emit(state.copyWith(isLoading: false, errorCode: 'unknown'));
    }
  }

  Future<void> selectGroup(String groupId) async {
    final group = state.groups.where((g) => g.id == groupId).firstOrNull;
    if (group == null) return;

    emit(state.copyWith(isLoading: true, selectedGroupId: groupId, clearError: true));

    try {
      final students = await _usersRepository.fetchStudentsForGroup(
        groupId: group.id,
        memberIds: group.memberIds,
      );

      final updatedMap = Map<String, List<UserModel>>.from(state.studentsByGroupId)
        ..[groupId] = students;

      emit(state.copyWith(isLoading: false, studentsByGroupId: updatedMap));
      _watchGroupData(groupId);
    } catch (e, stackTrace) {
      AppLogger.error('TeacherGradesCubit', 'Load students failed', e, stackTrace);
      emit(state.copyWith(isLoading: false, errorCode: 'unknown'));
    }
  }

  void _watchGroupData(String groupId) {
    _assignmentsSub?.cancel();
    _submissionsSub?.cancel();

    _assignmentsSub = _assignmentsRepository.watchAssignmentsForGroup(groupId).listen(
      (assignments) => emit(state.copyWith(assignments: assignments)),
      onError: (Object e, StackTrace st) {
        AppLogger.error('TeacherGradesCubit', 'Assignments stream failed', e, st);
      },
    );

    _submissionsSub = _assignmentsRepository.watchGroupSubmissions(groupId).listen(
      (submissions) => emit(state.copyWith(submissions: submissions)),
      onError: (Object e, StackTrace st) {
        AppLogger.error('TeacherGradesCubit', 'Submissions stream failed', e, st);
      },
    );
  }

  Future<bool> createAssignment({
    required String title,
    required String description,
    required String subjectName,
    required DateTime dueAt,
  }) async {
    final group = state.selectedGroup;
    if (group == null) {
      emit(state.copyWith(errorCode: 'no-group-selected'));
      return false;
    }

    emit(state.copyWith(isSubmitting: true, clearError: true, clearSuccess: true));

    try {
      await _assignmentsRepository.createAssignment(
        title: title,
        description: description,
        subjectName: subjectName,
        groupId: group.id,
        teacherId: _teacherId,
        dueAt: dueAt,
      );

      emit(state.copyWith(isSubmitting: false, success: true, successIsAssignment: true));
      return true;
    } catch (e, stackTrace) {
      AppLogger.error('TeacherGradesCubit', 'Create assignment failed', e, stackTrace);
      emit(state.copyWith(isSubmitting: false, errorCode: 'unknown'));
      return false;
    }
  }

  Future<bool> gradeSubmission({
    required SubmissionModel submission,
    required int score,
    String? feedback,
  }) async {
    emit(state.copyWith(isSubmitting: true, clearError: true, clearSuccess: true));

    try {
      final gradeId = await _gradesRepository.addGrade(
        studentId: submission.studentId,
        studentName: submission.studentName,
        subjectName: submission.subjectName ?? '',
        groupId: submission.groupId,
        teacherId: _teacherId,
        score: score,
        workName: submission.assignmentTitle,
        assignmentId: submission.assignmentId,
        submissionId: submission.id,
      );

      await _assignmentsRepository.gradeSubmission(
        submission: submission,
        score: score,
        feedback: feedback,
        gradeId: gradeId,
      );

      emit(state.copyWith(isSubmitting: false, success: true, successIsAssignment: false));
      return true;
    } on AuthException catch (e) {
      AppLogger.error('TeacherGradesCubit', 'Grade submission failed: ${e.code}', e);
      emit(state.copyWith(isSubmitting: false, errorCode: e.code));
      return false;
    } catch (e, stackTrace) {
      AppLogger.error('TeacherGradesCubit', 'Grade submission failed', e, stackTrace);
      emit(state.copyWith(isSubmitting: false, errorCode: 'unknown'));
      return false;
    }
  }

  Future<bool> addGrade({
    required String studentId,
    required String studentName,
    required String subjectName,
    required int score,
    String? workName,
  }) async {
    final group = state.selectedGroup;
    if (group == null) {
      emit(state.copyWith(errorCode: 'no-group-selected'));
      return false;
    }

    emit(state.copyWith(isSubmitting: true, clearError: true, clearSuccess: true));

    try {
      await _gradesRepository.addGrade(
        studentId: studentId,
        studentName: studentName,
        subjectName: subjectName,
        groupId: group.id,
        teacherId: _teacherId,
        score: score,
        workName: workName,
      );

      emit(state.copyWith(isSubmitting: false, success: true, successIsAssignment: false));
      return true;
    } on AuthException catch (e) {
      AppLogger.error('TeacherGradesCubit', 'Add grade failed: ${e.code}', e);
      emit(state.copyWith(isSubmitting: false, errorCode: e.code));
      return false;
    } catch (e, stackTrace) {
      AppLogger.error('TeacherGradesCubit', 'Add grade failed', e, stackTrace);
      emit(state.copyWith(isSubmitting: false, errorCode: 'unknown'));
      return false;
    }
  }

  Future<Map<String, List<UserModel>>> _loadStudentsForGroups(List<GroupModel> groups) async {
    final studentsByGroupId = <String, List<UserModel>>{};

    for (final group in groups) {
      studentsByGroupId[group.id] = await _usersRepository.fetchStudentsForGroup(
        groupId: group.id,
        memberIds: group.memberIds,
      );
    }

    return studentsByGroupId;
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

extension<T> on Iterable<T> {
  T? get firstOrNull {
    final iterator = this.iterator;
    if (!iterator.moveNext()) return null;
    return iterator.current;
  }
}
