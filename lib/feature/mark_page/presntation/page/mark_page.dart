import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_manager/core/colors/app_colors.dart';
import 'package:student_manager/core/extension/context.dart';
import 'package:student_manager/core/style/app_text_style.dart';
import 'package:student_manager/core/widgets/button.dart';
import 'package:student_manager/feature/mark_page/presntation/page/subject_model.dart';

@RoutePage()
class MarkPage extends StatefulWidget {
  const MarkPage({super.key});

  @override
  State<MarkPage> createState() => _MarkPageState();
}

class _MarkPageState extends State<MarkPage> {
  late List<String> _availableSubjects;

  late List<SubjectMarks> _subjects;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final l10n = context.l10n;
    _availableSubjects = [
      l10n.subjectMath,
      l10n.subjectPhysics,
      l10n.subjectHistory,
      l10n.subjectProgramming,
      l10n.subjectEnglish,
      l10n.subjectEconomics,
      l10n.subjectDatabases,
    ];
    _subjects = [
      SubjectMarks(id: '1', name: l10n.subjectMath, marks: [95, 88, 92]),
      SubjectMarks(id: '2', name: l10n.subjectPhysics, marks: [70, 65, 80]),
      SubjectMarks(id: '3', name: l10n.subjectHistory, marks: [100, 95]),
      SubjectMarks(id: '4', name: l10n.subjectProgramming, marks: [85, 90, 78]),
    ];
  }

  double _calculateTotalGPA() {
    if (_subjects.isEmpty) return 0.0;
    double sum = _subjects.map((s) => s.gpaContribution).reduce((a, b) => a + b);
    return sum / _subjects.length;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(l10n.performanceTitle, style: AppTextStyles.h1.copyWith(fontSize: 28)),
                      IconButton(
                        onPressed: _showAddSubjectSheet,
                        icon: const Icon(
                          CupertinoIcons.plus_app_fill,
                          size: 30,
                          color: AppColors.primaryOrange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildGPACard(),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: _subjects.length,
                itemBuilder: (context, index) => _buildSubjectCard(_subjects[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGPACard() {
    final gpa = _calculateTotalGPA();
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
                Text(l10n.overallGpa, style: AppTextStyles.caption.copyWith(color: Colors.white60)),
                const SizedBox(height: 4),
                Text(
                  gpa.toStringAsFixed(2),
                  style: AppTextStyles.h1.copyWith(color: Colors.white, fontSize: 32),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectCard(SubjectMarks subject) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => _showSubjectDetails(subject),
        borderRadius: BorderRadius.circular(24),
        child: Ink(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: AppColors.surfaceWhite, borderRadius: BorderRadius.circular(24)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(subject.name, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold)),
                  Text(
                    '${subject.average.toInt()}%',
                    style: TextStyle(color: subject.statusColor, fontWeight: FontWeight.w900, fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: subject.average / 100,
                  backgroundColor: AppColors.scaffoldBackground,
                  color: subject.statusColor,
                  minHeight: 8,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [...subject.marks.map((m) => _buildMarkBadge(m)), _buildAddMarkButton(subject)],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSubjectDetails(SubjectMarks subject) {
    final l10n = context.l10n;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(subject.name, style: AppTextStyles.h2)),
                _buildMarkBadge(subject.average.toInt()),
              ],
            ),
            const SizedBox(height: 32),
            _buildInfoRow(l10n.totalMarks, "${subject.marks.length}"),
            _buildInfoRow(l10n.averageScore, "${subject.average.toStringAsFixed(1)}%"),
            _buildInfoRow(l10n.statusLabel, subject.average >= 70 ? l10n.passingStatus : l10n.lowStatus),
            const SizedBox(height: 32),
            AppButton(text: l10n.closeButton, onPressed: () => Navigator.pop(context)),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showAddSubjectSheet() {
    final l10n = context.l10n;
    final availableSubjects = [
      l10n.subjectMath,
      l10n.subjectPhysics,
      l10n.subjectHistory,
      l10n.subjectProgramming,
      l10n.subjectEnglish,
      l10n.subjectEconomics,
      l10n.subjectDatabases,
    ];
    String selectedSubject = availableSubjects[0];

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
              Text(l10n.newSubjectTitle, style: AppTextStyles.h2),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.scaffoldBackground,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedSubject,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.primaryOrange),
                    items: availableSubjects.map((String value) {
                      return DropdownMenuItem<String>(value: value, child: Text(value));
                    }).toList(),
                    onChanged: (val) {
                      setSheetState(() => selectedSubject = val!);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
              AppButton(
                text: l10n.addToList,
                onPressed: () {
                  setState(() {
                    _subjects.add(
                      SubjectMarks(id: DateTime.now().toString(), name: selectedSubject, marks: []),
                    );
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

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: AppColors.textSecondary, fontSize: 16)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildMarkBadge(int mark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: AppColors.scaffoldBackground, borderRadius: BorderRadius.circular(10)),
      child: Text('$mark', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
    );
  }

  Widget _buildAddMarkButton(SubjectMarks subject) {
    return InkWell(
      onTap: () => _showAddMarkDialog(subject),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryOrange.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(Icons.add, size: 16, color: AppColors.primaryOrange),
      ),
    );
  }

  void _showAddMarkDialog(SubjectMarks subject) {
    final controller = TextEditingController();
    final l10n = context.l10n;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.enterScoreTitle),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          autofocus: true,
          decoration: InputDecoration(hintText: l10n.scoreExample),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.cancelButton)),
          TextButton(
            onPressed: () {
              final val = int.tryParse(controller.text);
              if (val != null && val >= 0 && val <= 100) {
                setState(() => subject.marks.add(val));
                Navigator.pop(context);
              }
            },
            child: Text(l10n.addButton),
          ),
        ],
      ),
    );
  }
}
