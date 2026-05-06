// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class AppLocalizationsKk extends AppLocalizations {
  AppLocalizationsKk([String locale = 'kk']) : super(locale);

  @override
  String get appTitle => 'Student Manager';

  @override
  String get welcomeMessage => 'Student Manager-ге қош келдіңіз';

  @override
  String get email => 'Email';

  @override
  String get password => 'Құпия сөз';

  @override
  String get forgotPassword => 'Құпия сөзді ұмыттыңыз ба?';

  @override
  String get loginButton => 'Кіру';

  @override
  String get loginSuccess => 'Жүйеге сәтті кірдіңіз!';

  @override
  String get loginError => 'Email немесе құпия сөз қате';

  @override
  String get newHere => 'Алғаш рет пе?';

  @override
  String get createAccount => 'Тіркелу';

  @override
  String get registerSubtitle => 'Жұмысты бастау үшін деректерді толтырыңыз';

  @override
  String get fullName => 'Толық аты-жөніңіз';

  @override
  String get confirmPassword => 'Құпия сөзді растаңыз';

  @override
  String get registerButton => 'Тіркелу';

  @override
  String get termsAndPrivacyDisclamer =>
      'Тіркеле отырып, сіз пайдалану шарттарымен және құпиялылық саясатымен келісесіз.';

  @override
  String get forgetPasswordTitle => 'Құпия сөзді қалпына келтіру';

  @override
  String get forgetPasswordEnterEmail => 'Поштаңызды енгізіңіз';

  @override
  String get sendCodeButton => 'Кодты жіберу';

  @override
  String get enterCodeTitle => 'Кодты енгізіңіз';

  @override
  String codeSentTo(Object email) {
    return 'Код $email адресіне жіберілді';
  }

  @override
  String get confirmButton => 'Растау';

  @override
  String get newPasswordTitle => 'Жаңа құпия сөз';

  @override
  String get newPasswordSubtitle => 'Күрделі құпия сөз ойлап табыңыз';

  @override
  String get newPasswordField => 'Жаңа құпия сөз';

  @override
  String get repeatPasswordField => 'Құпия сөзді қайталаңыз';

  @override
  String get saveAndLogin => 'Сақтау және кіру';

  @override
  String get scheduleTitle => 'Сабақ кестесі';

  @override
  String get editText => 'Өңдеу';

  @override
  String get deleteText => 'Өшіру';

  @override
  String get newLesson => 'Жаңа сабақ';

  @override
  String get lessonEdit => 'Өңдеу';

  @override
  String get lessonSubjectLabel => 'Пән';

  @override
  String get startLabel => 'Басталуы';

  @override
  String get endLabel => 'Аяқталуы';

  @override
  String get audienceLabel => 'Аудитория';

  @override
  String get saveButton => 'Сақтау';

  @override
  String get noLessonsToday => 'Бұл күнге сабақ жоқ';

  @override
  String get addToList => 'Тізімге қосу';

  @override
  String get mondayShort => 'Дс';

  @override
  String get tuesdayShort => 'Сс';

  @override
  String get wednesdayShort => 'Ср';

  @override
  String get thursdayShort => 'Бс';

  @override
  String get fridayShort => 'Жм';

  @override
  String get saturdayShort => 'Сн';

  @override
  String get upcomingLessons => 'Жақын арадағы сабақтар';

  @override
  String get seeAll => 'Барлығы';

  @override
  String get currentTasks => 'Ағымдағы тапсырмалар';

  @override
  String get totalGPA => 'Қорытынды GPA';

  @override
  String get profileTitle => 'Профиль';

  @override
  String get greeting => 'Сәлем, Студент! 👋';

  @override
  String get todayStudyDay => 'Бүгін оқу үшін тамаша күн';

  @override
  String labTaskNumber(Object number) {
    return 'Зертханалық жұмыс №$number';
  }

  @override
  String get deadlineTomorrow => 'Мерзімі: ертең';

  @override
  String get tasksTitle => 'Тапсырмалар';

  @override
  String get allFilter => 'Барлығы';

  @override
  String get inProgressFilter => 'Орындалуда';

  @override
  String get completedFilter => 'Орындалды';

  @override
  String get newTaskTitle => 'Жаңа тапсырма';

  @override
  String get whatToDoLabel => 'Не істеу керек?';

  @override
  String deadlineLabel(Object date) {
    return 'Дедлайн: $date';
  }

  @override
  String get createTaskButton => 'Тапсырма құру';

  @override
  String get noTasksYet => 'Әзірге тапсырмалар жоқ';

  @override
  String get doneText => 'Дайын';

  @override
  String get inProgressText => 'Орындалуда';

  @override
  String get returnToWork => 'Жұмысқа қайтару';

  @override
  String get startTask => 'Бастау';

  @override
  String get finishTask => 'Аяқтау';

  @override
  String get descriptionTitle => 'Сипаттама';

  @override
  String get descriptionText =>
      'Тапсырманы дедлайнға дейін орындау қажет. Оқытушының барлық талаптарын тексеріп, қажетті материалдарды дайындаңыз және шешімнің оқу орны стандарттарына сәйкестігіне көз жеткізіңіз.';

  @override
  String get taskStatusCompleted => 'Аяқталды';

  @override
  String get taskStatusInProgress => 'Орындалуда';

  @override
  String get taskStatusQueued => 'Кезекте';

  @override
  String get deadlineInfo => 'Дедлайн';

  @override
  String get priorityInfo => 'Приоритет';

  @override
  String get categoryInfo => 'Санат';

  @override
  String get highPriority => 'Жоғары';

  @override
  String get categoryStudy => 'Оқу';

  @override
  String get closeButton => 'Жабу';

  @override
  String get doneButton => 'Дайын';

  @override
  String get personalData => 'Жеке деректер';

  @override
  String get security => 'Қауіпсіздік';

  @override
  String get logOut => 'Жүйеден шығу';

  @override
  String get overallGpa => 'Жалпы GPA';

  @override
  String get topPercentage => 'Топ 5%';

  @override
  String idLabel(Object id) {
    return 'ID: $id';
  }

  @override
  String get nameLabel => 'Есімі';

  @override
  String get phoneLabel => 'Телефон';

  @override
  String get lectureLabel => 'ДӘРІС';

  @override
  String get timeLabel => 'Уақыты';

  @override
  String get roomLabel => 'Кабинет';

  @override
  String get lessonTopic => 'Сабақ тақырыбы';

  @override
  String get homework => 'Үй тапсырмасы';

  @override
  String get professor => 'Оқытушы';

  @override
  String get homeworkItem1 => 'Демидович жинағынан №452, 455 есептерді шығару.';

  @override
  String get homeworkItem2 => 'Бірінші тарау бойынша коллоквиумға дайындалу.';

  @override
  String get roomAbbr => 'каб.';

  @override
  String get auditoriumAbbr => 'ауд.';

  @override
  String get labAbbr => 'Зерт.';

  @override
  String get lecture => 'Дәріс';

  @override
  String get gym => 'Спортзал';

  @override
  String get compClass1 => 'Комп. класс 1';

  @override
  String get militaryBase => 'Әскери корпус';

  @override
  String get subjectHistory => 'Тарих';

  @override
  String get subjectProgramming => 'Бағдарламалау';

  @override
  String get subjectMath => 'Жоғары математика';

  @override
  String get subjectPhysics => 'Физика';

  @override
  String get subjectInformatics => 'Информатика';

  @override
  String get subjectEnglish => 'Ағылшын тілі';

  @override
  String get subjectHistoryKaz => 'Қазақстан тарихы';

  @override
  String get subjectPhysicalEducation => 'Дене шынықтыру';

  @override
  String get subjectDiscreteMath => 'Дискретті математика';

  @override
  String get subjectPython => 'Python бағдарламалау';

  @override
  String get subjectEconomics => 'Экономика';

  @override
  String get subjectCulturalStudies => 'Мәдениеттану';

  @override
  String get subjectStatistics => 'Статистика';

  @override
  String get subjectDatabases => 'Мәліметтер базасы';

  @override
  String get subjectComputerArch => 'Компьютерлік архитектура';

  @override
  String get subjectMilitary => 'Әскери дайындық';

  @override
  String get time => 'Уақыты';

  @override
  String get room => 'Кабинет';

  @override
  String get teacher => 'Оқытушы';

  @override
  String get mockLessonTopicDescription =>
      'Интегралдық есептеу негіздері және физикалық есептерде анықталған интегралдарды қолдану.';

  @override
  String get mockHomework1 => 'Демидович жинағынан №452, 455 есептерді шығару.';

  @override
  String get mockHomework2 => 'Бірінші тарау бойынша коллоквиумға дайындалу.';

  @override
  String get mockTeacherName => 'Иванов Иван Иванович';

  @override
  String get mockTeacherStatus =>
      'Профессор, физика-математика ғылымдарының докторы';

  @override
  String get performanceTitle => 'Үлгерім';

  @override
  String get newSubjectTitle => 'Жаңа пән';

  @override
  String get totalMarks => 'Барлық бағалар';

  @override
  String get averageScore => 'Орташа балл';

  @override
  String get statusLabel => 'Статус';

  @override
  String get passingStatus => 'Өту балы';

  @override
  String get lowStatus => 'Төмен';

  @override
  String get enterScoreTitle => 'Баллды енгізіңіз (0-100)';

  @override
  String get scoreExample => 'Мысалы: 85';

  @override
  String get cancelButton => 'Болдырмау';

  @override
  String get addButton => 'Қосу';

  @override
  String get language => 'Тіл';

  @override
  String get selectLanguage => 'Тілді таңдаңыз';

  @override
  String get notification => 'Хабарламалар';

  @override
  String get notifications => 'Хабарландырулар';

  @override
  String get today => 'Бүгін';

  @override
  String get yesterday => 'Кеше';

  @override
  String get math => 'Математика';

  @override
  String get physics => 'Физика';

  @override
  String get history => 'Тарих';

  @override
  String get deadlineTitle => 'Тапсыру мерзімі жақын!';

  @override
  String get scheduleChangeTitle => 'Сабақ кестесіндегі өзгеріс';

  @override
  String get systemUpdateTitle => 'Жүйелік жаңарту';

  @override
  String newGradeTitle(String subject) {
    return '$subject пәнінен жаңа баға';
  }

  @override
  String newGradeSubtitle(String grade, String workName) {
    return 'Сіз $workName үшін \"$grade\" алдыңыз';
  }

  @override
  String deadlineSubtitle(String subject) {
    return 'Ертең — $subject жобасын тапсырудың соңғы күні';
  }

  @override
  String scheduleChangeSubtitle(String subject, String room) {
    return '$subject сабағы $room аудиториясына ауыстырылды';
  }

  @override
  String systemUpdateSubtitle(String version) {
    return 'Қолданба $version нұсқасына жаңартылды';
  }

  @override
  String minutesAgo(int count) {
    return '$count мин бұрын';
  }

  @override
  String hoursAgo(int count) {
    return '$count сағат бұрын';
  }

  @override
  String get enterEmail => 'Поштаны енгізіңіз';

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
  String get invalidEmailFormat => 'Почта форматы дұрыс емес';

  @override
  String get enterPassword => 'Құпия сөзді енгізіңіз';

  @override
  String get passwordTooShort => 'Құпия сөз тым қысқа';

  @override
  String get passwordsDoNotMatch => 'Құпия сөздер сәйкес келмейді';

  @override
  String get enterName => 'Аты-жөніңізді енгізіңіз';
}
