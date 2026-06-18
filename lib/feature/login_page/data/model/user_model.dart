import 'package:student_manager/core/models/user_role.dart';

class UserModel {
  const UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.role,
    this.groupId,
  });

  final String uid;
  final String email;
  final String displayName;
  final UserRole role;
  final String? groupId;

  factory UserModel.fromFirestore({
    required String uid,
    required Map<String, dynamic> data,
  }) {
    return UserModel(
      uid: uid,
      email: (data['email'] as String?) ?? '',
      displayName: (data['displayName'] as String?) ?? '',
      role: userRoleFromStorage(data['role'] as String?) ?? UserRole.student,
      groupId: data['groupId'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'displayName': displayName,
      'role': role.storageValue,
      if (groupId != null) 'groupId': groupId,
    };
  }
}

class AuthException implements Exception {
  const AuthException(this.code, {this.message});

  final String code;
  final String? message;

  @override
  String toString() => message ?? code;
}
