import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_manager/core/models/user_role.dart';
import 'package:student_manager/core/utils/app_logger.dart';
import 'package:student_manager/feature/admin/people/data/repository/users_repository.dart';
import 'package:student_manager/feature/login_page/data/model/user_model.dart';

class AdminPeopleState {
  const AdminPeopleState({
    this.isLoading = false,
    this.isRefreshing = false,
    this.isSubmitting = false,
    this.students = const [],
    this.teachers = const [],
    this.searchQuery = '',
    this.errorCode,
    this.isLoaded = false,
  });

  final bool isLoading;
  final bool isRefreshing;
  final bool isSubmitting;
  final List<UserModel> students;
  final List<UserModel> teachers;
  final String searchQuery;
  final String? errorCode;
  final bool isLoaded;

  List<UserModel> get filteredStudents {
    if (searchQuery.isEmpty) return students;
    final q = searchQuery.toLowerCase();
    return students
        .where((u) => u.displayName.toLowerCase().contains(q) || u.email.toLowerCase().contains(q))
        .toList();
  }

  List<UserModel> get filteredTeachers {
    if (searchQuery.isEmpty) return teachers;
    final q = searchQuery.toLowerCase();
    return teachers
        .where((u) => u.displayName.toLowerCase().contains(q) || u.email.toLowerCase().contains(q))
        .toList();
  }

  AdminPeopleState copyWith({
    bool? isLoading,
    bool? isRefreshing,
    bool? isSubmitting,
    List<UserModel>? students,
    List<UserModel>? teachers,
    String? searchQuery,
    String? errorCode,
    bool? isLoaded,
    bool clearError = false,
  }) {
    return AdminPeopleState(
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      students: students ?? this.students,
      teachers: teachers ?? this.teachers,
      searchQuery: searchQuery ?? this.searchQuery,
      errorCode: clearError ? null : (errorCode ?? this.errorCode),
      isLoaded: isLoaded ?? this.isLoaded,
    );
  }
}

class AdminPeopleCubit extends Cubit<AdminPeopleState> {
  AdminPeopleCubit({UsersRepository? usersRepository})
      : _usersRepository = usersRepository ?? UsersRepository(),
        super(const AdminPeopleState());

  final UsersRepository _usersRepository;

  Future<void> loadUsers({bool force = false}) async {
    if (!force && state.isLoaded) return;

    final showFullLoader = !state.isLoaded && state.students.isEmpty && state.teachers.isEmpty;
    emit(
      state.copyWith(
        isLoading: showFullLoader,
        isRefreshing: !showFullLoader && force,
        clearError: true,
      ),
    );

    try {
      if (showFullLoader) {
        final cached = await _usersRepository.fetchAllUsers(cacheOnly: true);
        if (!isClosed && (cached.students.isNotEmpty || cached.teachers.isNotEmpty)) {
          emit(
            state.copyWith(
              students: cached.students,
              teachers: cached.teachers,
              isLoading: true,
            ),
          );
        }
      }

      final result = await _usersRepository.fetchAllUsers();

      if (!isClosed) {
        emit(
          state.copyWith(
            isLoading: false,
            isRefreshing: false,
            students: result.students,
            teachers: result.teachers,
            isLoaded: true,
          ),
        );
      }
    } catch (e, stackTrace) {
      AppLogger.error('AdminPeopleCubit', 'Load users failed', e, stackTrace);
      if (!isClosed) {
        emit(state.copyWith(isLoading: false, isRefreshing: false, errorCode: 'unknown'));
      }
    }
  }

  void updateSearch(String query) {
    emit(state.copyWith(searchQuery: query.trim()));
  }

  Future<bool> addStudent({
    required String displayName,
    required String email,
    String? password,
  }) {
    return _addUser(
      displayName: displayName,
      email: email,
      password: password ?? UsersRepository.defaultUserPassword,
      role: UserRole.student,
    );
  }

  Future<bool> addCurator({
    required String displayName,
    required String email,
    String? password,
  }) {
    return _addUser(
      displayName: displayName,
      email: email,
      password: password ?? UsersRepository.defaultUserPassword,
      role: UserRole.teacher,
    );
  }

  Future<bool> _addUser({
    required String displayName,
    required String email,
    required String password,
    required UserRole role,
  }) async {
    emit(state.copyWith(isSubmitting: true, clearError: true));

    UserModel? user;
    String? errorCode;

    try {
      user = await _usersRepository.createUser(
        email: email,
        displayName: displayName,
        password: password,
        role: role,
      );

      AppLogger.info('AdminPeopleCubit', 'User added: ${user.uid}');
      await loadUsers(force: true);
    } on AuthException catch (e) {
      AppLogger.error('AdminPeopleCubit', 'AuthException: ${e.code}', e);
      errorCode = e.code;
    } catch (e, stackTrace) {
      AppLogger.error('AdminPeopleCubit', 'Add user failed', e, stackTrace);
      errorCode = 'unknown';
    } finally {
      if (!isClosed) {
        emit(
          state.copyWith(
            isSubmitting: false,
            errorCode: errorCode,
          ),
        );
      }
    }

    return user != null;
  }

  void clearError() {
    if (state.errorCode != null) {
      emit(state.copyWith(clearError: true));
    }
  }
}
