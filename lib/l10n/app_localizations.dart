import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_kk.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
    Locale('kk'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Student Manager'**
  String get appTitle;

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Student Manager'**
  String get welcomeMessage;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// No description provided for @loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Login successful!'**
  String get loginSuccess;

  /// No description provided for @loginError.
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password'**
  String get loginError;

  /// No description provided for @newHere.
  ///
  /// In en, this message translates to:
  /// **'New here?'**
  String get newHere;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccount;

  /// No description provided for @registerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Fill in the details to get started'**
  String get registerSubtitle;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @registerButton.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerButton;

  /// No description provided for @termsAndPrivacyDisclamer.
  ///
  /// In en, this message translates to:
  /// **'By registering, you agree to the terms of use and privacy policy.'**
  String get termsAndPrivacyDisclamer;

  /// No description provided for @forgetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Password recovery'**
  String get forgetPasswordTitle;

  /// No description provided for @forgetPasswordEnterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get forgetPasswordEnterEmail;

  /// No description provided for @sendCodeButton.
  ///
  /// In en, this message translates to:
  /// **'Send code'**
  String get sendCodeButton;

  /// No description provided for @enterCodeTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter code'**
  String get enterCodeTitle;

  /// No description provided for @codeSentTo.
  ///
  /// In en, this message translates to:
  /// **'A code was sent to {email}'**
  String codeSentTo(Object email);

  /// No description provided for @confirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmButton;

  /// No description provided for @newPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPasswordTitle;

  /// No description provided for @newPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a strong password'**
  String get newPasswordSubtitle;

  /// No description provided for @newPasswordField.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPasswordField;

  /// No description provided for @repeatPasswordField.
  ///
  /// In en, this message translates to:
  /// **'Repeat password'**
  String get repeatPasswordField;

  /// No description provided for @saveAndLogin.
  ///
  /// In en, this message translates to:
  /// **'Save and login'**
  String get saveAndLogin;

  /// No description provided for @scheduleTitle.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get scheduleTitle;

  /// No description provided for @editText.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editText;

  /// No description provided for @deleteText.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteText;

  /// No description provided for @newLesson.
  ///
  /// In en, this message translates to:
  /// **'New lesson'**
  String get newLesson;

  /// No description provided for @lessonEdit.
  ///
  /// In en, this message translates to:
  /// **'Editing'**
  String get lessonEdit;

  /// No description provided for @lessonSubjectLabel.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get lessonSubjectLabel;

  /// No description provided for @startLabel.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get startLabel;

  /// No description provided for @endLabel.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get endLabel;

  /// No description provided for @audienceLabel.
  ///
  /// In en, this message translates to:
  /// **'Room'**
  String get audienceLabel;

  /// No description provided for @saveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButton;

  /// No description provided for @noLessonsToday.
  ///
  /// In en, this message translates to:
  /// **'No lessons for this day'**
  String get noLessonsToday;

  /// No description provided for @addToList.
  ///
  /// In en, this message translates to:
  /// **'Add to list'**
  String get addToList;

  /// No description provided for @mondayShort.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get mondayShort;

  /// No description provided for @tuesdayShort.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get tuesdayShort;

  /// No description provided for @wednesdayShort.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get wednesdayShort;

  /// No description provided for @thursdayShort.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get thursdayShort;

  /// No description provided for @fridayShort.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get fridayShort;

  /// No description provided for @saturdayShort.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get saturdayShort;

  /// No description provided for @upcomingLessons.
  ///
  /// In en, this message translates to:
  /// **'Upcoming lessons'**
  String get upcomingLessons;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// No description provided for @currentTasks.
  ///
  /// In en, this message translates to:
  /// **'Current tasks'**
  String get currentTasks;

  /// No description provided for @totalGPA.
  ///
  /// In en, this message translates to:
  /// **'Total GPA'**
  String get totalGPA;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @greeting.
  ///
  /// In en, this message translates to:
  /// **'Hello, Student! 👋'**
  String get greeting;

  /// No description provided for @todayStudyDay.
  ///
  /// In en, this message translates to:
  /// **'Today is a great day for studying'**
  String get todayStudyDay;

  /// No description provided for @labTaskNumber.
  ///
  /// In en, this message translates to:
  /// **'Lab task №{number}'**
  String labTaskNumber(Object number);

  /// No description provided for @deadlineTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Due: tomorrow'**
  String get deadlineTomorrow;

  /// No description provided for @tasksTitle.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get tasksTitle;

  /// No description provided for @allFilter.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allFilter;

  /// No description provided for @inProgressFilter.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get inProgressFilter;

  /// No description provided for @completedFilter.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completedFilter;

  /// No description provided for @newTaskTitle.
  ///
  /// In en, this message translates to:
  /// **'New task'**
  String get newTaskTitle;

  /// No description provided for @whatToDoLabel.
  ///
  /// In en, this message translates to:
  /// **'What needs to be done?'**
  String get whatToDoLabel;

  /// No description provided for @deadlineLabel.
  ///
  /// In en, this message translates to:
  /// **'Deadline: {date}'**
  String deadlineLabel(Object date);

  /// No description provided for @createTaskButton.
  ///
  /// In en, this message translates to:
  /// **'Create task'**
  String get createTaskButton;

  /// No description provided for @noTasksYet.
  ///
  /// In en, this message translates to:
  /// **'No tasks yet'**
  String get noTasksYet;

  /// No description provided for @doneText.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get doneText;

  /// No description provided for @inProgressText.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get inProgressText;

  /// No description provided for @returnToWork.
  ///
  /// In en, this message translates to:
  /// **'Return to work'**
  String get returnToWork;

  /// No description provided for @startTask.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get startTask;

  /// No description provided for @finishTask.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finishTask;

  /// No description provided for @descriptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionTitle;

  /// No description provided for @descriptionText.
  ///
  /// In en, this message translates to:
  /// **'Complete the task before the deadline. Check all requirements, prepare the necessary materials, and make sure the solution meets academic standards.'**
  String get descriptionText;

  /// No description provided for @taskStatusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get taskStatusCompleted;

  /// No description provided for @taskStatusInProgress.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get taskStatusInProgress;

  /// No description provided for @taskStatusQueued.
  ///
  /// In en, this message translates to:
  /// **'Queued'**
  String get taskStatusQueued;

  /// No description provided for @deadlineInfo.
  ///
  /// In en, this message translates to:
  /// **'Deadline'**
  String get deadlineInfo;

  /// No description provided for @priorityInfo.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get priorityInfo;

  /// No description provided for @categoryInfo.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get categoryInfo;

  /// No description provided for @highPriority.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get highPriority;

  /// No description provided for @categoryStudy.
  ///
  /// In en, this message translates to:
  /// **'Study'**
  String get categoryStudy;

  /// No description provided for @closeButton.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeButton;

  /// No description provided for @doneButton.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get doneButton;

  /// No description provided for @personalData.
  ///
  /// In en, this message translates to:
  /// **'Personal data'**
  String get personalData;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logOut;

  /// No description provided for @overallGpa.
  ///
  /// In en, this message translates to:
  /// **'Overall GPA'**
  String get overallGpa;

  /// No description provided for @topPercentage.
  ///
  /// In en, this message translates to:
  /// **'Top 5%'**
  String get topPercentage;

  /// No description provided for @idLabel.
  ///
  /// In en, this message translates to:
  /// **'ID: {id}'**
  String idLabel(Object id);

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameLabel;

  /// No description provided for @phoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phoneLabel;

  /// No description provided for @lectureLabel.
  ///
  /// In en, this message translates to:
  /// **'LECTURE'**
  String get lectureLabel;

  /// No description provided for @timeLabel.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get timeLabel;

  /// No description provided for @roomLabel.
  ///
  /// In en, this message translates to:
  /// **'Room'**
  String get roomLabel;

  /// No description provided for @lessonTopic.
  ///
  /// In en, this message translates to:
  /// **'Lesson Topic'**
  String get lessonTopic;

  /// No description provided for @homework.
  ///
  /// In en, this message translates to:
  /// **'Homework'**
  String get homework;

  /// No description provided for @professor.
  ///
  /// In en, this message translates to:
  /// **'Professor'**
  String get professor;

  /// No description provided for @homeworkItem1.
  ///
  /// In en, this message translates to:
  /// **'Solve problems №452, 455 from the Demidovich collection.'**
  String get homeworkItem1;

  /// No description provided for @homeworkItem2.
  ///
  /// In en, this message translates to:
  /// **'Prepare for the quiz on the first chapter.'**
  String get homeworkItem2;

  /// No description provided for @roomAbbr.
  ///
  /// In en, this message translates to:
  /// **'rm.'**
  String get roomAbbr;

  /// No description provided for @auditoriumAbbr.
  ///
  /// In en, this message translates to:
  /// **'aud.'**
  String get auditoriumAbbr;

  /// No description provided for @labAbbr.
  ///
  /// In en, this message translates to:
  /// **'Lab'**
  String get labAbbr;

  /// No description provided for @lecture.
  ///
  /// In en, this message translates to:
  /// **'Lecture'**
  String get lecture;

  /// No description provided for @gym.
  ///
  /// In en, this message translates to:
  /// **'Gym'**
  String get gym;

  /// No description provided for @compClass1.
  ///
  /// In en, this message translates to:
  /// **'Comp. class 1'**
  String get compClass1;

  /// No description provided for @militaryBase.
  ///
  /// In en, this message translates to:
  /// **'Mil. corp.'**
  String get militaryBase;

  /// No description provided for @subjectHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get subjectHistory;

  /// No description provided for @subjectProgramming.
  ///
  /// In en, this message translates to:
  /// **'Programming'**
  String get subjectProgramming;

  /// No description provided for @subjectMath.
  ///
  /// In en, this message translates to:
  /// **'Higher Mathematics'**
  String get subjectMath;

  /// No description provided for @subjectPhysics.
  ///
  /// In en, this message translates to:
  /// **'Physics'**
  String get subjectPhysics;

  /// No description provided for @subjectInformatics.
  ///
  /// In en, this message translates to:
  /// **'Informatics'**
  String get subjectInformatics;

  /// No description provided for @subjectEnglish.
  ///
  /// In en, this message translates to:
  /// **'English Language'**
  String get subjectEnglish;

  /// No description provided for @subjectHistoryKaz.
  ///
  /// In en, this message translates to:
  /// **'History of Kazakhstan'**
  String get subjectHistoryKaz;

  /// No description provided for @subjectPhysicalEducation.
  ///
  /// In en, this message translates to:
  /// **'Physical Education'**
  String get subjectPhysicalEducation;

  /// No description provided for @subjectDiscreteMath.
  ///
  /// In en, this message translates to:
  /// **'Discrete Mathematics'**
  String get subjectDiscreteMath;

  /// No description provided for @subjectPython.
  ///
  /// In en, this message translates to:
  /// **'Python Programming'**
  String get subjectPython;

  /// No description provided for @subjectEconomics.
  ///
  /// In en, this message translates to:
  /// **'Economics'**
  String get subjectEconomics;

  /// No description provided for @subjectCulturalStudies.
  ///
  /// In en, this message translates to:
  /// **'Cultural Studies'**
  String get subjectCulturalStudies;

  /// No description provided for @subjectStatistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get subjectStatistics;

  /// No description provided for @subjectDatabases.
  ///
  /// In en, this message translates to:
  /// **'Databases'**
  String get subjectDatabases;

  /// No description provided for @subjectComputerArch.
  ///
  /// In en, this message translates to:
  /// **'Computer Architecture'**
  String get subjectComputerArch;

  /// No description provided for @subjectMilitary.
  ///
  /// In en, this message translates to:
  /// **'Military Department'**
  String get subjectMilitary;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @room.
  ///
  /// In en, this message translates to:
  /// **'Room'**
  String get room;

  /// No description provided for @teacher.
  ///
  /// In en, this message translates to:
  /// **'Teacher'**
  String get teacher;

  /// No description provided for @mockLessonTopicDescription.
  ///
  /// In en, this message translates to:
  /// **'Basics of integral calculus and the application of definite integrals in physical problems.'**
  String get mockLessonTopicDescription;

  /// No description provided for @mockHomework1.
  ///
  /// In en, this message translates to:
  /// **'Solve problems No. 452, 455 from the Demidovich collection.'**
  String get mockHomework1;

  /// No description provided for @mockHomework2.
  ///
  /// In en, this message translates to:
  /// **'Prepare for the colloquium on the first chapter.'**
  String get mockHomework2;

  /// No description provided for @mockTeacherName.
  ///
  /// In en, this message translates to:
  /// **'Ivanov Ivan Ivanovich'**
  String get mockTeacherName;

  /// No description provided for @mockTeacherStatus.
  ///
  /// In en, this message translates to:
  /// **'Professor, Doctor of Physical and Mathematical Sciences'**
  String get mockTeacherStatus;

  /// No description provided for @performanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Performance'**
  String get performanceTitle;

  /// No description provided for @newSubjectTitle.
  ///
  /// In en, this message translates to:
  /// **'New subject'**
  String get newSubjectTitle;

  /// No description provided for @totalMarks.
  ///
  /// In en, this message translates to:
  /// **'Total marks'**
  String get totalMarks;

  /// No description provided for @averageScore.
  ///
  /// In en, this message translates to:
  /// **'Average score'**
  String get averageScore;

  /// No description provided for @statusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get statusLabel;

  /// No description provided for @passingStatus.
  ///
  /// In en, this message translates to:
  /// **'Passing'**
  String get passingStatus;

  /// No description provided for @lowStatus.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get lowStatus;

  /// No description provided for @enterScoreTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter score (0-100)'**
  String get enterScoreTitle;

  /// No description provided for @scoreExample.
  ///
  /// In en, this message translates to:
  /// **'For example: 85'**
  String get scoreExample;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @addButton.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get addButton;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select language'**
  String get selectLanguage;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notification;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @math.
  ///
  /// In en, this message translates to:
  /// **'Math'**
  String get math;

  /// No description provided for @physics.
  ///
  /// In en, this message translates to:
  /// **'Physics'**
  String get physics;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @deadlineTitle.
  ///
  /// In en, this message translates to:
  /// **'Deadline is close!'**
  String get deadlineTitle;

  /// No description provided for @scheduleChangeTitle.
  ///
  /// In en, this message translates to:
  /// **'Schedule Change'**
  String get scheduleChangeTitle;

  /// No description provided for @systemUpdateTitle.
  ///
  /// In en, this message translates to:
  /// **'System Update'**
  String get systemUpdateTitle;

  /// No description provided for @newGradeTitle.
  ///
  /// In en, this message translates to:
  /// **'New grade in {subject}'**
  String newGradeTitle(String subject);

  /// No description provided for @newGradeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You received \"{grade}\" for {workName}'**
  String newGradeSubtitle(String grade, String workName);

  /// No description provided for @deadlineSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow is the last day to submit the {subject} project'**
  String deadlineSubtitle(String subject);

  /// No description provided for @scheduleChangeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The {subject} class has been moved to room {room}'**
  String scheduleChangeSubtitle(String subject, String room);

  /// No description provided for @systemUpdateSubtitle.
  ///
  /// In en, this message translates to:
  /// **'App updated to version {version}'**
  String systemUpdateSubtitle(String version);

  /// No description provided for @minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} min ago'**
  String minutesAgo(int count);

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} hours ago'**
  String hoursAgo(int count);

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterEmail;

  /// No description provided for @enterCode.
  ///
  /// In en, this message translates to:
  /// **'Enter the code sent to your email'**
  String get enterCode;

  /// No description provided for @enterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your new password'**
  String get enterNewPassword;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm your new password'**
  String get confirmNewPassword;

  /// No description provided for @sendCode.
  ///
  /// In en, this message translates to:
  /// **'Send code'**
  String get sendCode;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @emailValidationError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get emailValidationError;

  /// No description provided for @passwordValidationError.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters long and include a number and a special character'**
  String get passwordValidationError;

  /// No description provided for @confirmPasswordValidationError.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get confirmPasswordValidationError;

  /// No description provided for @fullNameValidationError.
  ///
  /// In en, this message translates to:
  /// **'Please enter your full name'**
  String get fullNameValidationError;

  /// No description provided for @unexpectedError.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Please try again later.'**
  String get unexpectedError;

  /// No description provided for @invalidEmailFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid email format'**
  String get invalidEmailFormat;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get enterPassword;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password too short'**
  String get passwordTooShort;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @enterName.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enterName;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'kk', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'kk':
      return AppLocalizationsKk();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
