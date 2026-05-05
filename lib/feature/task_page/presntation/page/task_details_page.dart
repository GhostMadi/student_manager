import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/extension/context.dart';
import 'package:student_manager/core/style/app_text_style.dart';
import 'package:student_manager/core/widgets/button.dart';
import 'package:student_manager/feature/task_page/presntation/page/task_model.dart';

@RoutePage()
class TaskDetailsPage extends StatefulWidget {
  final TaskItem task;

  const TaskDetailsPage({super.key, required this.task});

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  // Имитация состояний (в идеале управляется через BLoC/Cubit)
  late bool _isDone;
  bool _isInProgress = false;

  @override
  void initState() {
    super.initState();
    _isDone = widget.task.isDone;
    // Если задача не сделана, но мы хотим имитировать переход в статус "В работе"
    _isInProgress = false;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: AppColors.textPrimary),
          onPressed: () => context.router.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.trash, color: Colors.redAccent),
            onPressed: () {
              // Логика удаления
              context.router.back();
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    _buildStatusBadge(),
                    const SizedBox(height: 16),

                    Text(widget.task.title, style: AppTextStyles.h1.copyWith(fontSize: 32, height: 1.2)),

                    const SizedBox(height: 32),

                    // Блок с параметрами
                    _buildInfoCard(),

                    const SizedBox(height: 32),

                    Text(l10n.descriptionTitle, style: AppTextStyles.h2.copyWith(fontSize: 18)),
                    const SizedBox(height: 12),
                    Text(
                      l10n.descriptionText,
                      style: AppTextStyles.body.copyWith(color: AppColors.textSecondary, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),

            // Кнопочная панель снизу
            _buildBottomActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    final l10n = context.l10n;
    Color color;
    String text;

    if (_isDone) {
      color = Colors.green;
      text = l10n.taskStatusCompleted;
    } else if (_isInProgress) {
      color = AppColors.primaryOrange;
      text = l10n.taskStatusInProgress;
    } else {
      color = Colors.blueGrey;
      text = l10n.taskStatusQueued;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: 10, letterSpacing: 1),
      ),
    );
  }

  Widget _buildInfoCard() {
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: AppColors.surfaceWhite, borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: [
          _buildInfoRow(
            CupertinoIcons.calendar,
            l10n.deadlineInfo,
            '${widget.task.deadline.day}.${widget.task.deadline.month}.${widget.task.deadline.year}',
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider(height: 1)),
          _buildInfoRow(CupertinoIcons.flag, l10n.priorityInfo, l10n.highPriority),
          const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider(height: 1)),
          _buildInfoRow(CupertinoIcons.tag, l10n.categoryInfo, l10n.categoryStudy),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primaryOrange),
        const SizedBox(width: 12),
        Text(label, style: AppTextStyles.caption),
        const Spacer(),
        Text(value, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold, fontSize: 14)),
      ],
    );
  }

  Widget _buildBottomActions() {
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, -5)),
        ],
      ),
      child: _isDone
          ? AppButton(
              text: l10n.returnToWork,
              onPressed: () => setState(() {
                _isDone = false;
                _isInProgress = false;
                widget.task.isDone = false;
              }),
            )
          : Row(
              children: [
                if (!_isInProgress)
                  Expanded(
                    child: AppButton(
                      text: l10n.startTask,
                      onPressed: () => setState(() {
                        _isInProgress = true;
                        widget.task.isDone = false;
                      }),
                    ),
                  )
                else
                  Expanded(
                    child: AppButton(
                      text: l10n.finishTask,
                      onPressed: () => setState(() {
                        _isDone = true;
                        _isInProgress = false;
                        widget.task.isDone = true;
                      }),
                    ),
                  ),
              ],
            ),
    );
  }
}
