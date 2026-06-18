class GroupModel {
  const GroupModel({
    required this.id,
    required this.name,
    this.curatorId,
    this.curatorName,
    this.memberIds = const [],
  });

  final String id;
  final String name;
  final String? curatorId;
  final String? curatorName;
  final List<String> memberIds;

  int get memberCount => memberIds.length;

  factory GroupModel.fromFirestore({
    required String id,
    required Map<String, dynamic> data,
  }) {
    final memberIds = data['memberIds'];
    return GroupModel(
      id: id,
      name: (data['name'] as String?) ?? '',
      curatorId: _readOptionalString(data['curatorId']),
      curatorName: _readOptionalString(data['curatorName']),
      memberIds: memberIds is List ? memberIds.map((e) => e.toString()).toList() : const [],
    );
  }

  static String? _readOptionalString(Object? value) {
    if (value is! String) return null;
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  GroupModel copyWith({
    String? curatorId,
    String? curatorName,
    List<String>? memberIds,
  }) {
    return GroupModel(
      id: id,
      name: name,
      curatorId: curatorId ?? this.curatorId,
      curatorName: curatorName ?? this.curatorName,
      memberIds: memberIds ?? this.memberIds,
    );
  }
}
