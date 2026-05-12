// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Student Manager';

  @override
  String get welcomeMessage => 'Welcome to Student Manager';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get loginButton => 'Login';

  @override
  String get loginSuccess => 'Login successful!';

  @override
  String get loginError => 'Invalid email or password';

  @override
  String get newHere => 'New here?';

  @override
  String get createAccount => 'Create account';

  @override
  String get registerSubtitle => 'Fill in the details to get started';

  @override
  String get fullName => 'Full name';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get registerButton => 'Register';

  @override
  String get termsAndPrivacyDisclamer =>
      'By registering, you agree to the terms of use and privacy policy.';

  @override
  String get forgetPasswordTitle => 'Password recovery';

  @override
  String get forgetPasswordEnterEmail => 'Enter your email';

  @override
  String get sendCodeButton => 'Send code';

  @override
  String get enterCodeTitle => 'Enter code';

  @override
  String codeSentTo(Object email) {
    return 'A code was sent to $email';
  }

  @override
  String get confirmButton => 'Confirm';

  @override
  String get newPasswordTitle => 'New password';

  @override
  String get newPasswordSubtitle => 'Choose a strong password';

  @override
  String get newPasswordField => 'New password';

  @override
  String get repeatPasswordField => 'Repeat password';

  @override
  String get saveAndLogin => 'Save and login';

  @override
  String get scheduleTitle => 'Schedule';

  @override
  String get editText => 'Edit';

  @override
  String get deleteText => 'Delete';

  @override
  String get newLesson => 'New lesson';

  @override
  String get lessonEdit => 'Editing';

  @override
  String get lessonSubjectLabel => 'Subject';

  @override
  String get startLabel => 'Start';

  @override
  String get endLabel => 'End';

  @override
  String get audienceLabel => 'Room';

  @override
  String get saveButton => 'Save';

  @override
  String get noLessonsToday => 'No lessons for this day';

  @override
  String get addToList => 'Add to list';

  @override
  String get mondayShort => 'Mon';

  @override
  String get tuesdayShort => 'Tue';

  @override
  String get wednesdayShort => 'Wed';

  @override
  String get thursdayShort => 'Thu';

  @override
  String get fridayShort => 'Fri';

  @override
  String get saturdayShort => 'Sat';

  @override
  String get upcomingLessons => 'Upcoming lessons';

  @override
  String get seeAll => 'See all';

  @override
  String get currentTasks => 'Current tasks';

  @override
  String get totalGPA => 'Total GPA';

  @override
  String get profileTitle => 'Profile';

  @override
  String get greeting => 'Hello, Student! 👋';

  @override
  String get todayStudyDay => 'Today is a great day for studying';

  @override
  String labTaskNumber(Object number) {
    return 'Lab task №$number';
  }

  @override
  String get deadlineTomorrow => 'Due: tomorrow';

  @override
  String get tasksTitle => 'Tasks';

  @override
  String get allFilter => 'All';

  @override
  String get inProgressFilter => 'In Progress';

  @override
  String get completedFilter => 'Completed';

  @override
  String get newTaskTitle => 'New task';

  @override
  String get whatToDoLabel => 'What needs to be done?';

  @override
  String deadlineLabel(Object date) {
    return 'Deadline: $date';
  }

  @override
  String get createTaskButton => 'Create task';

  @override
  String get noTasksYet => 'No tasks yet';

  @override
  String get doneText => 'Done';

  @override
  String get inProgressText => 'In progress';

  @override
  String get returnToWork => 'Return to work';

  @override
  String get startTask => 'Start';

  @override
  String get finishTask => 'Finish';

  @override
  String get descriptionTitle => 'Description';

  @override
  String get descriptionText =>
      'Complete the task before the deadline. Check all requirements, prepare the necessary materials, and make sure the solution meets academic standards.';

  @override
  String get taskStatusCompleted => 'Completed';

  @override
  String get taskStatusInProgress => 'In progress';

  @override
  String get taskStatusQueued => 'Queued';

  @override
  String get deadlineInfo => 'Deadline';

  @override
  String get priorityInfo => 'Priority';

  @override
  String get categoryInfo => 'Category';

  @override
  String get highPriority => 'High';

  @override
  String get categoryStudy => 'Study';

  @override
  String get closeButton => 'Close';

  @override
  String get doneButton => 'Done';

  @override
  String get personalData => 'Personal data';

  @override
  String get security => 'Security';

  @override
  String get logOut => 'Log out';

  @override
  String get overallGpa => 'Overall GPA';

  @override
  String get topPercentage => 'Top 5%';

  @override
  String idLabel(Object id) {
    return 'ID: $id';
  }

  @override
  String get nameLabel => 'Name';

  @override
  String get phoneLabel => 'Phone';

  @override
  String get lectureLabel => 'LECTURE';

  @override
  String get timeLabel => 'Time';

  @override
  String get roomLabel => 'Room';

  @override
  String get lessonTopic => 'Lesson Topic';

  @override
  String get homework => 'Homework';

  @override
  String get professor => 'Professor';

  @override
  String get homeworkItem1 =>
      'Solve problems №452, 455 from the Demidovich collection.';

  @override
  String get homeworkItem2 => 'Prepare for the quiz on the first chapter.';

  @override
  String get roomAbbr => 'rm.';

  @override
  String get auditoriumAbbr => 'aud.';

  @override
  String get labAbbr => 'Lab';

  @override
  String get lecture => 'Lecture';

  @override
  String get gym => 'Gym';

  @override
  String get compClass1 => 'Comp. class 1';

  @override
  String get militaryBase => 'Mil. corp.';

  @override
  String get subjectHistory => 'History';

  @override
  String get subjectProgramming => 'Programming';

  @override
  String get subjectMath => 'Higher Mathematics';

  @override
  String get subjectPhysics => 'Physics';

  @override
  String get subjectInformatics => 'Informatics';

  @override
  String get subjectEnglish => 'English Language';

  @override
  String get subjectHistoryKaz => 'History of Kazakhstan';

  @override
  String get subjectPhysicalEducation => 'Physical Education';

  @override
  String get subjectDiscreteMath => 'Discrete Mathematics';

  @override
  String get subjectPython => 'Python Programming';

  @override
  String get subjectEconomics => 'Economics';

  @override
  String get subjectCulturalStudies => 'Cultural Studies';

  @override
  String get subjectStatistics => 'Statistics';

  @override
  String get subjectDatabases => 'Databases';

  @override
  String get subjectComputerArch => 'Computer Architecture';

  @override
  String get subjectMilitary => 'Military Department';

  @override
  String get time => 'Time';

  @override
  String get room => 'Room';

  @override
  String get teacher => 'Teacher';

  @override
  String get mockLessonTopicDescription =>
      'Basics of integral calculus and the application of definite integrals in physical problems.';

  @override
  String get mockHomework1 =>
      'Solve problems No. 452, 455 from the Demidovich collection.';

  @override
  String get mockHomework2 =>
      'Prepare for the colloquium on the first chapter.';

  @override
  String get mockTeacherName => 'Ivanov Ivan Ivanovich';

  @override
  String get mockTeacherStatus =>
      'Professor, Doctor of Physical and Mathematical Sciences';

  @override
  String get performanceTitle => 'Performance';

  @override
  String get newSubjectTitle => 'New subject';

  @override
  String get totalMarks => 'Total marks';

  @override
  String get averageScore => 'Average score';

  @override
  String get statusLabel => 'Status';

  @override
  String get passingStatus => 'Passing';

  @override
  String get lowStatus => 'Low';

  @override
  String get enterScoreTitle => 'Enter score (0-100)';

  @override
  String get scoreExample => 'For example: 85';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get addButton => 'Add';

  @override
  String get language => 'Language';

  @override
  String get selectLanguage => 'Select language';

  @override
  String get notification => 'Notifications';

  @override
  String get notifications => 'Notifications';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get math => 'Math';

  @override
  String get physics => 'Physics';

  @override
  String get history => 'History';

  @override
  String get deadlineTitle => 'Deadline is close!';

  @override
  String get scheduleChangeTitle => 'Schedule Change';

  @override
  String get systemUpdateTitle => 'System Update';

  @override
  String newGradeTitle(String subject) {
    return 'New grade in $subject';
  }

  @override
  String newGradeSubtitle(String grade, String workName) {
    return 'You received \"$grade\" for $workName';
  }

  @override
  String deadlineSubtitle(String subject) {
    return 'Tomorrow is the last day to submit the $subject project';
  }

  @override
  String scheduleChangeSubtitle(String subject, String room) {
    return 'The $subject class has been moved to room $room';
  }

  @override
  String systemUpdateSubtitle(String version) {
    return 'App updated to version $version';
  }

  @override
  String minutesAgo(int count) {
    return '$count min ago';
  }

  @override
  String hoursAgo(int count) {
    return '$count hours ago';
  }

  @override
  String get enterEmail => 'Enter your email';

  @override
  String get enterCode => 'Enter the code sent to your email';

  @override
  String get enterNewPassword => 'Enter your new password';

  @override
  String get confirmNewPassword => 'Confirm your new password';

  @override
  String get sendCode => 'Send code';

  @override
  String get confirm => 'Confirm';

  @override
  String get emailValidationError => 'Please enter a valid email address';

  @override
  String get passwordValidationError =>
      'Password must be at least 8 characters long and include a number and a special character';

  @override
  String get confirmPasswordValidationError => 'Passwords do not match';

  @override
  String get fullNameValidationError => 'Please enter your full name';

  @override
  String get unexpectedError =>
      'An unexpected error occurred. Please try again later.';

  @override
  String get invalidEmailFormat => 'Invalid email format';

  @override
  String get enterPassword => 'Enter password';

  @override
  String get passwordTooShort => 'Password too short';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get enterName => 'Enter your name';

  @override
  String get adminGreeting => 'Hello, Administrator';

  @override
  String get adminHomeSubtitle => 'System overview and quick access';

  @override
  String get adminPeopleTitle => 'People management';

  @override
  String get adminAcademicTitle => 'Academic structure';

  @override
  String get adminInsightsTitle => 'Analytics and communications';

  @override
  String get adminRoleBadge => 'Administrator';

  @override
  String get adminSectionDashboard => 'Dashboard';

  @override
  String get adminDashHome => 'Home';

  @override
  String get adminDashSystemStats => 'System statistics';

  @override
  String get adminDashStudentsCount => 'Number of students';

  @override
  String get adminDashTeachersCount => 'Number of teachers';

  @override
  String get adminDashGroupsCount => 'Number of groups';

  @override
  String get adminDashUserActivity => 'User activity';

  @override
  String get adminDashRecentNotifications => 'Recent notifications';

  @override
  String get adminSectionStudents => 'Student management';

  @override
  String get adminStudentAdd => 'Add student';

  @override
  String get adminStudentEdit => 'Edit student';

  @override
  String get adminStudentDelete => 'Delete student';

  @override
  String get adminStudentSearch => 'Search students';

  @override
  String get adminStudentList => 'Student list';

  @override
  String get adminStudentImport => 'Import students';

  @override
  String get adminStudentExport => 'Export data';

  @override
  String get adminSectionTeachers => 'Teacher management';

  @override
  String get adminTeacherAdd => 'Add teacher';

  @override
  String get adminTeacherEdit => 'Edit teacher';

  @override
  String get adminTeacherDelete => 'Delete teacher';

  @override
  String get adminTeacherAssignSubject => 'Assign subject';

  @override
  String get adminTeacherList => 'Teacher list';

  @override
  String get adminTeacherSearch => 'Search teacher';

  @override
  String get adminSectionGroups => 'Group management';

  @override
  String get adminGroupCreate => 'Create group';

  @override
  String get adminGroupEdit => 'Edit group';

  @override
  String get adminGroupDelete => 'Delete group';

  @override
  String get adminGroupAddStudents => 'Add students to group';

  @override
  String get adminGroupAssignCurator => 'Assign curator';

  @override
  String get adminSectionSubjects => 'Subject management';

  @override
  String get adminSubjectAdd => 'Add subject';

  @override
  String get adminSubjectEdit => 'Edit subject';

  @override
  String get adminSubjectDelete => 'Delete subject';

  @override
  String get adminSubjectAssignTeacher => 'Assign teacher';

  @override
  String get adminSubjectList => 'Subject list';

  @override
  String get adminSectionSchedule => 'Schedule';

  @override
  String get adminScheduleCreate => 'Create schedule';

  @override
  String get adminScheduleEdit => 'Edit schedule';

  @override
  String get adminScheduleDelete => 'Delete schedule';

  @override
  String get adminScheduleAssignRoom => 'Assign room';

  @override
  String get adminScheduleAssignTeacher => 'Assign teacher';

  @override
  String get adminScheduleView => 'View schedule';

  @override
  String get adminSectionPerformance => 'Performance';

  @override
  String get adminPerfViewGrades => 'View grades';

  @override
  String get adminPerfGpaStats => 'GPA statistics';

  @override
  String get adminPerfAnalytics => 'Performance analytics';

  @override
  String get adminPerfStudentReport => 'Student report';

  @override
  String get adminPerfExportReports => 'Export reports';

  @override
  String get adminSectionAttendance => 'Attendance';

  @override
  String get adminAttView => 'View attendance';

  @override
  String get adminAttReport => 'Attendance report';

  @override
  String get adminAttAbsenceStats => 'Absence statistics';

  @override
  String get adminSectionNotifications => 'Notifications';

  @override
  String get adminNotifCreate => 'Create notification';

  @override
  String get adminNotifSendMessage => 'Send message';

  @override
  String get adminNotifBulk => 'Bulk mailing';

  @override
  String get adminNotifHistory => 'Notification history';

  @override
  String get adminSectionSecurity => 'Security';

  @override
  String get adminSecRoles => 'Manage roles';

  @override
  String get adminSecResetPassword => 'Reset password';

  @override
  String get adminSecBlockUser => 'Block user';

  @override
  String get adminSecLoginHistory => 'Login history';

  @override
  String get adminSecSettings => 'Security settings';

  @override
  String get teacherGreeting => 'Hello, Teacher';

  @override
  String get teacherHomeSubtitle => 'Your teaching workspace';

  @override
  String get teacherTodayClasses => 'Classes today';

  @override
  String get teacherPendingReviews => 'Works to review';

  @override
  String get teacherSectionShortcuts => 'Quick actions';

  @override
  String get teacherShortcutMyGroups => 'My groups';

  @override
  String get teacherShortcutMySchedule => 'My schedule';

  @override
  String get teacherShortcutAssignments => 'Assignments';

  @override
  String get teacherShortcutGrades => 'Grades';

  @override
  String get teacherShortcutAttendance => 'Attendance';

  @override
  String get teacherGroupsTitle => 'My groups';

  @override
  String get teacherSectionMyGroups => 'Groups';

  @override
  String get teacherGroupCs101 => 'CS-101 · 28 students';

  @override
  String get teacherGroupMath202 => 'MATH-202 · 22 students';

  @override
  String get teacherGroupPhysicsLab => 'PHYS-LAB · 18 students';

  @override
  String get teacherScheduleTitle => 'My schedule';

  @override
  String get teacherScheduleSubtitle => 'Today';

  @override
  String get teacherScheduleItem1Time => '09:00 – 10:30';

  @override
  String get teacherScheduleItem1Title => 'Higher Mathematics';

  @override
  String get teacherScheduleItem1Room => 'Aud. 402';

  @override
  String get teacherScheduleItem2Time => '11:00 – 12:30';

  @override
  String get teacherScheduleItem2Title => 'Programming workshop';

  @override
  String get teacherScheduleItem2Room => 'Comp. lab 1';

  @override
  String get teacherScheduleItem3Time => '14:00 – 15:30';

  @override
  String get teacherScheduleItem3Title => 'Physics';

  @override
  String get teacherScheduleItem3Room => 'Aud. 210';

  @override
  String get teacherWorkTitle => 'Teaching';

  @override
  String get teacherSectionAssignments => 'Assignments and grading';

  @override
  String get teacherAssignments => 'Assignments';

  @override
  String get teacherCheckWork => 'Review submissions';

  @override
  String get teacherSectionGradesAttendance => 'Grades and attendance';

  @override
  String get teacherGrades => 'Grades';

  @override
  String get teacherAttendance => 'Attendance';

  @override
  String get teacherRoleBadge => 'Teacher';

  @override
  String get teacherSectionMore => 'Communication and profile';

  @override
  String get teacherMessages => 'Messages';

  @override
  String get teacherAnalytics => 'Analytics';

  @override
  String get teacherProfileSettings => 'Profile settings';

  @override
  String get teacherDashOverviewTitle => 'Today\'s overview';

  @override
  String get teacherStatReachLabel => 'Students (your groups)';

  @override
  String get teacherStatGpaLabel => 'Avg. GPA (mock)';

  @override
  String get teacherOfficeHoursLabel => 'Office hours';

  @override
  String get teacherLoadMockTitle => 'Weekly teaching hours (mock)';

  @override
  String get teacherFeedT1 => 'CS-101 · 8 lab submissions awaiting review';

  @override
  String get teacherFeedT2 => 'MTH-202 · Quiz graded · avg 78%';

  @override
  String get teacherFeedT3 => 'PHY-LAB · Attendance marked for today';

  @override
  String get teacherRosterPreview => 'Roster preview (sample)';

  @override
  String get teacherGroupSampleStu1 => 'Alex Ivanov · submitted';

  @override
  String get teacherGroupSampleStu2 => 'Maria Kim · pending';

  @override
  String get teacherGroupSampleStu3 => 'Daniyar Ospan · late';

  @override
  String get teacherGroupsNextClass => 'Next class';

  @override
  String get teacherScheduleBusyTitle => 'Load by day (mock)';

  @override
  String get teacherWorkDueTitle => 'Due soon';

  @override
  String get teacherMockTaskLine1 => 'Lab 4 · CS-101';

  @override
  String get teacherMockTaskSub1 => 'Due tomorrow · 28 students';

  @override
  String get teacherMockTaskLine2 => 'Quiz retake · MTH-202';

  @override
  String get teacherMockTaskSub2 => 'In 2 days · 22 students';

  @override
  String get teacherMockTaskLine3 => 'Course report · PHY-LAB';

  @override
  String get teacherMockTaskSub3 => 'May 18 · 18 students';

  @override
  String get teacherGradeBlockTitle => 'Grades snapshot';

  @override
  String get teacherMockGradeLine1 => 'CS-101 · class avg 4.1';

  @override
  String get teacherMockGradeLine2 => 'MTH-202 · class avg 3.7';

  @override
  String get teacherAttYourGroupsTitle => 'Attendance · your groups (mock)';

  @override
  String get teacherProfileQuickTitle => 'Shortcuts';

  @override
  String get teacherGroupOpenMock => 'Open group (mock)';

  @override
  String get adminSystemOverviewTitle => 'System overview';

  @override
  String get adminHealthGood => 'All systems operational';

  @override
  String get adminHealthMeta => 'Last backup today · 04:32';

  @override
  String get adminMetricCpu => 'CPU';

  @override
  String get adminMetricMemory => 'RAM';

  @override
  String get adminMetricApi => 'API';

  @override
  String get adminActivitySection => 'Recent activity';

  @override
  String get adminFeed1 => 'New enrollment · IIT-21';

  @override
  String get adminFeed2 => 'Timetable published · week 14';

  @override
  String get adminFeed3 => 'Security scan · no issues';

  @override
  String get adminQuickActionsTitle => 'Quick actions';

  @override
  String get adminLoadOverviewTitle => 'Weekly load (mock)';

  @override
  String get adminPeopleSummaryStudents => 'Students in directory';

  @override
  String get adminPeopleSummaryTeachers => 'Teaching staff';

  @override
  String adminTrendPositive(String value) {
    return '+$value% this month';
  }

  @override
  String get adminAcademicFeaturedGroups => 'Featured groups';

  @override
  String get adminMockGroup1 => 'IIT-21 · 32 students';

  @override
  String get adminMockGroup2 => 'MTH-09 · 28 students';

  @override
  String get adminMockGroup3 => 'PHY-LAB · 18 students';

  @override
  String get adminSubjectsActiveLabel => 'Active subjects';

  @override
  String get adminScheduleNextHint => 'Next publish in 2 days';

  @override
  String get adminInsightsPassRate => 'Pass rate';

  @override
  String get adminInsightsAttendance => 'Avg. attendance';

  @override
  String get adminInsightsNotifications => 'Notifications (7d)';

  @override
  String get adminProfileSecurityScore => 'Security score';

  @override
  String get adminMockSubjectCount => '42 subjects';

  @override
  String get adminPeopleSearchHint => 'Search by name or ID';

  @override
  String get adminPeopleStudentsSample => 'Students (sample)';

  @override
  String get adminPeopleTeachersSample => 'Teachers (sample)';

  @override
  String get adminPeopleOpenMock => 'Open (mock)';

  @override
  String get adminMockStudentLine1 => 'Alex Ivanov · IIT-21 · 220104032';

  @override
  String get adminMockStudentLine2 => 'Maria Kim · MTH-09 · 220108011';

  @override
  String get adminMockStudentLine3 => 'Daniyar Ospan · PHY-LAB · 219902004';

  @override
  String get adminMockStudentLine4 => 'Sophie Lee · IIT-21 · 221001015';

  @override
  String get adminMockTeacherLine1 => 'Ivanov I. I. · Higher mathematics';

  @override
  String get adminMockTeacherLine2 => 'Nurpeisova A. · Programming';

  @override
  String get adminGroupManageTitle => 'Group management';

  @override
  String adminGroupMembers(int count) {
    return '$count members';
  }

  @override
  String get adminMockCuratorShort => 'Curator assigned';

  @override
  String get adminAttWeekTitle => 'Attendance this week (mock)';

  @override
  String get adminAttTodayList => 'Today (sample)';

  @override
  String get adminMockAttLine1 => 'Alex Ivanov · Present';

  @override
  String get adminMockAttLine2 => 'Maria Kim · Late 8 min';

  @override
  String get adminMockAttLine3 => 'Daniyar Ospan · Present';

  @override
  String get adminMockAttLine4 => 'Sophie Lee · Absent';

  @override
  String get profileStudentCardName => 'Dana Karimova';

  @override
  String get profileStudentCardId => '220887015';

  @override
  String get profileStudentCardEmail => 'dana.karimova@student.university.edu';

  @override
  String get loginDemoHint =>
      'Demo: aruka@gmail.com (student), admin@student.manager (admin), teacher@student.manager (teacher) — password: password123';
}
