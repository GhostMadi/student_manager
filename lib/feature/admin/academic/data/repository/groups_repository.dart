import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_manager/core/utils/app_logger.dart';
import 'package:student_manager/feature/admin/academic/data/model/group_model.dart';

class GroupsRepository {
  GroupsRepository({FirebaseFirestore? firestore}) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;
  static const _groupsCollection = 'groups';

  static const _defaultGroups = [
    ('IS-21-1', 'Group IS-21-1'),
    ('IS-21-2', 'Group IS-21-2'),
    ('IS-22-1', 'Group IS-22-1'),
  ];

  static const _serverTimeout = Duration(seconds: 6);

  Future<List<GroupModel>> fetchGroups() async {
    try {
      var snapshot = await _firestore
          .collection(_groupsCollection)
          .get(const GetOptions(source: Source.serverAndCache))
          .timeout(_serverTimeout);

      if (snapshot.docs.isEmpty) {
        await _seedDefaultGroups();
        snapshot = await _firestore.collection(_groupsCollection).get().timeout(_serverTimeout);
      }

      return snapshot.docs
          .map((doc) => GroupModel.fromFirestore(id: doc.id, data: doc.data()))
          .toList()
        ..sort((a, b) => a.name.compareTo(b.name));
    } on TimeoutException catch (e, stackTrace) {
      AppLogger.error('GroupsRepository', 'Fetch groups timeout', e, stackTrace);
      try {
        final cached = await _firestore
            .collection(_groupsCollection)
            .get(const GetOptions(source: Source.cache));
        return cached.docs
            .map((doc) => GroupModel.fromFirestore(id: doc.id, data: doc.data()))
            .toList();
      } catch (_) {
        return [];
      }
    }
  }

  Future<void> assignCurator({
    required String groupId,
    required String curatorId,
    required String curatorName,
  }) async {
    AppLogger.info('GroupsRepository', 'Assign curator $curatorId to group $groupId');

    await _firestore.collection(_groupsCollection).doc(groupId).set({
      'curatorId': curatorId,
      'curatorName': curatorName.trim(),
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<List<GroupModel>> fetchGroupsForTeacher({
    required String teacherId,
    required String teacherName,
    String? teacherEmail,
  }) async {
    final byId = await _fetchGroupsByCuratorId(teacherId);
    if (byId.isNotEmpty) return byId;

    AppLogger.info(
      'GroupsRepository',
      'No groups by curatorId, fallback by name: $teacherName',
    );

    final allGroups = await fetchGroups();
    final matched = allGroups.where((group) => _isTeacherCuratorOfGroup(
          group: group,
          teacherId: teacherId,
          teacherName: teacherName,
          teacherEmail: teacherEmail,
        )).toList();

    for (final group in matched) {
      if (group.curatorId != teacherId) {
        await assignCurator(
          groupId: group.id,
          curatorId: teacherId,
          curatorName: group.curatorName ?? teacherName,
        );
      }
    }

    if (matched.isEmpty) return [];

    return matched
        .map(
          (group) => group.curatorId == teacherId
              ? group
              : group.copyWith(curatorId: teacherId, curatorName: group.curatorName ?? teacherName),
        )
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name));
  }

  Future<List<GroupModel>> _fetchGroupsByCuratorId(String curatorId) async {
    try {
      final snapshot = await _firestore
          .collection(_groupsCollection)
          .where('curatorId', isEqualTo: curatorId)
          .get(const GetOptions(source: Source.server))
          .timeout(_serverTimeout);

      return snapshot.docs
          .map((doc) => GroupModel.fromFirestore(id: doc.id, data: doc.data()))
          .toList()
        ..sort((a, b) => a.name.compareTo(b.name));
    } on TimeoutException catch (e, stackTrace) {
      AppLogger.error('GroupsRepository', 'Fetch curator groups timeout', e, stackTrace);
      return _fetchGroupsByCuratorIdFromCache(curatorId);
    } catch (e, stackTrace) {
      AppLogger.error('GroupsRepository', 'Fetch curator groups failed', e, stackTrace);
      return _fetchGroupsByCuratorIdFromCache(curatorId);
    }
  }

  Future<List<GroupModel>> _fetchGroupsByCuratorIdFromCache(String curatorId) async {
    try {
      final snapshot = await _firestore
          .collection(_groupsCollection)
          .where('curatorId', isEqualTo: curatorId)
          .get(const GetOptions(source: Source.cache));

      return snapshot.docs
          .map((doc) => GroupModel.fromFirestore(id: doc.id, data: doc.data()))
          .toList();
    } catch (_) {
      return [];
    }
  }

  bool _isTeacherCuratorOfGroup({
    required GroupModel group,
    required String teacherId,
    required String teacherName,
    String? teacherEmail,
  }) {
    if (group.curatorId == teacherId) return true;

    final normalizedName = _normalize(teacherName);
    final curatorName = _normalize(group.curatorName);
    if (curatorName != null && curatorName == normalizedName) return true;

    final normalizedEmail = _normalize(teacherEmail);
    if (normalizedEmail != null && curatorName == normalizedEmail) return true;

    return false;
  }

  String? _normalize(String? value) {
    if (value == null) return null;
    final trimmed = value.trim().toLowerCase();
    return trimmed.isEmpty ? null : trimmed;
  }

  Future<List<GroupModel>> fetchGroupsForCurator(String curatorId) {
    return fetchGroupsForTeacher(teacherId: curatorId, teacherName: '');
  }

  Future<void> addMember({
    required String groupId,
    required String userId,
  }) async {
    AppLogger.info('GroupsRepository', 'Add member $userId to group $groupId');

    await _firestore.collection(_groupsCollection).doc(groupId).update({
      'memberIds': FieldValue.arrayUnion([userId]),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> removeMember({
    required String groupId,
    required String userId,
  }) async {
    AppLogger.info('GroupsRepository', 'Remove member $userId from group $groupId');

    await _firestore.collection(_groupsCollection).doc(groupId).update({
      'memberIds': FieldValue.arrayRemove([userId]),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<GroupModel> createGroup({required String name}) async {
    final normalizedName = name.trim();
    AppLogger.info('GroupsRepository', 'Create group: $normalizedName');

    final ref = _firestore.collection(_groupsCollection).doc();
    await ref.set({
      'name': normalizedName,
      'memberIds': <String>[],
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    return GroupModel(id: ref.id, name: normalizedName);
  }

  Future<void> updateGroupName({
    required String groupId,
    required String name,
  }) async {
    AppLogger.info('GroupsRepository', 'Update group $groupId name');

    await _firestore.collection(_groupsCollection).doc(groupId).update({
      'name': name.trim(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> removeCurator(String groupId) async {
    AppLogger.info('GroupsRepository', 'Remove curator from group $groupId');

    await _firestore.collection(_groupsCollection).doc(groupId).update({
      'curatorId': FieldValue.delete(),
      'curatorName': FieldValue.delete(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteGroup(String groupId) async {
    AppLogger.info('GroupsRepository', 'Delete group $groupId');
    await _firestore.collection(_groupsCollection).doc(groupId).delete();
  }

  Future<void> _seedDefaultGroups() async {
    final batch = _firestore.batch();

    for (final (id, name) in _defaultGroups) {
      final ref = _firestore.collection(_groupsCollection).doc(id);
      batch.set(ref, {
        'name': name,
        'memberIds': <String>[],
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

    await batch.commit();
    AppLogger.info('GroupsRepository', 'Default groups seeded');
  }
}
