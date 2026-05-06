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
}
