import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_manager/core/data/user_firestore_service.dart';
import 'package:student_manager/core/utils/app_logger.dart';
import 'package:student_manager/feature/admin/academic/data/model/group_model.dart';
import 'package:student_manager/feature/admin/academic/data/repository/groups_repository.dart';
import 'package:student_manager/feature/admin/people/data/repository/users_repository.dart';
import 'package:student_manager/feature/login_page/data/model/user_model.dart';

class AdminAcademicState {
  const AdminAcademicState({
    this.isLoading = false,
    this.isAssigning = false,
    this.isUpdatingRoster = false,
    this.isSavingGroup = false,
    this.groups = const [],
    this.teachers = const [],
    this.students = const [],
    this.errorCode,
  });

  final bool isLoading;
  final bool isAssigning;
  final bool isUpdatingRoster;
  final bool isSavingGroup;
  final List<GroupModel> groups;
  final List<UserModel> teachers;
  final List<UserModel> students;
  final String? errorCode;

  AdminAcademicState copyWith({
    bool? isLoading,
    bool? isAssigning,
    bool? isUpdatingRoster,
    bool? isSavingGroup,
    List<GroupModel>? groups,
    List<UserModel>? teachers,
    List<UserModel>? students,
    String? errorCode,
    bool clearError = false,
  }) {
    return AdminAcademicState(
      isLoading: isLoading ?? this.isLoading,
      isAssigning: isAssigning ?? this.isAssigning,
      isUpdatingRoster: isUpdatingRoster ?? this.isUpdatingRoster,
      isSavingGroup: isSavingGroup ?? this.isSavingGroup,
      groups: groups ?? this.groups,
      teachers: teachers ?? this.teachers,
      students: students ?? this.students,
      errorCode: clearError ? null : (errorCode ?? this.errorCode),
    );
  }
}

class AdminAcademicCubit extends Cubit<AdminAcademicState> {
  AdminAcademicCubit({
    GroupsRepository? groupsRepository,
    UsersRepository? usersRepository,
    UserFirestoreService? userFirestoreService,
  })  : _groupsRepository = groupsRepository ?? GroupsRepository(),
        _usersRepository = usersRepository ?? UsersRepository(),
        _userFirestore = userFirestoreService ?? UserFirestoreService(),
        super(const AdminAcademicState());

  final GroupsRepository _groupsRepository;
  final UsersRepository _usersRepository;
  final UserFirestoreService _userFirestore;

  Future<void> loadData() async {
    emit(state.copyWith(isLoading: true, clearError: true));

    try {
      final groupsFuture = _groupsRepository.fetchGroups();
      final usersFuture = _usersRepository.fetchAllUsers();

      final groups = await groupsFuture;
      final users = await usersFuture;

      final repairedGroups = await _repairMissingCuratorIds(groups, users.teachers);

      emit(
        state.copyWith(
          isLoading: false,
          groups: repairedGroups,
          teachers: users.teachers,
          students: users.students,
        ),
      );
    } catch (e, stackTrace) {
      AppLogger.error('AdminAcademicCubit', 'Load data failed', e, stackTrace);
      emit(state.copyWith(isLoading: false, errorCode: 'unknown'));
    }
  }

  Future<bool> assignCurator({
    required String groupId,
    required UserModel curator,
  }) async {
    emit(state.copyWith(isAssigning: true, clearError: true));

    try {
      await _groupsRepository.assignCurator(
        groupId: groupId,
        curatorId: curator.uid,
        curatorName: curator.displayName,
      );

      final groups = state.groups.map((group) {
        if (group.id != groupId) return group;
        return group.copyWith(curatorId: curator.uid, curatorName: curator.displayName);
      }).toList();

      emit(state.copyWith(isAssigning: false, groups: groups));
      return true;
    } catch (e, stackTrace) {
      AppLogger.error('AdminAcademicCubit', 'Assign curator failed', e, stackTrace);
      emit(state.copyWith(isAssigning: false, errorCode: 'unknown'));
      return false;
    }
  }

  Future<List<GroupModel>> _repairMissingCuratorIds(
    List<GroupModel> groups,
    List<UserModel> teachers,
  ) async {
    final repaired = <GroupModel>[];

    for (final group in groups) {
      if (group.curatorId != null || group.curatorName == null) {
        repaired.add(group);
        continue;
      }

      final curatorName = group.curatorName!.trim().toLowerCase();
      UserModel? teacher;
      for (final candidate in teachers) {
        final name = candidate.displayName.trim().toLowerCase();
        final email = candidate.email.trim().toLowerCase();
        if (name == curatorName || email == curatorName) {
          teacher = candidate;
          break;
        }
      }

      if (teacher == null) {
        repaired.add(group);
        continue;
      }

      try {
        await _groupsRepository.assignCurator(
          groupId: group.id,
          curatorId: teacher.uid,
          curatorName: teacher.displayName,
        );
        repaired.add(group.copyWith(curatorId: teacher.uid, curatorName: teacher.displayName));
      } catch (e, stackTrace) {
        AppLogger.error('AdminAcademicCubit', 'Repair curator id failed for ${group.id}', e, stackTrace);
        repaired.add(group);
      }
    }

    return repaired;
  }

  Future<bool> removeCurator({required String groupId}) async {
    emit(state.copyWith(isAssigning: true, clearError: true));

    try {
      await _groupsRepository.removeCurator(groupId);

      final groups = state.groups.map((group) {
        if (group.id != groupId) return group;
        return GroupModel(
          id: group.id,
          name: group.name,
          memberIds: group.memberIds,
        );
      }).toList();

      emit(state.copyWith(isAssigning: false, groups: groups));
      return true;
    } catch (e, stackTrace) {
      AppLogger.error('AdminAcademicCubit', 'Remove curator failed', e, stackTrace);
      emit(state.copyWith(isAssigning: false, errorCode: 'unknown'));
      return false;
    }
  }

