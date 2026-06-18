import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_manager/core/academic/assignment_model.dart';
import 'package:student_manager/core/utils/app_logger.dart';
import 'package:student_manager/feature/login_page/data/model/user_model.dart';

class AssignmentsRepository {
  AssignmentsRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  static const assignmentsCollection = 'assignments';
  static const submissionsCollection = 'submissions';

  Stream<List<AssignmentModel>> watchAssignmentsForGroup(String groupId) {
    if (groupId.isEmpty) {
      return Stream.value(const []);
    }

    return _firestore
        .collection(assignmentsCollection)
        .where('groupId', isEqualTo: groupId)
        .snapshots()
        .map((snapshot) {
      final items = snapshot.docs
          .map((doc) => AssignmentModel.fromFirestore(id: doc.id, data: doc.data()))
          .toList()
        ..sort((a, b) => a.dueAt.compareTo(b.dueAt));
      return items;
    });
  }

  Stream<List<SubmissionModel>> watchStudentSubmissions(String studentId) {
    return _firestore
        .collection(submissionsCollection)
        .where('studentId', isEqualTo: studentId)
        .snapshots()
        .map(_mapSubmissions);
  }

  Stream<List<SubmissionModel>> watchGroupSubmissions(String groupId) {
    if (groupId.isEmpty) return Stream.value(const []);

    return _firestore
        .collection(submissionsCollection)
        .where('groupId', isEqualTo: groupId)
        .snapshots()
        .map(_mapSubmissions);
  }

  Future<AssignmentModel> createAssignment({
    required String title,
    required String description,
    required String subjectName,
    required String groupId,
    required String teacherId,
    required DateTime dueAt,
  }) async {
    AppLogger.info('AssignmentsRepository', 'Create assignment: $title');

    final docRef = _firestore.collection(assignmentsCollection).doc();
    final model = AssignmentModel(
      id: docRef.id,
      title: title,
      description: description,
      subjectName: subjectName,
      groupId: groupId,
      teacherId: teacherId,
      dueAt: dueAt,
    );

    await docRef.set(model.toFirestore());
    return model;
  }

  Future<AssignmentModel?> fetchAssignmentById(String assignmentId) async {
    final doc = await _firestore.collection(assignmentsCollection).doc(assignmentId).get();
    if (!doc.exists || doc.data() == null) return null;
    return AssignmentModel.fromFirestore(id: doc.id, data: doc.data()!);
  }

  Stream<SubmissionModel?> watchSubmission(String submissionId) {
    return _firestore.collection(submissionsCollection).doc(submissionId).snapshots().map((doc) {
      if (!doc.exists || doc.data() == null) return null;
      return SubmissionModel.fromFirestore(id: doc.id, data: doc.data()!);
    });
  }

  Future<SubmissionModel> getOrCreateSubmission({
    required AssignmentModel assignment,
    required String studentId,
    required String studentName,
  }) async {
    final existing = await _firestore
        .collection(submissionsCollection)
        .where('assignmentId', isEqualTo: assignment.id)
        .where('studentId', isEqualTo: studentId)
        .limit(1)
        .get();

    if (existing.docs.isNotEmpty) {
      final doc = existing.docs.first;
      return SubmissionModel.fromFirestore(id: doc.id, data: doc.data());
    }

    final ref = await _firestore.collection(submissionsCollection).add({
      'assignmentId': assignment.id,
      'assignmentTitle': assignment.title,
      'subjectName': assignment.subjectName,
      'studentId': studentId,
      'studentName': studentName,
      'groupId': assignment.groupId,
      'teacherId': assignment.teacherId,
      'status': submissionStatusToString(SubmissionStatus.draft),
      'textAnswer': '',
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    return SubmissionModel(
      id: ref.id,
      assignmentId: assignment.id,
      studentId: studentId,
      studentName: studentName,
      groupId: assignment.groupId,
      teacherId: assignment.teacherId,
      status: SubmissionStatus.draft,
      assignmentTitle: assignment.title,
      subjectName: assignment.subjectName,
    );
  }

  Future<void> submitWork({
    required String submissionId,
    required String textAnswer,
  }) async {
    AppLogger.info('AssignmentsRepository', 'Submit work: $submissionId');

    await _firestore.collection(submissionsCollection).doc(submissionId).update({
      'textAnswer': textAnswer.trim(),
      'status': submissionStatusToString(SubmissionStatus.submitted),
      'submittedAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<String> gradeSubmission({
    required SubmissionModel submission,
    required int score,
    String? feedback,
    required String gradeId,
  }) async {
    if (score < 0 || score > 100) {
      throw const AuthException('invalid-score');
    }

    await _firestore.collection(submissionsCollection).doc(submission.id).update({
      'score': score,
      'feedback': feedback?.trim(),
      'status': submissionStatusToString(SubmissionStatus.graded),
      'gradeId': gradeId,
      'updatedAt': FieldValue.serverTimestamp(),
    });

    return submission.id;
  }

  List<SubmissionModel> _mapSubmissions(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs
        .map((doc) => SubmissionModel.fromFirestore(id: doc.id, data: doc.data()))
        .toList()
      ..sort((a, b) {
        final aTime = a.submittedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        final bTime = b.submittedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        return bTime.compareTo(aTime);
      });
  }
}
