import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/extension/context.dart';
import 'package:student_manager/core/router/app_router.dart';
import 'package:student_manager/core/style/app_text_style.dart';
import 'package:student_manager/feature/schedule_page/presntation/page/lesson_model.dart';
import 'package:student_manager/feature/task_page/presntation/page/task_model.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Приветствие и GPA
              Padding(padding: const EdgeInsets.symmetric(horizontal: 24), child: _buildHeader()),
              const SizedBox(height: 32),

              // 2. Ближайшие занятия (Горизонтальный список)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _buildSectionHeader(l10n.upcomingLessons, () {
                  context.tabsRouter.setActiveIndex(2);
                }),
              ),
              const SizedBox(height: 16),
              _buildUpcomingLessons(),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 32),

                    // 3. Текущие задания (Вертикальный список)
                    _buildSectionHeader(l10n.currentTasks, () {
                      context.tabsRouter.setActiveIndex(3);
                    }),
                    const SizedBox(height: 16),
                    _buildCurrentTasks(),

                    const SizedBox(height: 100), // Отступ для навигации
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGPACard() {
    final l10n = context.l10n;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: AppColors.deepBlack, borderRadius: BorderRadius.circular(28)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.totalGPA, style: AppTextStyles.caption.copyWith(color: Colors.white60)),
                const SizedBox(height: 4),
                Text('4.46', style: AppTextStyles.h1.copyWith(color: Colors.white, fontSize: 32)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final l10n = context.l10n;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.greeting, style: AppTextStyles.h1.copyWith(fontSize: 24)),
            const SizedBox(height: 4),
            Text(l10n.todayStudyDay, style: AppTextStyles.caption),
          ],
        ),
        // Виджет среднего балла
        GestureDetector(
          onTap: () {
            context.tabsRouter.setActiveIndex(1);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(color: AppColors.deepBlack, borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Text('GPA', style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 10)),
                Text(
                  '3.85',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.h2.copyWith(fontSize: 20)),
        TextButton(
          onPressed: onTap,
          child: const Text('Все', style: TextStyle(color: AppColors.primaryOrange)),
        ),
      ],
    );
  }

  Widget _buildUpcomingLessons() {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        // Добавляем отступ в начало списка, чтобы карточки выравнивались по заголовку
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: 3,
        itemBuilder: (context, index) {
          final subjectName = index == 0 ? 'Математика' : 'Физика';

          return GestureDetector(
            onTap: () {
              // Создаем полноценный объект
              final lessonToOpen = Lesson(
                id: DateTime.now().toString(), // Генерируем временный ID
                subject: subjectName,
                time: '09:00 - 10:30',
                room: 'Ауд. 402',
                dayIndex: 0, // Передаем корректный индекс дня
              );

              context.router.push(LessonRoute(lesson: lessonToOpen));
            },
            child: Container(
              width: 220,
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: index == 0 ? AppColors.primaryOrange : AppColors.surfaceWhite,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    subjectName,
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.bold,
                      color: index == 0 ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.time,
                        size: 14,
                        color: index == 0 ? Colors.white70 : AppColors.textSecondary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '09:00 - 10:30',
                        style: AppTextStyles.caption.copyWith(
                          color: index == 0 ? Colors.white70 : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Ауд. 402',
                    style: TextStyle(
                      color: index == 0 ? Colors.white : AppColors.primaryOrange,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCurrentTasks() {
    final l10n = context.l10n;

    return Column(
      children: List.generate(2, (index) {
        return GestureDetector(
          onTap: () {
            context.router.push(
              TaskDetailsRoute(
                task: TaskItem(
                  title: 'Задача №${index + 1}',
                  deadline: DateTime.now().add(const Duration(days: 1)),
                  isDone: index == 0,
                ),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: AppColors.surfaceWhite, borderRadius: BorderRadius.circular(24)),
            child: Row(
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: AppColors.scaffoldBackground,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(CupertinoIcons.doc_text, color: AppColors.primaryOrange),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.labTaskNumber(index + 3),
                        style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(l10n.deadlineTomorrow, style: AppTextStyles.caption.copyWith(color: Colors.redAccent)),
                    ],
                  ),
                ),
                const Icon(CupertinoIcons.chevron_right, size: 16, color: AppColors.textSecondary),
              ],
            ),
          ),
        );
      }),
    );
  }
}
