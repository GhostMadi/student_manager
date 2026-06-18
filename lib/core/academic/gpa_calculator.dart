/// GPA scale used across student and teacher views.
abstract final class GpaCalculator {
  static double contribution(double averagePercent) {
    if (averagePercent >= 90) return 4.0;
    if (averagePercent >= 80) return 3.0;
    if (averagePercent >= 70) return 2.0;
    if (averagePercent >= 50) return 1.0;
    return 0.0;
  }

  static double overallGpa(Iterable<double> subjectAverages) {
    final averages = subjectAverages.toList();
    if (averages.isEmpty) return 0;
    final sum = averages.fold<double>(0, (total, avg) => total + contribution(avg));
    return sum / averages.length;
  }
}
