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

  /// No description provided for @registerSuccess.
  ///
  /// In en, this message translates to:
  /// **'Account created successfully!'**
  String get registerSuccess;

  /// No description provided for @registerError.
  ///
  /// In en, this message translates to:
  /// **'Could not create account'**
  String get registerError;

  /// No description provided for @resetEmailSent.
  ///
  /// In en, this message translates to:
  /// **'Password reset email sent. Check your inbox.'**
  String get resetEmailSent;

  /// No description provided for @resetEmailSpamHint.
  ///
  /// In en, this message translates to:
  /// **'If you don\'t see it in 2–3 minutes, check Spam/Promotions. Look for an email from noreply@*.firebaseapp.com. Use the exact email you registered with.'**
  String get resetEmailSpamHint;

  /// No description provided for @resetEmailSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Check your email'**
  String get resetEmailSuccessTitle;

  /// No description provided for @resetEmailSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'We sent a password reset link to {email}. Open the email and follow the link to set a new password.'**
  String resetEmailSuccessMessage(String email);

  /// No description provided for @backToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to login'**
  String get backToLogin;

  /// No description provided for @resetCodeHint.
  ///
  /// In en, this message translates to:
  /// **'Paste the reset code from the email link'**
  String get resetCodeHint;

  /// No description provided for @resetCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Reset code'**
  String get resetCodeLabel;

  /// No description provided for @passwordResetSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password updated successfully!'**
  String get passwordResetSuccess;

  /// No description provided for @invalidResetCode.
  ///
  /// In en, this message translates to:
  /// **'Invalid or expired reset code'**
  String get invalidResetCode;

  /// No description provided for @emailAlreadyInUse.
  ///
  /// In en, this message translates to:
  /// **'This email is already registered'**
  String get emailAlreadyInUse;

  /// No description provided for @emailAlreadyInUseOtherPassword.
  ///
  /// In en, this message translates to:
  /// **'This email is already registered with a different password. Use the correct password or another email.'**
  String get emailAlreadyInUseOtherPassword;

  /// No description provided for @cannotModifyAdmin.
  ///
  /// In en, this message translates to:
  /// **'Cannot change the administrator account.'**
  String get cannotModifyAdmin;

  /// No description provided for @userNotFound.
  ///
  /// In en, this message translates to:
  /// **'No account found with this email'**
  String get userNotFound;

  /// No description provided for @authGenericError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get authGenericError;

  /// No description provided for @createAdminButton.
  ///
  /// In en, this message translates to:
  /// **'Create admin account'**
  String get createAdminButton;

  /// No description provided for @adminCreatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Admin account created successfully'**
  String get adminCreatedSuccess;

  /// No description provided for @adminAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'Admin already exists. Only one administrator is allowed.'**
  String get adminAlreadyExists;

  /// No description provided for @adminUserAddedSuccess.
  ///
  /// In en, this message translates to:
  /// **'User created successfully'**
  String get adminUserAddedSuccess;

  /// No description provided for @adminCuratorAssignedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Curator assigned to group'**
  String get adminCuratorAssignedSuccess;

  /// No description provided for @adminNoStudents.
  ///
  /// In en, this message translates to:
  /// **'No students yet'**
  String get adminNoStudents;

  /// No description provided for @adminNoTeachers.
  ///
  /// In en, this message translates to:
  /// **'No curators yet'**
  String get adminNoTeachers;

  /// No description provided for @adminAddStudentTitle.
  ///
  /// In en, this message translates to:
  /// **'Add student'**
  String get adminAddStudentTitle;

  /// No description provided for @adminAddCuratorTitle.
  ///
  /// In en, this message translates to:
  /// **'Add curator'**
  String get adminAddCuratorTitle;

  /// No description provided for @adminSelectCuratorTitle.
  ///
  /// In en, this message translates to:
  /// **'Select curator'**
  String get adminSelectCuratorTitle;

  /// No description provided for @adminCuratorNotAssigned.
  ///
  /// In en, this message translates to:
  /// **'Curator not assigned'**
  String get adminCuratorNotAssigned;

  /// No description provided for @adminDefaultPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Default password: Student123!'**
  String get adminDefaultPasswordHint;

  /// No description provided for @profileNotFound.
  ///
  /// In en, this message translates to:
  /// **'User profile not found. Contact administrator.'**
  String get profileNotFound;

  /// No description provided for @firestorePermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Firestore access denied. Check Firebase rules and publish them.'**
  String get firestorePermissionDenied;

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

  /// No description provided for @noGradesYet.
  ///
  /// In en, this message translates to:
  /// **'No grades yet. Your teacher will add them after assignments are graded.'**
  String get noGradesYet;

  /// No description provided for @gradeAddedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Grade saved successfully'**
  String get gradeAddedSuccess;

  /// No description provided for @assignmentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Assignments'**
  String get assignmentsTitle;

  /// No description provided for @studentNoGroupAssigned.
  ///
  /// In en, this message translates to:
  /// **'You are not assigned to a group yet'**
  String get studentNoGroupAssigned;

  /// No description provided for @noAssignmentsYet.
  ///
  /// In en, this message translates to:
  /// **'No assignments yet'**
  String get noAssignmentsYet;

  /// No description provided for @submissionGraded.
  ///
  /// In en, this message translates to:
  /// **'Graded'**
  String get submissionGraded;

  /// No description provided for @submissionSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Submitted'**
  String get submissionSubmitted;

  /// No description provided for @submissionDraft.
  ///
  /// In en, this message translates to:
  /// **'Not submitted'**
  String get submissionDraft;

  /// No description provided for @workSubmittedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Work submitted successfully'**
  String get workSubmittedSuccess;

  /// No description provided for @noDescription.
  ///
  /// In en, this message translates to:
  /// **'No description'**
  String get noDescription;

  /// No description provided for @teacherFeedback.
  ///
  /// In en, this message translates to:
  /// **'Teacher feedback'**
  String get teacherFeedback;

  /// No description provided for @yourAnswerLabel.
  ///
  /// In en, this message translates to:
  /// **'Your answer'**
  String get yourAnswerLabel;

  /// No description provided for @submitWorkButton.
  ///
  /// In en, this message translates to:
  /// **'Submit work'**
  String get submitWorkButton;

  /// No description provided for @emptyAnswerError.
  ///
  /// In en, this message translates to:
  /// **'Please enter your answer'**
  String get emptyAnswerError;

  /// No description provided for @teacherCreateAssignmentTitle.
  ///
  /// In en, this message translates to:
  /// **'Create assignment'**
  String get teacherCreateAssignmentTitle;

  /// No description provided for @teacherPendingSubmissionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Pending submissions'**
  String get teacherPendingSubmissionsTitle;

  /// No description provided for @assignmentCreatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Assignment created'**
  String get assignmentCreatedSuccess;

  /// No description provided for @assignmentTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Assignment title'**
  String get assignmentTitleLabel;

  /// No description provided for @assignmentDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get assignmentDescriptionLabel;

  /// No description provided for @assignmentDueDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Due date'**
  String get assignmentDueDateLabel;

  /// No description provided for @feedbackLabel.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedbackLabel;

  /// No description provided for @createAssignmentButton.
  ///
  /// In en, this message translates to:
  /// **'Create assignment'**
  String get createAssignmentButton;

  /// No description provided for @gradeSubmissionButton.
  ///
  /// In en, this message translates to:
  /// **'Grade'**
  String get gradeSubmissionButton;

  /// No description provided for @noPendingSubmissions.
  ///
  /// In en, this message translates to:
  /// **'No pending submissions'**
  String get noPendingSubmissions;

  /// No description provided for @gradeSubmissionFor.
  ///
  /// In en, this message translates to:
  /// **'Grade {name}'**
  String gradeSubmissionFor(String name);

  /// No description provided for @viewAnswerLabel.
  ///
  /// In en, this message translates to:
  /// **'Student answer'**
  String get viewAnswerLabel;

  /// No description provided for @gradeWorkNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Assignment name (optional)'**
  String get gradeWorkNameLabel;

  /// No description provided for @teacherAddGrade.
  ///
  /// In en, this message translates to:
  /// **'Add grade'**
  String get teacherAddGrade;

  /// No description provided for @teacherAddGradeFor.
  ///
  /// In en, this message translates to:
  /// **'Grade for {name}'**
  String teacherAddGradeFor(String name);

  /// No description provided for @teacherNoGroupsAssigned.
  ///
  /// In en, this message translates to:
  /// **'No groups assigned to you yet. Ask the administrator to assign you as a curator.'**
  String get teacherNoGroupsAssigned;

  /// No description provided for @teacherCuratorYouBadge.
  ///
  /// In en, this message translates to:
  /// **'You are the curator of this group'**
  String get teacherCuratorYouBadge;

  /// No description provided for @teacherSelectGroup.
  ///
  /// In en, this message translates to:
  /// **'Select group'**
  String get teacherSelectGroup;

  /// No description provided for @adminAddStudentToGroup.
  ///
  /// In en, this message translates to:
  /// **'Add student to group'**
  String get adminAddStudentToGroup;

  /// No description provided for @adminAllStudentsAssigned.
  ///
  /// In en, this message translates to:
  /// **'All students are already in this group'**
  String get adminAllStudentsAssigned;

  /// No description provided for @adminStudentAssignedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Student added to group'**
  String get adminStudentAssignedSuccess;

  /// No description provided for @adminStudentRemovedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Student removed from group'**
  String get adminStudentRemovedSuccess;

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

  /// No description provided for @adminGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hello, Administrator'**
  String get adminGreeting;

  /// No description provided for @adminHomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'System overview and quick access'**
  String get adminHomeSubtitle;

  /// No description provided for @adminPeopleTitle.
  ///
  /// In en, this message translates to:
  /// **'People management'**
  String get adminPeopleTitle;

  /// No description provided for @adminAcademicTitle.
  ///
  /// In en, this message translates to:
  /// **'Academic structure'**
  String get adminAcademicTitle;

  /// No description provided for @adminInsightsTitle.
  ///
  /// In en, this message translates to:
  /// **'Analytics and communications'**
  String get adminInsightsTitle;

  /// No description provided for @adminRoleBadge.
  ///
  /// In en, this message translates to:
  /// **'Administrator'**
  String get adminRoleBadge;

  /// No description provided for @adminSectionDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get adminSectionDashboard;

  /// No description provided for @adminDashHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get adminDashHome;

  /// No description provided for @adminDashSystemStats.
  ///
  /// In en, this message translates to:
  /// **'System statistics'**
  String get adminDashSystemStats;

  /// No description provided for @adminDashStudentsCount.
  ///
  /// In en, this message translates to:
  /// **'Number of students'**
  String get adminDashStudentsCount;

  /// No description provided for @adminDashTeachersCount.
  ///
  /// In en, this message translates to:
  /// **'Number of teachers'**
  String get adminDashTeachersCount;

  /// No description provided for @adminDashGroupsCount.
  ///
  /// In en, this message translates to:
  /// **'Number of groups'**
  String get adminDashGroupsCount;

  /// No description provided for @adminDashUserActivity.
  ///
  /// In en, this message translates to:
  /// **'User activity'**
  String get adminDashUserActivity;

  /// No description provided for @adminDashRecentNotifications.
  ///
  /// In en, this message translates to:
  /// **'Recent notifications'**
  String get adminDashRecentNotifications;

  /// No description provided for @adminSectionStudents.
  ///
  /// In en, this message translates to:
  /// **'Student management'**
  String get adminSectionStudents;

  /// No description provided for @adminStudentAdd.
  ///
  /// In en, this message translates to:
  /// **'Add student'**
  String get adminStudentAdd;

  /// No description provided for @adminStudentEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit student'**
  String get adminStudentEdit;

  /// No description provided for @adminStudentDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete student'**
  String get adminStudentDelete;

  /// No description provided for @adminStudentSearch.
  ///
  /// In en, this message translates to:
  /// **'Search students'**
  String get adminStudentSearch;

  /// No description provided for @adminStudentList.
  ///
  /// In en, this message translates to:
  /// **'Student list'**
  String get adminStudentList;

  /// No description provided for @adminStudentImport.
  ///
  /// In en, this message translates to:
  /// **'Import students'**
  String get adminStudentImport;

  /// No description provided for @adminStudentExport.
  ///
  /// In en, this message translates to:
  /// **'Export data'**
  String get adminStudentExport;

  /// No description provided for @adminSectionTeachers.
  ///
  /// In en, this message translates to:
  /// **'Teacher management'**
  String get adminSectionTeachers;

  /// No description provided for @adminTeacherAdd.
  ///
  /// In en, this message translates to:
  /// **'Add teacher'**
  String get adminTeacherAdd;

  /// No description provided for @adminTeacherEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit teacher'**
  String get adminTeacherEdit;

  /// No description provided for @adminTeacherDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete teacher'**
  String get adminTeacherDelete;

  /// No description provided for @adminTeacherAssignSubject.
  ///
  /// In en, this message translates to:
  /// **'Assign subject'**
  String get adminTeacherAssignSubject;

  /// No description provided for @adminTeacherList.
  ///
  /// In en, this message translates to:
  /// **'Teacher list'**
  String get adminTeacherList;

  /// No description provided for @adminTeacherSearch.
  ///
  /// In en, this message translates to:
  /// **'Search teacher'**
  String get adminTeacherSearch;

  /// No description provided for @adminSectionGroups.
  ///
  /// In en, this message translates to:
  /// **'Group management'**
  String get adminSectionGroups;

  /// No description provided for @adminGroupCreate.
  ///
  /// In en, this message translates to:
  /// **'Create group'**
  String get adminGroupCreate;

  /// No description provided for @adminGroupEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit group'**
  String get adminGroupEdit;

  /// No description provided for @adminGroupDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete group'**
  String get adminGroupDelete;

  /// No description provided for @adminGroupAddStudents.
  ///
  /// In en, this message translates to:
  /// **'Add students to group'**
  String get adminGroupAddStudents;

  /// No description provided for @adminGroupAssignCurator.
  ///
  /// In en, this message translates to:
  /// **'Assign curator'**
  String get adminGroupAssignCurator;

  /// No description provided for @adminGroupNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Group name'**
  String get adminGroupNameLabel;

  /// No description provided for @adminGroupNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter group name'**
  String get adminGroupNameRequired;

  /// No description provided for @adminGroupCreatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Group created'**
  String get adminGroupCreatedSuccess;

  /// No description provided for @adminGroupUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Group updated'**
  String get adminGroupUpdatedSuccess;

  /// No description provided for @adminGroupDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Group deleted'**
  String get adminGroupDeletedSuccess;

  /// No description provided for @adminCuratorRemovedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Curator removed from group'**
  String get adminCuratorRemovedSuccess;

  /// No description provided for @adminRemoveCurator.
  ///
  /// In en, this message translates to:
  /// **'Remove curator'**
  String get adminRemoveCurator;

  /// No description provided for @adminNoGroups.
  ///
  /// In en, this message translates to:
  /// **'No groups yet. Tap \"Create group\" to add one.'**
  String get adminNoGroups;

  /// No description provided for @adminDeleteGroupConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete group \"{name}\"? Students will be unassigned from this group.'**
  String adminDeleteGroupConfirm(String name);

  /// No description provided for @adminSectionSubjects.
  ///
  /// In en, this message translates to:
  /// **'Subject management'**
  String get adminSectionSubjects;

  /// No description provided for @adminSubjectAdd.
  ///
  /// In en, this message translates to:
  /// **'Add subject'**
  String get adminSubjectAdd;

  /// No description provided for @adminSubjectEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit subject'**
  String get adminSubjectEdit;

  /// No description provided for @adminSubjectDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete subject'**
  String get adminSubjectDelete;

  /// No description provided for @adminSubjectAssignTeacher.
  ///
  /// In en, this message translates to:
  /// **'Assign teacher'**
  String get adminSubjectAssignTeacher;

  /// No description provided for @adminSubjectList.
  ///
  /// In en, this message translates to:
  /// **'Subject list'**
  String get adminSubjectList;

  /// No description provided for @adminSectionSchedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get adminSectionSchedule;

  /// No description provided for @adminScheduleCreate.
  ///
  /// In en, this message translates to:
  /// **'Create schedule'**
  String get adminScheduleCreate;

  /// No description provided for @adminScheduleEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit schedule'**
  String get adminScheduleEdit;

  /// No description provided for @adminScheduleDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete schedule'**
  String get adminScheduleDelete;

  /// No description provided for @adminScheduleAssignRoom.
  ///
  /// In en, this message translates to:
  /// **'Assign room'**
  String get adminScheduleAssignRoom;

  /// No description provided for @adminScheduleAssignTeacher.
  ///
  /// In en, this message translates to:
  /// **'Assign teacher'**
  String get adminScheduleAssignTeacher;

  /// No description provided for @adminScheduleView.
  ///
  /// In en, this message translates to:
  /// **'View schedule'**
  String get adminScheduleView;

  /// No description provided for @adminSectionPerformance.
  ///
  /// In en, this message translates to:
  /// **'Performance'**
  String get adminSectionPerformance;

  /// No description provided for @adminPerfViewGrades.
  ///
  /// In en, this message translates to:
  /// **'View grades'**
  String get adminPerfViewGrades;

  /// No description provided for @adminPerfGpaStats.
  ///
  /// In en, this message translates to:
  /// **'GPA statistics'**
  String get adminPerfGpaStats;

  /// No description provided for @adminPerfAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Performance analytics'**
  String get adminPerfAnalytics;

  /// No description provided for @adminPerfStudentReport.
  ///
  /// In en, this message translates to:
  /// **'Student report'**
  String get adminPerfStudentReport;

  /// No description provided for @adminPerfExportReports.
  ///
  /// In en, this message translates to:
  /// **'Export reports'**
  String get adminPerfExportReports;

  /// No description provided for @adminSectionAttendance.
  ///
  /// In en, this message translates to:
  /// **'Attendance'**
  String get adminSectionAttendance;

  /// No description provided for @adminAttView.
  ///
  /// In en, this message translates to:
  /// **'View attendance'**
  String get adminAttView;

  /// No description provided for @adminAttReport.
  ///
  /// In en, this message translates to:
  /// **'Attendance report'**
  String get adminAttReport;

  /// No description provided for @adminAttAbsenceStats.
  ///
  /// In en, this message translates to:
  /// **'Absence statistics'**
  String get adminAttAbsenceStats;

  /// No description provided for @adminSectionNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get adminSectionNotifications;

  /// No description provided for @adminNotifCreate.
  ///
  /// In en, this message translates to:
  /// **'Create notification'**
  String get adminNotifCreate;

  /// No description provided for @adminNotifSendMessage.
  ///
  /// In en, this message translates to:
  /// **'Send message'**
  String get adminNotifSendMessage;

  /// No description provided for @adminNotifBulk.
  ///
  /// In en, this message translates to:
  /// **'Bulk mailing'**
  String get adminNotifBulk;

  /// No description provided for @adminNotifHistory.
  ///
  /// In en, this message translates to:
  /// **'Notification history'**
  String get adminNotifHistory;

  /// No description provided for @adminSectionSecurity.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get adminSectionSecurity;

  /// No description provided for @adminSecRoles.
  ///
  /// In en, this message translates to:
  /// **'Manage roles'**
  String get adminSecRoles;

  /// No description provided for @adminSecResetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get adminSecResetPassword;

  /// No description provided for @adminSecBlockUser.
  ///
  /// In en, this message translates to:
  /// **'Block user'**
  String get adminSecBlockUser;

  /// No description provided for @adminSecLoginHistory.
  ///
  /// In en, this message translates to:
  /// **'Login history'**
  String get adminSecLoginHistory;

  /// No description provided for @adminSecSettings.
  ///
  /// In en, this message translates to:
  /// **'Security settings'**
  String get adminSecSettings;

  /// No description provided for @teacherGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hello, Teacher'**
  String get teacherGreeting;

  /// No description provided for @teacherHomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your teaching workspace'**
  String get teacherHomeSubtitle;

  /// No description provided for @teacherTodayClasses.
  ///
  /// In en, this message translates to:
  /// **'Classes today'**
  String get teacherTodayClasses;

  /// No description provided for @teacherPendingReviews.
  ///
  /// In en, this message translates to:
  /// **'Works to review'**
  String get teacherPendingReviews;

  /// No description provided for @teacherSectionShortcuts.
  ///
  /// In en, this message translates to:
  /// **'Quick actions'**
  String get teacherSectionShortcuts;

  /// No description provided for @teacherShortcutMyGroups.
  ///
  /// In en, this message translates to:
  /// **'My groups'**
  String get teacherShortcutMyGroups;

  /// No description provided for @teacherShortcutMySchedule.
  ///
  /// In en, this message translates to:
  /// **'My schedule'**
  String get teacherShortcutMySchedule;

  /// No description provided for @teacherShortcutAssignments.
  ///
  /// In en, this message translates to:
  /// **'Assignments'**
  String get teacherShortcutAssignments;

  /// No description provided for @teacherShortcutGrades.
  ///
  /// In en, this message translates to:
  /// **'Grades'**
  String get teacherShortcutGrades;

  /// No description provided for @teacherShortcutAttendance.
  ///
  /// In en, this message translates to:
  /// **'Attendance'**
  String get teacherShortcutAttendance;

  /// No description provided for @teacherGroupsTitle.
  ///
  /// In en, this message translates to:
  /// **'My groups'**
  String get teacherGroupsTitle;

  /// No description provided for @teacherSectionMyGroups.
  ///
  /// In en, this message translates to:
  /// **'Groups'**
  String get teacherSectionMyGroups;

  /// No description provided for @teacherGroupCs101.
  ///
  /// In en, this message translates to:
  /// **'CS-101 · 28 students'**
  String get teacherGroupCs101;

  /// No description provided for @teacherGroupMath202.
  ///
  /// In en, this message translates to:
  /// **'MATH-202 · 22 students'**
  String get teacherGroupMath202;

  /// No description provided for @teacherGroupPhysicsLab.
  ///
  /// In en, this message translates to:
  /// **'PHYS-LAB · 18 students'**
  String get teacherGroupPhysicsLab;

  /// No description provided for @teacherScheduleTitle.
  ///
  /// In en, this message translates to:
  /// **'My schedule'**
  String get teacherScheduleTitle;

  /// No description provided for @teacherScheduleSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get teacherScheduleSubtitle;

  /// No description provided for @teacherScheduleItem1Time.
  ///
  /// In en, this message translates to:
  /// **'09:00 – 10:30'**
  String get teacherScheduleItem1Time;

  /// No description provided for @teacherScheduleItem1Title.
  ///
  /// In en, this message translates to:
  /// **'Higher Mathematics'**
  String get teacherScheduleItem1Title;

  /// No description provided for @teacherScheduleItem1Room.
  ///
  /// In en, this message translates to:
  /// **'Aud. 402'**
  String get teacherScheduleItem1Room;

  /// No description provided for @teacherScheduleItem2Time.
  ///
  /// In en, this message translates to:
  /// **'11:00 – 12:30'**
  String get teacherScheduleItem2Time;

  /// No description provided for @teacherScheduleItem2Title.
  ///
  /// In en, this message translates to:
  /// **'Programming workshop'**
  String get teacherScheduleItem2Title;

  /// No description provided for @teacherScheduleItem2Room.
  ///
  /// In en, this message translates to:
  /// **'Comp. lab 1'**
  String get teacherScheduleItem2Room;

  /// No description provided for @teacherScheduleItem3Time.
  ///
  /// In en, this message translates to:
  /// **'14:00 – 15:30'**
  String get teacherScheduleItem3Time;

  /// No description provided for @teacherScheduleItem3Title.
  ///
  /// In en, this message translates to:
  /// **'Physics'**
  String get teacherScheduleItem3Title;

  /// No description provided for @teacherScheduleItem3Room.
  ///
  /// In en, this message translates to:
  /// **'Aud. 210'**
  String get teacherScheduleItem3Room;

  /// No description provided for @teacherWorkTitle.
  ///
  /// In en, this message translates to:
  /// **'Teaching'**
  String get teacherWorkTitle;

  /// No description provided for @teacherSectionAssignments.
  ///
  /// In en, this message translates to:
  /// **'Assignments and grading'**
  String get teacherSectionAssignments;

  /// No description provided for @teacherAssignments.
  ///
  /// In en, this message translates to:
  /// **'Assignments'**
  String get teacherAssignments;

  /// No description provided for @teacherCheckWork.
  ///
  /// In en, this message translates to:
  /// **'Review submissions'**
  String get teacherCheckWork;

  /// No description provided for @teacherSectionGradesAttendance.
  ///
  /// In en, this message translates to:
  /// **'Grades and attendance'**
  String get teacherSectionGradesAttendance;

  /// No description provided for @teacherGrades.
  ///
  /// In en, this message translates to:
  /// **'Grades'**
  String get teacherGrades;

  /// No description provided for @teacherAttendance.
  ///
  /// In en, this message translates to:
  /// **'Attendance'**
  String get teacherAttendance;

  /// No description provided for @teacherRoleBadge.
  ///
  /// In en, this message translates to:
  /// **'Teacher'**
  String get teacherRoleBadge;

  /// No description provided for @teacherSectionMore.
  ///
  /// In en, this message translates to:
  /// **'Communication and profile'**
  String get teacherSectionMore;

  /// No description provided for @teacherMessages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get teacherMessages;

  /// No description provided for @teacherAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get teacherAnalytics;

  /// No description provided for @teacherProfileSettings.
  ///
  /// In en, this message translates to:
  /// **'Profile settings'**
  String get teacherProfileSettings;

  /// No description provided for @teacherDashOverviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Today\'s overview'**
  String get teacherDashOverviewTitle;

  /// No description provided for @teacherStatReachLabel.
  ///
  /// In en, this message translates to:
  /// **'Students (your groups)'**
  String get teacherStatReachLabel;

  /// No description provided for @teacherStatGpaLabel.
  ///
  /// In en, this message translates to:
  /// **'Avg. GPA (mock)'**
  String get teacherStatGpaLabel;

  /// No description provided for @teacherOfficeHoursLabel.
  ///
  /// In en, this message translates to:
  /// **'Office hours'**
  String get teacherOfficeHoursLabel;

  /// No description provided for @teacherLoadMockTitle.
  ///
  /// In en, this message translates to:
  /// **'Weekly teaching hours (mock)'**
  String get teacherLoadMockTitle;

  /// No description provided for @teacherFeedT1.
  ///
  /// In en, this message translates to:
  /// **'CS-101 · 8 lab submissions awaiting review'**
  String get teacherFeedT1;

  /// No description provided for @teacherFeedT2.
  ///
  /// In en, this message translates to:
  /// **'MTH-202 · Quiz graded · avg 78%'**
  String get teacherFeedT2;

  /// No description provided for @teacherFeedT3.
  ///
  /// In en, this message translates to:
  /// **'PHY-LAB · Attendance marked for today'**
  String get teacherFeedT3;

  /// No description provided for @teacherRosterPreview.
  ///
  /// In en, this message translates to:
  /// **'Roster preview (sample)'**
  String get teacherRosterPreview;

  /// No description provided for @teacherGroupSampleStu1.
  ///
  /// In en, this message translates to:
  /// **'Alex Ivanov · submitted'**
  String get teacherGroupSampleStu1;

  /// No description provided for @teacherGroupSampleStu2.
  ///
  /// In en, this message translates to:
  /// **'Maria Kim · pending'**
  String get teacherGroupSampleStu2;

  /// No description provided for @teacherGroupSampleStu3.
  ///
  /// In en, this message translates to:
  /// **'Daniyar Ospan · late'**
  String get teacherGroupSampleStu3;

  /// No description provided for @teacherGroupsNextClass.
  ///
  /// In en, this message translates to:
  /// **'Next class'**
  String get teacherGroupsNextClass;

  /// No description provided for @teacherScheduleBusyTitle.
  ///
  /// In en, this message translates to:
  /// **'Load by day (mock)'**
  String get teacherScheduleBusyTitle;

  /// No description provided for @teacherWorkDueTitle.
  ///
  /// In en, this message translates to:
  /// **'Due soon'**
  String get teacherWorkDueTitle;

  /// No description provided for @teacherMockTaskLine1.
  ///
  /// In en, this message translates to:
  /// **'Lab 4 · CS-101'**
  String get teacherMockTaskLine1;

  /// No description provided for @teacherMockTaskSub1.
  ///
  /// In en, this message translates to:
  /// **'Due tomorrow · 28 students'**
  String get teacherMockTaskSub1;

  /// No description provided for @teacherMockTaskLine2.
  ///
  /// In en, this message translates to:
  /// **'Quiz retake · MTH-202'**
  String get teacherMockTaskLine2;

  /// No description provided for @teacherMockTaskSub2.
  ///
  /// In en, this message translates to:
  /// **'In 2 days · 22 students'**
  String get teacherMockTaskSub2;

  /// No description provided for @teacherMockTaskLine3.
  ///
  /// In en, this message translates to:
  /// **'Course report · PHY-LAB'**
  String get teacherMockTaskLine3;

  /// No description provided for @teacherMockTaskSub3.
  ///
  /// In en, this message translates to:
  /// **'May 18 · 18 students'**
  String get teacherMockTaskSub3;

  /// No description provided for @teacherGradeBlockTitle.
  ///
  /// In en, this message translates to:
  /// **'Grades snapshot'**
  String get teacherGradeBlockTitle;

  /// No description provided for @teacherMockGradeLine1.
  ///
  /// In en, this message translates to:
  /// **'CS-101 · class avg 4.1'**
  String get teacherMockGradeLine1;

  /// No description provided for @teacherMockGradeLine2.
  ///
  /// In en, this message translates to:
  /// **'MTH-202 · class avg 3.7'**
  String get teacherMockGradeLine2;

  /// No description provided for @teacherAttYourGroupsTitle.
  ///
  /// In en, this message translates to:
  /// **'Attendance · your groups (mock)'**
  String get teacherAttYourGroupsTitle;

  /// No description provided for @teacherProfileQuickTitle.
  ///
  /// In en, this message translates to:
  /// **'Shortcuts'**
  String get teacherProfileQuickTitle;

  /// No description provided for @teacherGroupOpenMock.
  ///
  /// In en, this message translates to:
  /// **'Open group (mock)'**
  String get teacherGroupOpenMock;

  /// No description provided for @adminSystemOverviewTitle.
  ///
  /// In en, this message translates to:
  /// **'System overview'**
  String get adminSystemOverviewTitle;

  /// No description provided for @adminHealthGood.
  ///
  /// In en, this message translates to:
  /// **'All systems operational'**
  String get adminHealthGood;

  /// No description provided for @adminHealthMeta.
  ///
  /// In en, this message translates to:
  /// **'Last backup today · 04:32'**
  String get adminHealthMeta;

  /// No description provided for @adminMetricCpu.
  ///
  /// In en, this message translates to:
  /// **'CPU'**
  String get adminMetricCpu;

  /// No description provided for @adminMetricMemory.
  ///
  /// In en, this message translates to:
  /// **'RAM'**
  String get adminMetricMemory;

  /// No description provided for @adminMetricApi.
  ///
  /// In en, this message translates to:
  /// **'API'**
  String get adminMetricApi;

  /// No description provided for @adminActivitySection.
  ///
  /// In en, this message translates to:
  /// **'Recent activity'**
  String get adminActivitySection;

  /// No description provided for @adminFeed1.
  ///
  /// In en, this message translates to:
  /// **'New enrollment · IIT-21'**
  String get adminFeed1;

  /// No description provided for @adminFeed2.
  ///
  /// In en, this message translates to:
  /// **'Timetable published · week 14'**
  String get adminFeed2;

  /// No description provided for @adminFeed3.
  ///
  /// In en, this message translates to:
  /// **'Security scan · no issues'**
  String get adminFeed3;

  /// No description provided for @adminQuickActionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick actions'**
  String get adminQuickActionsTitle;

  /// No description provided for @adminLoadOverviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Weekly load (mock)'**
  String get adminLoadOverviewTitle;

  /// No description provided for @adminPeopleSummaryStudents.
  ///
  /// In en, this message translates to:
  /// **'Students in directory'**
  String get adminPeopleSummaryStudents;

  /// No description provided for @adminPeopleSummaryTeachers.
  ///
  /// In en, this message translates to:
  /// **'Teaching staff'**
  String get adminPeopleSummaryTeachers;

  /// No description provided for @adminTrendPositive.
  ///
  /// In en, this message translates to:
  /// **'+{value}% this month'**
  String adminTrendPositive(String value);

  /// No description provided for @adminAcademicFeaturedGroups.
  ///
  /// In en, this message translates to:
  /// **'Featured groups'**
  String get adminAcademicFeaturedGroups;

  /// No description provided for @adminMockGroup1.
  ///
  /// In en, this message translates to:
  /// **'IIT-21 · 32 students'**
  String get adminMockGroup1;

  /// No description provided for @adminMockGroup2.
  ///
  /// In en, this message translates to:
  /// **'MTH-09 · 28 students'**
  String get adminMockGroup2;

  /// No description provided for @adminMockGroup3.
  ///
  /// In en, this message translates to:
  /// **'PHY-LAB · 18 students'**
  String get adminMockGroup3;

  /// No description provided for @adminSubjectsActiveLabel.
  ///
  /// In en, this message translates to:
  /// **'Active subjects'**
  String get adminSubjectsActiveLabel;

  /// No description provided for @adminScheduleNextHint.
  ///
  /// In en, this message translates to:
  /// **'Next publish in 2 days'**
  String get adminScheduleNextHint;

  /// No description provided for @adminInsightsPassRate.
  ///
  /// In en, this message translates to:
  /// **'Pass rate'**
  String get adminInsightsPassRate;

  /// No description provided for @adminInsightsAttendance.
  ///
  /// In en, this message translates to:
  /// **'Avg. attendance'**
  String get adminInsightsAttendance;

  /// No description provided for @adminInsightsNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications (7d)'**
  String get adminInsightsNotifications;

  /// No description provided for @adminProfileSecurityScore.
  ///
  /// In en, this message translates to:
  /// **'Security score'**
  String get adminProfileSecurityScore;

  /// No description provided for @adminMockSubjectCount.
  ///
  /// In en, this message translates to:
  /// **'42 subjects'**
  String get adminMockSubjectCount;

  /// No description provided for @adminPeopleSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search by name or ID'**
  String get adminPeopleSearchHint;

  /// No description provided for @adminPeopleStudentsSample.
  ///
  /// In en, this message translates to:
  /// **'Students (sample)'**
  String get adminPeopleStudentsSample;

  /// No description provided for @adminPeopleTeachersSample.
  ///
  /// In en, this message translates to:
  /// **'Teachers (sample)'**
  String get adminPeopleTeachersSample;

  /// No description provided for @adminPeopleOpenMock.
  ///
  /// In en, this message translates to:
  /// **'Open (mock)'**
  String get adminPeopleOpenMock;

  /// No description provided for @adminMockStudentLine1.
  ///
  /// In en, this message translates to:
  /// **'Alex Ivanov · IIT-21 · 220104032'**
  String get adminMockStudentLine1;

  /// No description provided for @adminMockStudentLine2.
  ///
  /// In en, this message translates to:
  /// **'Maria Kim · MTH-09 · 220108011'**
  String get adminMockStudentLine2;

  /// No description provided for @adminMockStudentLine3.
  ///
  /// In en, this message translates to:
  /// **'Daniyar Ospan · PHY-LAB · 219902004'**
  String get adminMockStudentLine3;

  /// No description provided for @adminMockStudentLine4.
  ///
  /// In en, this message translates to:
  /// **'Sophie Lee · IIT-21 · 221001015'**
  String get adminMockStudentLine4;

  /// No description provided for @adminMockTeacherLine1.
  ///
  /// In en, this message translates to:
  /// **'Ivanov I. I. · Higher mathematics'**
  String get adminMockTeacherLine1;

  /// No description provided for @adminMockTeacherLine2.
  ///
  /// In en, this message translates to:
  /// **'Nurpeisova A. · Programming'**
  String get adminMockTeacherLine2;

  /// No description provided for @adminGroupManageTitle.
  ///
  /// In en, this message translates to:
  /// **'Group management'**
  String get adminGroupManageTitle;

  /// No description provided for @adminGroupMembers.
  ///
  /// In en, this message translates to:
  /// **'{count} members'**
  String adminGroupMembers(int count);

  /// No description provided for @adminMockCuratorShort.
  ///
  /// In en, this message translates to:
  /// **'Curator assigned'**
  String get adminMockCuratorShort;

  /// No description provided for @adminAttWeekTitle.
  ///
  /// In en, this message translates to:
  /// **'Attendance this week (mock)'**
  String get adminAttWeekTitle;

  /// No description provided for @adminAttTodayList.
  ///
  /// In en, this message translates to:
  /// **'Today (sample)'**
  String get adminAttTodayList;

  /// No description provided for @adminMockAttLine1.
  ///
  /// In en, this message translates to:
  /// **'Alex Ivanov · Present'**
  String get adminMockAttLine1;

  /// No description provided for @adminMockAttLine2.
  ///
  /// In en, this message translates to:
  /// **'Maria Kim · Late 8 min'**
  String get adminMockAttLine2;

  /// No description provided for @adminMockAttLine3.
  ///
  /// In en, this message translates to:
  /// **'Daniyar Ospan · Present'**
  String get adminMockAttLine3;

  /// No description provided for @adminMockAttLine4.
  ///
  /// In en, this message translates to:
  /// **'Sophie Lee · Absent'**
  String get adminMockAttLine4;

  /// No description provided for @profileStudentCardName.
  ///
  /// In en, this message translates to:
  /// **'Dana Karimova'**
  String get profileStudentCardName;

  /// No description provided for @profileStudentCardId.
  ///
  /// In en, this message translates to:
  /// **'220887015'**
  String get profileStudentCardId;

  /// No description provided for @profileStudentCardEmail.
  ///
  /// In en, this message translates to:
  /// **'dana.karimova@student.university.edu'**
  String get profileStudentCardEmail;

  /// No description provided for @loginDemoHint.
  ///
  /// In en, this message translates to:
  /// **'Demo: aruka@gmail.com (student), admin@student.manager (admin), teacher@student.manager (teacher) — password: password123'**
  String get loginDemoHint;
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