  Future<bool> createGroup({required String name}) async {
    final normalizedName = name.trim();
    if (normalizedName.isEmpty) {
      emit(state.copyWith(errorCode: 'group-name-empty'));
      return false;
    }

    emit(state.copyWith(isSavingGroup: true, clearError: true));

    try {
      final group = await _groupsRepository.createGroup(name: normalizedName);
      final groups = [...state.groups, group]..sort((a, b) => a.name.compareTo(b.name));

      emit(state.copyWith(isSavingGroup: false, groups: groups));
      return true;
    } catch (e, stackTrace) {
      AppLogger.error('AdminAcademicCubit', 'Create group failed', e, stackTrace);
      emit(state.copyWith(isSavingGroup: false, errorCode: 'unknown'));
      return false;
    }
  }

  Future<bool> updateGroup({
    required String groupId,
    required String name,
  }) async {
    final normalizedName = name.trim();
    if (normalizedName.isEmpty) {
      emit(state.copyWith(errorCode: 'group-name-empty'));
      return false;
    }

    emit(state.copyWith(isSavingGroup: true, clearError: true));

    try {
      await _groupsRepository.updateGroupName(groupId: groupId, name: normalizedName);

      final groups = state.groups.map((group) {
        if (group.id != groupId) return group;
        return GroupModel(
          id: group.id,
          name: normalizedName,
          curatorId: group.curatorId,
          curatorName: group.curatorName,
          memberIds: group.memberIds,
        );
      }).toList()
        ..sort((a, b) => a.name.compareTo(b.name));

      emit(state.copyWith(isSavingGroup: false, groups: groups));
      return true;
    } catch (e, stackTrace) {
      AppLogger.error('AdminAcademicCubit', 'Update group failed', e, stackTrace);
      emit(state.copyWith(isSavingGroup: false, errorCode: 'unknown'));
      return false;
    }
  }

  Future<bool> deleteGroup({required GroupModel group}) async {
    emit(state.copyWith(isSavingGroup: true, clearError: true));

    try {
      for (final memberId in group.memberIds) {
        await _userFirestore.updateGroupId(memberId, null);
      }

      await _groupsRepository.deleteGroup(group.id);

      final groups = state.groups.where((g) => g.id != group.id).toList();
      final students = state.students.map((student) {
        if (student.groupId != group.id) return student;
        return UserModel(
          uid: student.uid,
          email: student.email,
          displayName: student.displayName,
          role: student.role,
        );
      }).toList();

      emit(state.copyWith(isSavingGroup: false, groups: groups, students: students));
      return true;
    } catch (e, stackTrace) {
      AppLogger.error('AdminAcademicCubit', 'Delete group failed', e, stackTrace);
      emit(state.copyWith(isSavingGroup: false, errorCode: 'unknown'));
      return false;
    }
  }

  Future<bool> assignStudentToGroup({
    required String groupId,
    required UserModel student,
  }) async {
    emit(state.copyWith(isUpdatingRoster: true, clearError: true));

    try {
      if (student.groupId != null && student.groupId != groupId) {
        await _groupsRepository.removeMember(groupId: student.groupId!, userId: student.uid);
      }

      await _groupsRepository.addMember(groupId: groupId, userId: student.uid);
      await _userFirestore.updateGroupId(student.uid, groupId);

      final groups = state.groups.map((group) {
        if (group.id == groupId) {
          final memberIds = [...group.memberIds];
          if (!memberIds.contains(student.uid)) memberIds.add(student.uid);
          return group.copyWith(memberIds: memberIds);
        }
        if (group.memberIds.contains(student.uid)) {
          return group.copyWith(
            memberIds: group.memberIds.where((id) => id != student.uid).toList(),
          );
        }
        return group;
      }).toList();

      final students = state.students.map((s) {
        if (s.uid != student.uid) return s;
        return UserModel(
          uid: s.uid,
          email: s.email,
          displayName: s.displayName,
          role: s.role,
          groupId: groupId,
        );
      }).toList();

      emit(state.copyWith(isUpdatingRoster: false, groups: groups, students: students));
      return true;
    } catch (e, stackTrace) {
      AppLogger.error('AdminAcademicCubit', 'Assign student failed', e, stackTrace);
      emit(state.copyWith(isUpdatingRoster: false, errorCode: 'unknown'));
      return false;
    }
  }

  Future<bool> removeStudentFromGroup({
    required String groupId,
    required UserModel student,
  }) async {
    emit(state.copyWith(isUpdatingRoster: true, clearError: true));

    try {
      await _groupsRepository.removeMember(groupId: groupId, userId: student.uid);
      await _userFirestore.updateGroupId(student.uid, null);

      final groups = state.groups.map((group) {
        if (group.id != groupId) return group;
        return group.copyWith(
          memberIds: group.memberIds.where((id) => id != student.uid).toList(),
        );
      }).toList();

      final students = state.students.map((s) {
        if (s.uid != student.uid) return s;
        return UserModel(
          uid: s.uid,
          email: s.email,
          displayName: s.displayName,
          role: s.role,
        );
      }).toList();

      emit(state.copyWith(isUpdatingRoster: false, groups: groups, students: students));
      return true;
    } catch (e, stackTrace) {
      AppLogger.error('AdminAcademicCubit', 'Remove student failed', e, stackTrace);
      emit(state.copyWith(isUpdatingRoster: false, errorCode: 'unknown'));
      return false;
    }
  }

  void clearError() {
    if (state.errorCode != null) {
      emit(state.copyWith(clearError: true));
    }
  }
}
