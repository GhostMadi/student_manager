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
  String get registerSuccess => 'Аккаунт сәтті жасалды!';

  @override
  String get registerError => 'Аккаунт жасау мүмкін болмады';

  @override
  String get resetEmailSent =>
      'Құпия сөзді қалпына келтіру хаты жіберілді. Поштаны тексеріңіз.';

  @override
  String get resetEmailSpamHint =>
      'Хат 2–3 минут ішінде келмесе, Спам/Жарнама қалталарын тексеріңіз. Жіберуші: noreply@*.firebaseapp.com. Тіркелген email-ді қолданыңыз.';

  @override
  String get resetEmailSuccessTitle => 'Поштаны тексеріңіз';

  @override
  String resetEmailSuccessMessage(String email) {
    return 'Құпия сөзді қалпына келтіру сілтемесін $email адресіне жібердік. Хатты ашып, жаңа құпия сөзді орнатыңыз.';
  }

  @override
  String get backToLogin => 'Кіруге оралу';

  @override
  String get resetCodeHint =>
      'Хаттағы сілтемеден қалпына келтіру кодын қойыңыз';

  @override
  String get resetCodeLabel => 'Қалпына келтіру коды';

  @override
  String get passwordResetSuccess => 'Құпия сөз сәтті жаңартылды!';

  @override
  String get invalidResetCode => 'Қате немесе мерзімі өткен код';

  @override
  String get emailAlreadyInUse => 'Бұл email тіркелген';

  @override
  String get emailAlreadyInUseOtherPassword =>
      'Бұл email басқа құпия сөзбен тіркелген. Дұрыс құпия сөзді енгізіңіз немесе басқа email қолданыңыз.';

  @override
  String get cannotModifyAdmin => 'Әкімші есебін өзгертуге болмайды.';

  @override
  String get userNotFound => 'Бұл email бойынша аккаунт табылмады';

  @override
  String get authGenericError => 'Бірдеңе дұрыс болмады. Қайта көріңіз.';

  @override
  String get createAdminButton => 'Әкімшіні жасау';

  @override
  String get adminCreatedSuccess => 'Әкімші аккаунты сәтті жасалды';

  @override
  String get adminAlreadyExists =>
      'Әкімші бар. Тек бір әкімшіге рұқсат етіледі.';

  @override
  String get adminUserAddedSuccess => 'Пайдаланушы жасалды';

  @override
  String get adminCuratorAssignedSuccess => 'Куратор топқа тағайындалды';

  @override
  String get adminNoStudents => 'Студенттер жоқ';

  @override
  String get adminNoTeachers => 'Кураторлар жоқ';

  @override
  String get adminAddStudentTitle => 'Студент қосу';

  @override
  String get adminAddCuratorTitle => 'Куратор қосу';

  @override
  String get adminSelectCuratorTitle => 'Кураторды таңдаңыз';

  @override
  String get adminCuratorNotAssigned => 'Куратор тағайындалмаған';

  @override
  String get adminDefaultPasswordHint => 'Әдепкі құпия сөз: Student123!';

  @override
  String get profileNotFound =>
      'Пайдаланушы профилі табылмады. Әкімшіге хабарласыңыз.';

  @override
  String get firestorePermissionDenied =>
      'Firestore қолжетімділігі жоқ. Firebase ережелерін тексеріп, жариялаңыз.';

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
  String get noGradesYet =>
      'Бағалар әлі жоқ. Оқытушы тапсырмаларды тексергеннен кейін қояды.';

  @override
  String get gradeAddedSuccess => 'Баға сақталды';

  @override
  String get assignmentsTitle => 'Тапсырмалар';

  @override
  String get studentNoGroupAssigned => 'Сіз әлі топқа қосылмағансыз';

  @override
  String get noAssignmentsYet => 'Тапсырмалар әлі жоқ';

  @override
  String get submissionGraded => 'Бағаланды';

  @override
  String get submissionSubmitted => 'Тапсырылды';

  @override
  String get submissionDraft => 'Тапсырылмаған';

  @override
  String get workSubmittedSuccess => 'Жұмыс сәтті жіберілді';

  @override
  String get noDescription => 'Сипаттama жоқ';

  @override
  String get teacherFeedback => 'Оқытушы пікірі';

  @override
  String get yourAnswerLabel => 'Сіздің жауабыңыз';

  @override
  String get submitWorkButton => 'Жұмысты тапсыру';

  @override
  String get emptyAnswerError => 'Жауапты енгізіңіз';

  @override
  String get teacherCreateAssignmentTitle => 'Тапсырма жасау';

  @override
  String get teacherPendingSubmissionsTitle => 'Тексерудегі жұмыстар';

  @override
  String get assignmentCreatedSuccess => 'Тапсырма жасалды';

  @override
  String get assignmentTitleLabel => 'Тапсырма атауы';

  @override
  String get assignmentDescriptionLabel => 'Сипаттама';

  @override
  String get assignmentDueDateLabel => 'Мерзімі';

  @override
  String get feedbackLabel => 'Пікір';

  @override
  String get createAssignmentButton => 'Тапсырма жасау';

  @override
  String get gradeSubmissionButton => 'Баға қою';

  @override
  String get noPendingSubmissions => 'Тексерудегі жұмыстар жоқ';

  @override
  String gradeSubmissionFor(String name) {
    return '$name үшін баға';
  }

  @override
  String get viewAnswerLabel => 'Студент жауабы';

  @override
  String get gradeWorkNameLabel => 'Тапсырма атауы (міндетті емес)';

  @override
  String get teacherAddGrade => 'Баға қою';

  @override
  String teacherAddGradeFor(String name) {
    return '$name үшін баға';
  }

  @override
  String get teacherNoGroupsAssigned =>
      'Сізге топтар тағайындалмаған. Әкімшіден куратор ретінде тағайындауды сұраңыз.';

  @override
  String get teacherCuratorYouBadge => 'Сіз осы топтың кураторысыз';

  @override
  String get teacherSelectGroup => 'Топты таңдаңыз';

  @override
  String get adminAddStudentToGroup => 'Топқа студент қосу';

  @override
  String get adminAllStudentsAssigned => 'Барлық студенттер осы топта';

  @override
  String get adminStudentAssignedSuccess => 'Студент топқа қосылды';

  @override
  String get adminStudentRemovedSuccess => 'Студент топтан алынды';

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
  String get enterCode => 'Поштаңызға жіберілген кодты енгізіңіз';

  @override
  String get enterNewPassword => 'Жаңа құпия сөзді енгізіңіз';

  @override
  String get confirmNewPassword => 'Жаңа құпия сөзді растаңыз';

  @override
  String get sendCode => 'Кодты жіберу';

  @override
  String get confirm => 'Растау';

  @override
  String get emailValidationError => 'Дұрыс email енгізіңіз';

  @override
  String get passwordValidationError =>
      'Құпия сөз кемінде 8 таңбадан тұруы және сандар мен арнайы таңбаларды қамтуы керек';

  @override
  String get confirmPasswordValidationError => 'Құпия сөздер сәйкес келмейді';

  @override
  String get fullNameValidationError => 'Толық аты-жөніңізді енгізіңіз';

  @override
  String get unexpectedError =>
      'Күтпеген қате орын алды. Кейінірек қайталап көріңіз.';

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

  @override
  String get adminGreeting => 'Сәлеметсіз бе, әкімші';

  @override
  String get adminHomeSubtitle => 'Жүйенің шолуы және жылдам қол жеткізу';

  @override
  String get adminPeopleTitle => 'Пайдаланушыларды басқару';

  @override
  String get adminAcademicTitle => 'Оқу құрылымы';

  @override
  String get adminInsightsTitle => 'Талдау және байланыс';

  @override
  String get adminRoleBadge => 'Әкімші';

  @override
  String get adminSectionDashboard => 'Басты панель';

  @override
  String get adminDashHome => 'Басты бет';

  @override
  String get adminDashSystemStats => 'Жүйе статистикасы';

  @override
  String get adminDashStudentsCount => 'Студенттер саны';

  @override
  String get adminDashTeachersCount => 'Оқытушылар саны';

  @override
  String get adminDashGroupsCount => 'Топтар саны';

  @override
  String get adminDashUserActivity => 'Пайдаланушылар белсенділігі';

  @override
  String get adminDashRecentNotifications => 'Соңғы хабарландырулар';

  @override
  String get adminSectionStudents => 'Студенттерді басқару';

  @override
  String get adminStudentAdd => 'Студент қосу';

  @override
  String get adminStudentEdit => 'Студентті өңдеу';

  @override
  String get adminStudentDelete => 'Студентті жою';

  @override
  String get adminStudentSearch => 'Студенттерді іздеу';

  @override
  String get adminStudentList => 'Студенттер тізімі';

  @override
  String get adminStudentImport => 'Студенттерді импорттау';

  @override
  String get adminStudentExport => 'Деректерді экспорттау';

  @override
  String get adminSectionTeachers => 'Оқытушыларды басқару';

  @override
  String get adminTeacherAdd => 'Оқытушы қосу';

  @override
  String get adminTeacherEdit => 'Оқытушыны өңдеу';

  @override
  String get adminTeacherDelete => 'Оқытушыны жою';

  @override
  String get adminTeacherAssignSubject => 'Пән тағайындау';

  @override
  String get adminTeacherList => 'Оқытушылар тізімі';

  @override
  String get adminTeacherSearch => 'Оқытушыны іздеу';

  @override
  String get adminSectionGroups => 'Топтарды басқару';

  @override
  String get adminGroupCreate => 'Топ құру';

  @override
  String get adminGroupEdit => 'Топты өңдеу';

  @override
  String get adminGroupDelete => 'Топты жою';

  @override
  String get adminGroupAddStudents => 'Топқа студент қосу';

  @override
  String get adminGroupAssignCurator => 'Куратор тағайындау';

  @override
  String get adminGroupNameLabel => 'Топ атауы';

  @override
  String get adminGroupNameRequired => 'Топ атауын енгізіңіз';

  @override
  String get adminGroupCreatedSuccess => 'Топ құрылды';

  @override
  String get adminGroupUpdatedSuccess => 'Топ жаңартылды';

  @override
  String get adminGroupDeletedSuccess => 'Топ жойылды';

  @override
  String get adminCuratorRemovedSuccess => 'Куратор топтан алынды';

  @override
  String get adminRemoveCurator => 'Кураторды алу';

  @override
  String get adminNoGroups => 'Топтар әлі жоқ. «Топ құру» батырмасын басыңыз.';

  @override
  String adminDeleteGroupConfirm(String name) {
    return '«$name» тобын жою керек пе? Студенттер топтан босатылады.';
  }

  @override
  String get adminSectionSubjects => 'Пәндерді басқару';

  @override
  String get adminSubjectAdd => 'Пән қосу';

  @override
  String get adminSubjectEdit => 'Пәнді өңдеу';

  @override
  String get adminSubjectDelete => 'Пәнді жою';

  @override
  String get adminSubjectAssignTeacher => 'Оқытушы тағайындау';

  @override
  String get adminSubjectList => 'Пәндер тізімі';

  @override
  String get adminSectionSchedule => 'Сабақ кестесі';

  @override
  String get adminScheduleCreate => 'Кесте құру';

  @override
  String get adminScheduleEdit => 'Кестені өңдеу';

  @override
  String get adminScheduleDelete => 'Кестені жою';

  @override
  String get adminScheduleAssignRoom => 'Аудитория тағайындау';

  @override
  String get adminScheduleAssignTeacher => 'Оқытушы тағайындау';

  @override
  String get adminScheduleView => 'Кестені қарау';

  @override
  String get adminSectionPerformance => 'Оқу үлгерімі';

  @override
  String get adminPerfViewGrades => 'Бағаларды қарау';

  @override
  String get adminPerfGpaStats => 'GPA статистикасы';

  @override
  String get adminPerfAnalytics => 'Оқу үлгерімі талдауы';

  @override
  String get adminPerfStudentReport => 'Студенттер бойынша есеп';

  @override
  String get adminPerfExportReports => 'Есептерді экспорттау';

  @override
  String get adminSectionAttendance => 'Қатысу';

  @override
  String get adminAttView => 'Қатысуды қарау';

  @override
  String get adminAttReport => 'Қатысу есебі';

  @override
  String get adminAttAbsenceStats => 'Қатыспау статистикасы';

  @override
  String get adminSectionNotifications => 'Хабарландырулар';

  @override
  String get adminNotifCreate => 'Хабарландыру құру';

  @override
  String get adminNotifSendMessage => 'Хабарлама жіберу';

  @override
  String get adminNotifBulk => 'Жаппай жіберу';

  @override
  String get adminNotifHistory => 'Хабарландыру тарихы';

  @override
  String get adminSectionSecurity => 'Қауіпсіздік';

  @override
  String get adminSecRoles => 'Рөлдерді басқару';

  @override
  String get adminSecResetPassword => 'Құпия сөзді қалпына келтіру';

  @override
  String get adminSecBlockUser => 'Пайдаланушыны бұғаттау';

  @override
  String get adminSecLoginHistory => 'Кіру тарихы';

  @override
  String get adminSecSettings => 'Қауіпсіздік баптаулары';

  @override
  String get teacherGreeting => 'Сәлеметсіз бе, оқытушы';

  @override
  String get teacherHomeSubtitle => 'Оқытушы жұмыс орны';

  @override
  String get teacherTodayClasses => 'Бүгінгі сабақтар';

  @override
  String get teacherPendingReviews => 'Тексерілетін жұмыстар';

  @override
  String get teacherSectionShortcuts => 'Жылдам әрекеттер';

  @override
  String get teacherShortcutMyGroups => 'Менің топтарым';

  @override
  String get teacherShortcutMySchedule => 'Менің кестем';

  @override
  String get teacherShortcutAssignments => 'Тапсырмалар';

  @override
  String get teacherShortcutGrades => 'Бағалар';

  @override
  String get teacherShortcutAttendance => 'Қатысу';

  @override
  String get teacherGroupsTitle => 'Менің топтарым';

  @override
  String get teacherSectionMyGroups => 'Топтар';

  @override
  String get teacherGroupCs101 => 'CS-101 · 28 студент';

  @override
  String get teacherGroupMath202 => 'MATH-202 · 22 студент';

  @override
  String get teacherGroupPhysicsLab => 'PHYS-LAB · 18 студент';

  @override
  String get teacherScheduleTitle => 'Менің кестем';

  @override
  String get teacherScheduleSubtitle => 'Бүгін';

  @override
  String get teacherScheduleItem1Time => '09:00 – 10:30';

  @override
  String get teacherScheduleItem1Title => 'Жоғары математика';

  @override
  String get teacherScheduleItem1Room => 'Ауд. 402';

  @override
  String get teacherScheduleItem2Time => '11:00 – 12:30';

  @override
  String get teacherScheduleItem2Title => 'Бағдарламалау семинары';

  @override
  String get teacherScheduleItem2Room => 'Комп. сынып 1';

  @override
  String get teacherScheduleItem3Time => '14:00 – 15:30';

  @override
  String get teacherScheduleItem3Title => 'Физика';

  @override
  String get teacherScheduleItem3Room => 'Ауд. 210';

  @override
  String get teacherWorkTitle => 'Оқыту';

  @override
  String get teacherSectionAssignments => 'Тапсырмалар және тексеру';

  @override
  String get teacherAssignments => 'Тапсырмалар';

  @override
  String get teacherCheckWork => 'Жұмыстарды тексеру';

  @override
  String get teacherSectionGradesAttendance => 'Бағалар және қатысу';

  @override
  String get teacherGrades => 'Бағалар';

  @override
  String get teacherAttendance => 'Қатысу';

  @override
  String get teacherRoleBadge => 'Оқытушы';

  @override
  String get teacherSectionMore => 'Хабарламалар және профиль';

  @override
  String get teacherMessages => 'Хабарламалар';

  @override
  String get teacherAnalytics => 'Талдау';

  @override
  String get teacherProfileSettings => 'Профиль баптаулары';

  @override
  String get teacherDashOverviewTitle => 'Бүгінгі шолу';

  @override
  String get teacherStatReachLabel => 'Студенттер (сіздің топтарыңыз)';

  @override
  String get teacherStatGpaLabel => 'Орта GPA (макет)';

  @override
  String get teacherOfficeHoursLabel => 'Кеңес сағаттары';

  @override
  String get teacherLoadMockTitle => 'Апталық сабақ сағаттары (макет)';

  @override
  String get teacherFeedT1 => 'CS-101 · 8 зертханалық тексеруде';

  @override
  String get teacherFeedT2 => 'MTH-202 · тест тексерілді · орта 78%';

  @override
  String get teacherFeedT3 => 'PHY-LAB · бүгінгі қатысу белгіленді';

  @override
  String get teacherRosterPreview => 'Тізім (мысал)';

  @override
  String get teacherGroupSampleStu1 => 'Алекс Иванов · тапсырды';

  @override
  String get teacherGroupSampleStu2 => 'Мария Ким · күтуде';

  @override
  String get teacherGroupSampleStu3 => 'Данияр Оспан · кешікті';

  @override
  String get teacherGroupsNextClass => 'Келесі сабақ';

  @override
  String get teacherScheduleBusyTitle => 'Күн бойынша жүктеме (макет)';

  @override
  String get teacherWorkDueTitle => 'Мерзімі жақын';

  @override
  String get teacherMockTaskLine1 => 'Зертх. 4 · CS-101';

  @override
  String get teacherMockTaskSub1 => 'Ертең · 28 студент';

  @override
  String get teacherMockTaskLine2 => 'Қайта тест · MTH-202';

  @override
  String get teacherMockTaskSub2 => '2 күннен кейін · 22 студент';

  @override
  String get teacherMockTaskLine3 => 'Курс есебі · PHY-LAB';

  @override
  String get teacherMockTaskSub3 => '18 мамыр · 18 студент';

  @override
  String get teacherGradeBlockTitle => 'Бағалар · қысқаша';

  @override
  String get teacherMockGradeLine1 => 'CS-101 · топ орт. 4.1';

  @override
  String get teacherMockGradeLine2 => 'MTH-202 · топ орт. 3.7';

  @override
  String get teacherAttYourGroupsTitle => 'Қатысу · сіздің топтарыңыз (макет)';

  @override
  String get teacherProfileQuickTitle => 'Жылдам әрекеттер';

  @override
  String get teacherGroupOpenMock => 'Топты ашу (макет)';

  @override
  String get adminSystemOverviewTitle => 'Жүйе шолуы';

  @override
  String get adminHealthGood => 'Барлық қызметтер дайын';

  @override
  String get adminHealthMeta => 'Соңғы сақтық көшірме бүгін · 04:32';

  @override
  String get adminMetricCpu => 'CPU';

  @override
  String get adminMetricMemory => 'ЖЖҚ';

  @override
  String get adminMetricApi => 'API';

  @override
  String get adminActivitySection => 'Соңғы белсенділік';

  @override
  String get adminFeed1 => 'Жаңа тіркелу · АТ-21';

  @override
  String get adminFeed2 => 'Сабақ кестесі жарияланды · 14 апта';

  @override
  String get adminFeed3 => 'Қауіпсіздік тексеруі · мәселе жоқ';

  @override
  String get adminQuickActionsTitle => 'Жылдам әрекеттер';

  @override
  String get adminLoadOverviewTitle => 'Апталық жүктеме (макет)';

  @override
  String get adminPeopleSummaryStudents => 'Анықтамалықтағы студенттер';

  @override
  String get adminPeopleSummaryTeachers => 'Оқытушылар';

  @override
  String adminTrendPositive(String value) {
    return 'Осы айда +$value%';
  }

  @override
  String get adminAcademicFeaturedGroups => 'Топтар';

  @override
  String get adminMockGroup1 => 'АТ-21 · 32 студент';

  @override
  String get adminMockGroup2 => 'МТ-09 · 28 студент';

  @override
  String get adminMockGroup3 => 'ФИЗ-ЛАБ · 18 студент';

  @override
  String get adminSubjectsActiveLabel => 'Белсенді пәндер';

  @override
  String get adminScheduleNextHint => 'Келесі жариялау 2 күннен кейін';

  @override
  String get adminInsightsPassRate => 'Сәтті оқу үлесі';

  @override
  String get adminInsightsAttendance => 'Орташа қатысу';

  @override
  String get adminInsightsNotifications => 'Хабарландырулар (7 күн)';

  @override
  String get adminProfileSecurityScore => 'Қауіпсіздік бағасы';

  @override
  String get adminMockSubjectCount => '42 пән';

  @override
  String get adminPeopleSearchHint => 'Аты немесе ID бойынша іздеу';

  @override
  String get adminPeopleStudentsSample => 'Студенттер (мысал)';

  @override
  String get adminPeopleTeachersSample => 'Оқытушылар (мысал)';

  @override
  String get adminPeopleOpenMock => 'Ашу (макет)';

  @override
  String get adminMockStudentLine1 => 'Алекс Иванов · АТ-21 · 220104032';

  @override
  String get adminMockStudentLine2 => 'Мария Ким · МТ-09 · 220108011';

  @override
  String get adminMockStudentLine3 => 'Данияр Оспан · ФИЗ-ЛАБ · 219902004';

  @override
  String get adminMockStudentLine4 => 'Софи Ли · АТ-21 · 221001015';

  @override
  String get adminMockTeacherLine1 => 'Иванов И. И. · Жоғары математика';

  @override
  String get adminMockTeacherLine2 => 'Нұрпейісова А. · Бағдарламалау';

  @override
  String get adminGroupManageTitle => 'Топтарды басқару';

  @override
  String adminGroupMembers(int count) {
    return '$count студент';
  }

  @override
  String get adminMockCuratorShort => 'Куратор тағайындалған';

  @override
  String get adminAttWeekTitle => 'Апталық қатысу (макет)';

  @override
  String get adminAttTodayList => 'Бүгін (мысал)';

  @override
  String get adminMockAttLine1 => 'Алекс Иванов · Қатысты';

  @override
  String get adminMockAttLine2 => 'Мария Ким · 8 мин кешікті';

  @override
  String get adminMockAttLine3 => 'Данияр Оспан · Қатысты';

  @override
  String get adminMockAttLine4 => 'Софи Ли · Қатыспады';

  @override
  String get profileStudentCardName => 'Дана Каримова';

  @override
  String get profileStudentCardId => '220887015';

  @override
  String get profileStudentCardEmail => 'dana.karimova@student.university.edu';

  @override
  String get loginDemoHint =>
      'Демо: aruka@gmail.com (студент), admin@student.manager (әкімші), teacher@student.manager (оқытушы) — құпия сөз: password123';
}
