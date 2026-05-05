import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/router/app_router.dart';
import 'package:student_manager/core/style/app_text_style.dart';
import 'package:student_manager/core/widgets/button.dart';
import 'package:student_manager/feature/schedule_page/presntation/page/lesson_model.dart';

@RoutePage()
class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  int _selectedDay = 0; // Текущий выбранный день (0 = Понедельник)
  final List<String> _days = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб'];

  // Моковые данные
  // Обновленные моковые данные для расписания
  final List<Lesson> _schedule = [
    // Понедельник (dayIndex: 0)
    Lesson(id: '1', subject: 'Высшая математика', time: '09:00 - 10:30', room: '402 каб.', dayIndex: 0),
    Lesson(id: '2', subject: 'Физика (Лекция)', time: '10:45 - 12:15', room: '105 ауд.', dayIndex: 0),
    Lesson(id: '3', subject: 'Информатика', time: '13:00 - 14:30', room: 'Комп. класс 1', dayIndex: 0),

    // Вторник (dayIndex: 1)
    Lesson(id: '4', subject: 'Английский язык', time: '09:00 - 10:30', room: '301 каб.', dayIndex: 1),
    Lesson(id: '5', subject: 'История Казахстана', time: '10:45 - 12:15', room: '215 ауд.', dayIndex: 1),
    Lesson(id: '6', subject: 'Физкультура', time: '15:00 - 16:30', room: 'Спортзал', dayIndex: 1),

    // Среда (dayIndex: 2)
    Lesson(id: '7', subject: 'Дискретная математика', time: '10:45 - 12:15', room: '410 каб.', dayIndex: 2),
    Lesson(id: '8', subject: 'Программирование Python', time: '12:30 - 14:00', room: 'Лаб 4', dayIndex: 2),

    // Четверг (dayIndex: 3)
    Lesson(id: '9', subject: 'Экономика', time: '09:00 - 10:30', room: '112 ауд.', dayIndex: 3),
    Lesson(id: '10', subject: 'Культурология', time: '10:45 - 12:15', room: '305 каб.', dayIndex: 3),
    Lesson(id: '11', subject: 'Статистика', time: '13:00 - 14:30', room: '402 каб.', dayIndex: 3),

    // Пятница (dayIndex: 4)
    Lesson(id: '12', subject: 'Базы данных', time: '10:45 - 12:15', room: 'Лаб 2', dayIndex: 4),
    Lesson(id: '13', subject: 'Архитектура ЭВМ', time: '12:30 - 14:00', room: '208 каб.', dayIndex: 4),

    // Суббота (dayIndex: 5)
    Lesson(id: '14', subject: 'Военная кафедра', time: '08:30 - 16:00', room: 'Пл. корп.', dayIndex: 5),
  ];

  void _addOrEditLesson({Lesson? lesson}) {
    _showLessonSheet(context, lesson: lesson);
  }

  void _deleteLesson(String id) {
    setState(() => _schedule.removeWhere((l) => l.id == id));
  }

  @override
  Widget build(BuildContext context) {
    final dailyLessons = _schedule.where((l) => l.dayIndex == _selectedDay).toList();

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Заголовок и кнопка добавления
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Расписание', style: AppTextStyles.h1.copyWith(fontSize: 28)),
                  IconButton(
                    onPressed: () => _addOrEditLesson(),
                    icon: const Icon(
                      CupertinoIcons.add_circled_solid,
                      size: 32,
                      color: AppColors.primaryOrange,
                    ),
                  ),
                ],
              ),
            ),

            // Селектор дней недели
            Container(
              height: 90,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _days.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedDay == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() => _selectedDay = index);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: 55,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primaryOrange : AppColors.surfaceWhite,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _days[index],
                            style: TextStyle(
                              color: isSelected ? Colors.white : AppColors.textSecondary,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Список занятий
            Expanded(
              child: dailyLessons.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      itemCount: dailyLessons.length,
                      itemBuilder: (context, index) => _buildLessonCard(dailyLessons[index]),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLessonCard(Lesson lesson) {
    return GestureDetector(
      onTap: () {
        context.router.push(LessonRoute(lesson: lesson));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(color: AppColors.surfaceWhite, borderRadius: BorderRadius.circular(24)),
        child: ListTile(
          contentPadding: const EdgeInsets.all(20),
          title: Text(
            lesson.subject,
            style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(CupertinoIcons.time, size: 14, color: AppColors.primaryOrange),
                  const SizedBox(width: 6),
                  Text(lesson.time, style: AppTextStyles.caption),
                  const SizedBox(width: 16),
                  const Icon(CupertinoIcons.location, size: 14, color: AppColors.primaryOrange),
                  const SizedBox(width: 6),
                  Text(lesson.room, style: AppTextStyles.caption),
                ],
              ),
            ],
          ),
          trailing: PopupMenuButton(
            icon: const Icon(CupertinoIcons.ellipsis_vertical, color: AppColors.textSecondary),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            onSelected: (value) {
              if (value == 'edit') _addOrEditLesson(lesson: lesson);
              if (value == 'delete') _deleteLesson(lesson.id);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'edit', child: Text('Редактировать')),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Удалить', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLessonSheet(BuildContext context, {Lesson? lesson}) {
    // Списки для выбора
    final List<String> subjects = [
      'Высшая математика',
      'Физика',
      'Информатика',
      'Английский язык',
      'История',
    ];
    final List<String> rooms = ['101 каб.', '105 ауд.', '208 каб.', '301 каб.', '402 каб.', 'Лаб 1'];

    // Текущие значения (берем из урока или ставим дефолт)
    String selectedSubject = lesson?.subject ?? subjects[0];
    String selectedRoom = lesson?.room ?? rooms[0];
    TimeOfDay startTime = const TimeOfDay(hour: 9, minute: 0);
    TimeOfDay endTime = const TimeOfDay(hour: 10, minute: 30);

    // Функция селектора времени
    Future<TimeOfDay?> selectTime(BuildContext context, TimeOfDay initial) async {
      return await showTimePicker(
        context: context,
        initialTime: initial,
        builder: (context, child) => Theme(
          data: Theme.of(
            context,
          ).copyWith(colorScheme: const ColorScheme.light(primary: AppColors.primaryOrange)),
          child: child!,
        ),
      );
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 32,
            left: 24,
            right: 24,
            top: 32,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(lesson == null ? 'Новое занятие' : 'Редактирование', style: AppTextStyles.h2),
              const SizedBox(height: 24),

              // Выбор предмета
              _buildPickerField(
                label: 'Предмет',
                value: selectedSubject,
                items: subjects,
                onChanged: (val) => setSheetState(() => selectedSubject = val!),
              ),
              const SizedBox(height: 16),

              // Селекторы времени
              Row(
                children: [
                  Expanded(
                    child: _buildManualSelector(
                      label: 'Начало',
                      text: startTime.format(context),
                      onTap: () async {
                        final picked = await selectTime(context, startTime);
                        if (picked != null) setSheetState(() => startTime = picked);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildManualSelector(
                      label: 'Конец',
                      text: endTime.format(context),
                      onTap: () async {
                        final picked = await selectTime(context, endTime);
                        if (picked != null) setSheetState(() => endTime = picked);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Выбор аудитории
              _buildPickerField(
                label: 'Аудитория',
                value: selectedRoom,
                items: rooms,
                onChanged: (val) => setSheetState(() => selectedRoom = val!),
              ),
              const SizedBox(height: 24),

              AppButton(
                text: 'Сохранить',
                onPressed: () {
                  final timeRange = "${startTime.format(context)} - ${endTime.format(context)}";
                  setState(() {
                    if (lesson == null) {
                      _schedule.add(
                        Lesson(
                          id: DateTime.now().toString(),
                          subject: selectedSubject,
                          time: timeRange,
                          room: selectedRoom,
                          dayIndex: _selectedDay,
                        ),
                      );
                    } else {
                      lesson.subject = selectedSubject;
                      lesson.time = timeRange;
                      lesson.room = selectedRoom;
                    }
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Виджет для выбора из списка (Dropdown)
  Widget _buildPickerField({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(color: AppColors.surfaceWhite, borderRadius: BorderRadius.circular(12)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: const Icon(CupertinoIcons.chevron_down, size: 16, color: AppColors.primaryOrange),
              items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  // Виджет-кнопка для вызова таймпикера
  Widget _buildManualSelector({required String label, required String text, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            decoration: BoxDecoration(color: AppColors.surfaceWhite, borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(text, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                const Icon(CupertinoIcons.clock, size: 16, color: AppColors.primaryOrange),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(CupertinoIcons.book, size: 64, color: AppColors.textSecondary.withOpacity(0.2)),
          const SizedBox(height: 16),
          Text('На этот день занятий нет', style: AppTextStyles.caption),
        ],
      ),
    );
  }
}
