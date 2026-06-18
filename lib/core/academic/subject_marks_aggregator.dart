import 'package:student_manager/core/academic/gpa_calculator.dart';
import 'package:student_manager/feature/student/mark_page/presntation/page/subject_model.dart';

List<SubjectMarks> aggregateGradesBySubject(Map<String, List<int>> marksBySubject) {
  return marksBySubject.entries
      .map((entry) => SubjectMarks(id: entry.key, name: entry.key, marks: List<int>.from(entry.value)))
      .toList()
    ..sort((a, b) => a.name.compareTo(b.name));
}

Map<String, List<int>> groupScoresBySubject(Iterable<({String subjectName, int score})> grades) {
  final map = <String, List<int>>{};
  for (final grade in grades) {
    map.putIfAbsent(grade.subjectName, () => []).add(grade.score);
  }
  return map;
}

double overallGpaFromSubjects(List<SubjectMarks> subjects) {
  return GpaCalculator.overallGpa(subjects.map((s) => s.average));
}
