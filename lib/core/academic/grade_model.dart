import 'package:cloud_firestore/cloud_firestore.dart';

class GradeModel {
  const GradeModel({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.subjectName,
    required this.groupId,
    required this.teacherId,
    required this.score,
    this.workName,
    this.gradedAt,
  });

  final String id;
  final String studentId;
  final String studentName;
  final String subjectName;
  final String groupId;
  final String teacherId;
  final int score;
  final String? workName;
  final DateTime? gradedAt;

  factory GradeModel.fromFirestore({
    required String id,
    required Map<String, dynamic> data,
  }) {
    final gradedAt = data['gradedAt'];
    return GradeModel(
      id: id,
      studentId: (data['studentId'] as String?) ?? '',
      studentName: (data['studentName'] as String?) ?? '',
      subjectName: (data['subjectName'] as String?) ?? '',
      groupId: (data['groupId'] as String?) ?? '',
      teacherId: (data['teacherId'] as String?) ?? '',
      score: (data['score'] as num?)?.toInt() ?? 0,
      workName: data['workName'] as String?,
      gradedAt: gradedAt is Timestamp ? gradedAt.toDate() : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'studentId': studentId,
      'studentName': studentName,
      'subjectName': subjectName,
      'groupId': groupId,
      'teacherId': teacherId,
      'score': score,
      if (workName != null && workName!.isNotEmpty) 'workName': workName,
      'gradedAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
