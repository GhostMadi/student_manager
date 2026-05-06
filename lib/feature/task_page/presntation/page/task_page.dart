import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/extension/context.dart';
import 'package:student_manager/core/router/app_router.dart';
import 'package:student_manager/core/style/app_text_style.dart';
import 'package:student_manager/core/widgets/button.dart';
import 'package:student_manager/core/widgets/text_field.dart';
import 'package:student_manager/feature/task_page/presntation/page/task_model.dart';

@RoutePage()
class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  String _currentFilter = 'allFilter';

  final List<TaskItem> _tasks = [
    TaskItem(title: 'Сдать модуль по калкулус', deadline: DateTime.now().add(const Duration(days: 2))),
    TaskItem(title: 'Подготовиться к экзамену', deadline: DateTime.now().add(const Duration(days: 5))),
    TaskItem(title: 'Купить учебник', deadline: DateTime.now(), isDone: true),
  ];

  void _addTask(String title, DateTime date) {
    setState(() {
      _tasks.add(TaskItem(title: title, deadline: date));
    });
  }

  void _deleteTask(TaskItem task) {
    setState(() {
      _tasks.remove(task);
    });
  }

  String _getFilterText(String filterKey) {
    final l10n = context.l10n;
    switch (filterKey) {
      case 'allFilter':
        return l10n.allFilter;
      case 'inProgressFilter':
        return l10n.inProgressFilter;
      case 'completedFilter':
        return l10n.completedFilter;
      default:
        return filterKey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredTasks = _tasks.where((task) {
      if (_currentFilter == 'inProgressFilter') return !task.isDone;
      if (_currentFilter == 'completedFilter') return task.isDone;
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(context.l10n.tasksTitle, style: AppTextStyles.h1.copyWith(fontSize: 28)),
                  IconButton(
                    onPressed: () => _showAddTaskSheet(context),
                    icon: const Icon(
                      CupertinoIcons.add_circled_solid,
                      size: 32,
                      color: AppColors.primaryOrange,
                    ),
                  ),
                ],
              ),
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                children: ['allFilter', 'inProgressFilter', 'completedFilter'].map((filter) {
                  final isSelected = _currentFilter == filter;
                  return GestureDetector(
                    onTap: () => setState(() => _currentFilter = filter),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primaryOrange : AppColors.surfaceWhite,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _getFilterText(filter),
                        style: AppTextStyles.body.copyWith(
                          fontSize: 13,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? Colors.white : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            Expanded(
              child: filteredTasks.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 100),
                      itemCount: filteredTasks.length,
                      itemBuilder: (context, index) => _buildTaskCard(filteredTasks[index]),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskCard(TaskItem task) {
    return Dismissible(
      key: ObjectKey(task),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => _deleteTask(task),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(20)),
        child: const Icon(CupertinoIcons.delete, color: Colors.white),
      ),
      child: GestureDetector(
        onTap: () async {
          await context.router.push(TaskDetailsRoute(task: task));
          setState(() {});
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: AppColors.surfaceWhite, borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => setState(() => task.isDone = !task.isDone),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 26,
                  width: 26,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: task.isDone ? AppColors.primaryOrange : Colors.transparent,
                    border: Border.all(
                      color: task.isDone ? AppColors.primaryOrange : Colors.grey.shade400,
                      width: 2,
                    ),
                  ),
                  child: task.isDone ? const Icon(Icons.check, size: 18, color: Colors.white) : null,
                ),
              ),
              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: AppTextStyles.body.copyWith(
                        fontWeight: FontWeight.w600,
                        decoration: task.isDone ? TextDecoration.lineThrough : null,
                        color: task.isDone ? AppColors.textSecondary : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(CupertinoIcons.calendar, size: 12, color: AppColors.textSecondary),
                        const SizedBox(width: 4),
                        Text(
                          '${task.deadline.day}.${task.deadline.month}.${task.deadline.year}',
                          style: AppTextStyles.caption.copyWith(fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: task.isDone
                      ? Colors.green.withOpacity(0.1)
                      : AppColors.primaryOrange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  task.isDone ? context.l10n.doneText : context.l10n.inProgressText,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: task.isDone ? Colors.green : AppColors.primaryOrange,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddTaskSheet(BuildContext context) {
    final titleController = TextEditingController();
    DateTime tempDate = DateTime.now().add(const Duration(days: 1));

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 32,
            left: 24,
            right: 24,
            top: 32,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.l10n.newTaskTitle, style: AppTextStyles.h2),
              const SizedBox(height: 24),
              AppTextField(label: context.l10n.whatToDoLabel, controller: titleController),
              const SizedBox(height: 20),

              InkWell(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: tempDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2030),
                  );
                  if (picked != null) setModalState(() => tempDate = picked);
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceWhite,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(CupertinoIcons.calendar, color: AppColors.primaryOrange),
                      const SizedBox(width: 12),
                      Text(
                        context.l10n.deadlineLabel('${tempDate.day}.${tempDate.month}.${tempDate.year}'),
                        style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      const Icon(CupertinoIcons.chevron_right, size: 16, color: AppColors.textSecondary),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              AppButton(
                text: context.l10n.createTaskButton,
                onPressed: () {
                  if (titleController.text.isNotEmpty) {
                    _addTask(titleController.text, tempDate);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(CupertinoIcons.tray, size: 64, color: AppColors.textSecondary.withOpacity(0.3)),
          const SizedBox(height: 16),
          Text(context.l10n.noTasksYet, style: AppTextStyles.caption),
        ],
      ),
    );
  }
}
