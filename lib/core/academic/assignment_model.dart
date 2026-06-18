import 'package:cloud_firestore/cloud_firestore.dart';

enum SubmissionStatus { draft, submitted, graded }

SubmissionStatus submissionStatusFromString(String? value) {
  switch (value) {
    case 'submitted':
      return SubmissionStatus.submitted;
    case 'graded':
      return SubmissionStatus.graded;
    default:
      return SubmissionStatus.draft;
  }
}

String submissionStatusToString(SubmissionStatus status) {
  switch (status) {
    case SubmissionStatus.submitted:
      return 'submitted';
    case SubmissionStatus.graded:
      return 'graded';
    case SubmissionStatus.draft:
      return 'draft';
  }
}

class AssignmentModel {
  const AssignmentModel({
    required this.id,
    required this.title,
    required this.description,
    required this.subjectName,
    required this.groupId,
    required this.teacherId,
    required this.dueAt,
    this.maxScore = 100,
  });

  final String id;
  final String title;
  final String description;
  final String subjectName;
  final String groupId;
  final String teacherId;
  final DateTime dueAt;
  final int maxScore;

  factory AssignmentModel.fromFirestore({
    required String id,
    required Map<String, dynamic> data,
  }) {
    final dueAt = data['dueAt'];
    return AssignmentModel(
      id: id,
      title: (data['title'] as String?) ?? '',
      description: (data['description'] as String?) ?? '',
      subjectName: (data['subjectName'] as String?) ?? '',
      groupId: (data['groupId'] as String?) ?? '',
      teacherId: (data['teacherId'] as String?) ?? '',
      dueAt: dueAt is Timestamp ? dueAt.toDate() : DateTime.now(),
      maxScore: (data['maxScore'] as num?)?.toInt() ?? 100,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title.trim(),
      'description': description.trim(),
      'subjectName': subjectName.trim(),
      'groupId': groupId,
      'teacherId': teacherId,
      'dueAt': Timestamp.fromDate(dueAt),
      'maxScore': maxScore,
      'status': 'published',
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}

class SubmissionModel {
  const SubmissionModel({
    required this.id,
    required this.assignmentId,
    required this.studentId,
    required this.studentName,
    required this.groupId,
    required this.teacherId,
    required this.status,
    this.textAnswer = '',
    this.score,
    this.feedback,
    this.submittedAt,
    this.assignmentTitle,
    this.subjectName,
  });

  final String id;
  final String assignmentId;
  final String studentId;
  final String studentName;
  final String groupId;
  final String teacherId;
  final SubmissionStatus status;
  final String textAnswer;
  final int? score;
  final String? feedback;
  final DateTime? submittedAt;
  final String? assignmentTitle;
  final String? subjectName;

  bool get isSubmitted => status == SubmissionStatus.submitted || status == SubmissionStatus.graded;

  factory SubmissionModel.fromFirestore({
    required String id,
    required Map<String, dynamic> data,
  }) {
    final submittedAt = data['submittedAt'];
    return SubmissionModel(
      id: id,
      assignmentId: (data['assignmentId'] as String?) ?? '',
      studentId: (data['studentId'] as String?) ?? '',
      studentName: (data['studentName'] as String?) ?? '',
      groupId: (data['groupId'] as String?) ?? '',
      teacherId: (data['teacherId'] as String?) ?? '',
      status: submissionStatusFromString(data['status'] as String?),
      textAnswer: (data['textAnswer'] as String?) ?? '',
      score: (data['score'] as num?)?.toInt(),
      feedback: data['feedback'] as String?,
      submittedAt: submittedAt is Timestamp ? submittedAt.toDate() : null,
      assignmentTitle: data['assignmentTitle'] as String?,
      subjectName: data['subjectName'] as String?,
    );
  }
}
