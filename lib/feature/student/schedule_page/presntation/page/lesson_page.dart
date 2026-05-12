import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/extension/context.dart';
import 'package:student_manager/feature/student/schedule_page/presntation/page/lesson_model.dart';

@RoutePage()
class LessonPage extends StatelessWidget {
  final Lesson lesson;

  const LessonPage({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n; 
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.west, color: AppColors.deepBlack),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.pencil_circle, color: AppColors.primaryOrange),
            onPressed: () {}, 
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
 
            Text(
              context.l10n.lecture.toUpperCase(), 
              style: const TextStyle(
                color: AppColors.primaryOrange,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 8),
 
            Text(
              lesson.subject,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.deepBlack),
            ),
            const SizedBox(height: 24),

 
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surfaceWhite,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildInfoItem(CupertinoIcons.clock, context.l10n.time, lesson.time),
                  Container(width: 1, height: 40, color: Colors.grey.withOpacity(0.2)),
                  _buildInfoItem(CupertinoIcons.location, context.l10n.room, lesson.room),
                ],
              ),
            ),

            const SizedBox(height: 32),

 
            _buildSectionTitle(context.l10n.lessonTopic),
            Text(
              context.l10n.mockLessonTopicDescription,
              style: const TextStyle(fontSize: 16, color: AppColors.charcoal, height: 1.5),
            ),

            const SizedBox(height: 32),

            _buildSectionTitle(context.l10n.homework),
            _buildHomeworkItem(context.l10n.mockHomework1),
            _buildHomeworkItem(context.l10n.mockHomework2),

            const SizedBox(height: 32),

            _buildSectionTitle(context.l10n.teacher),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(
                backgroundColor: AppColors.surfaceWhite,
                child: Icon(Icons.person, color: AppColors.primaryOrange),
              ),
              title: Text(context.l10n.mockTeacherName),
              subtitle: Text(context.l10n.mockTeacherStatus),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primaryOrange, size: 20),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.deepBlack),
      ),
    );
  }

  Widget _buildHomeworkItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6),
            child: Icon(Icons.circle, size: 8, color: AppColors.primaryOrange),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 15, color: AppColors.charcoal)),
          ),
        ],
      ),
    );
  }
}
