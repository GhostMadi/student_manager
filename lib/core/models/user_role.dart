enum UserRole {
  student,
  teacher,
  admin,
}

extension UserRoleX on UserRole {
  String get storageValue => name;
}

UserRole? userRoleFromStorage(String? raw) {
  if (raw == null || raw.isEmpty) return null;
  for (final r in UserRole.values) {
    if (r.name == raw) return r;
  }
  return null;
}
