
class Lesson {
  String id;
  String subject;
  String time;
  String room;
  int dayIndex; // 0 - Пн, 1 - Вт и т.д.

  Lesson({
    required this.id,
    required this.subject,
    required this.time,
    required this.room,
    required this.dayIndex,
  });
}
