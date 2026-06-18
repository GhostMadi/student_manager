import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_manager/core/academic/grade_model.dart';
import 'package:student_manager/core/utils/app_logger.dart';
import 'package:student_manager/feature/login_page/data/model/user_model.dart';

class GradesRepository {
  GradesRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  static const collection = 'grades';

  Stream<List<GradeModel>> watchStudentGrades(String studentId) {
    return _firestore
        .collection(collection)
        .where('studentId', isEqualTo: studentId)
        .snapshots()
        .map(_mapSnapshot);
  }

  Stream<List<GradeModel>> watchGroupGrades(String groupId) {
    return _firestore
        .collection(collection)
        .where('groupId', isEqualTo: groupId)
        .snapshots()
        .map(_mapSnapshot);
  }

  Future<List<GradeModel>> fetchStudentGrades(String studentId) async {
    final snapshot = await _firestore.collection(collection).where('studentId', isEqualTo: studentId).get();
    return _mapSnapshot(snapshot);
  }

  Future<String> addGrade({
    required String studentId,
    required String studentName,
    required String subjectName,
    required String groupId,
    required String teacherId,
    required int score,
    String? workName,
    String? assignmentId,
    String? submissionId,
  }) async {
    if (score < 0 || score > 100) {
      throw const AuthException('invalid-score');
    }

    AppLogger.info('GradesRepository', 'Add grade: $studentId / $subjectName = $score');

    final ref = await _firestore.collection(collection).add({
      'studentId': studentId,
      'studentName': studentName,
      'subjectName': subjectName.trim(),
      'groupId': groupId,
      'teacherId': teacherId,
      'score': score,
      if (workName != null && workName.trim().isNotEmpty) 'workName': workName.trim(),
      if (assignmentId != null) 'assignmentId': assignmentId,
      if (submissionId != null) 'submissionId': submissionId,
      'gradedAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    return ref.id;
  }

  List<GradeModel> _mapSnapshot(QuerySnapshot<Map<String, dynamic>> snapshot) {
    final grades = snapshot.docs
        .map((doc) => GradeModel.fromFirestore(id: doc.id, data: doc.data()))
        .toList()
      ..sort((a, b) {
        final aTime = a.gradedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        final bTime = b.gradedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
        return bTime.compareTo(aTime);
      });
    return grades;
  }
}
