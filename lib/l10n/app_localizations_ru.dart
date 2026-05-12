// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Student Manager';

  @override
  String get welcomeMessage => 'Добро пожаловать в Student Manager';

  @override
  String get email => 'Email';

  @override
  String get password => 'Пароль';

  @override
  String get forgotPassword => 'Забыли пароль?';

  @override
  String get loginButton => 'Войти';

  @override
  String get loginSuccess => 'Успешный вход!';

  @override
  String get loginError => 'Неверный email или пароль';

  @override
  String get newHere => 'Впервые здесь?';

  @override
  String get createAccount => 'Создать аккаунт';

  @override
  String get registerSubtitle => 'Заполните данные, чтобы начать работу';

  @override
  String get fullName => 'Полное имя';

  @override
  String get confirmPassword => 'Подтвердите пароль';

  @override
  String get registerButton => 'Зарегистрироваться';

  @override
  String get termsAndPrivacyDisclamer =>
      'Регистрируясь, вы соглашаетесь с условиями использования и политикой конфиденциальности.';

  @override
  String get forgetPasswordTitle => 'Восстановление пароля';

  @override
  String get forgetPasswordEnterEmail => 'Введите вашу почту';

  @override
  String get sendCodeButton => 'Отправить код';

  @override
  String get enterCodeTitle => 'Введите код';

  @override
  String codeSentTo(Object email) {
    return 'Код отправлен на $email';
  }

  @override
  String get confirmButton => 'Подтвердить';

  @override
  String get newPasswordTitle => 'Новый пароль';

  @override
  String get newPasswordSubtitle => 'Придумайте сложный пароль';

  @override
  String get newPasswordField => 'Новый пароль';

  @override
  String get repeatPasswordField => 'Повторите пароль';

  @override
  String get saveAndLogin => 'Сохранить и войти';

  @override
  String get scheduleTitle => 'Расписание';

  @override
  String get editText => 'Редактировать';

  @override
  String get deleteText => 'Удалить';

  @override
  String get newLesson => 'Новое занятие';

  @override
  String get lessonEdit => 'Редактирование';

  @override
  String get lessonSubjectLabel => 'Предмет';

  @override
  String get startLabel => 'Начало';

  @override
  String get endLabel => 'Конец';

  @override
  String get audienceLabel => 'Аудитория';

  @override
  String get saveButton => 'Сохранить';

  @override
  String get noLessonsToday => 'На этот день занятий нет';

  @override
  String get addToList => 'Добавить в список';

  @override
  String get mondayShort => 'Пн';

  @override
  String get tuesdayShort => 'Вт';

  @override
  String get wednesdayShort => 'Ср';

  @override
  String get thursdayShort => 'Чт';

  @override
  String get fridayShort => 'Пт';

  @override
  String get saturdayShort => 'Сб';

  @override
  String get upcomingLessons => 'Ближайшие занятия';

  @override
  String get seeAll => 'Все';

  @override
  String get currentTasks => 'Текущие задания';

  @override
  String get totalGPA => 'Итоговый GPA';

  @override
  String get profileTitle => 'Профиль';

  @override
  String get greeting => 'Привет, Студент! 👋';

  @override
  String get todayStudyDay => 'Сегодня отличный день для учебы';

  @override
  String labTaskNumber(Object number) {
    return 'Лабораторная №$number';
  }

  @override
  String get deadlineTomorrow => 'Срок: завтра';

  @override
  String get tasksTitle => 'Задачи';

  @override
  String get allFilter => 'Все';

  @override
  String get inProgressFilter => 'В процессе';

  @override
  String get completedFilter => 'Выполнено';

  @override
  String get newTaskTitle => 'Новая задача';

  @override
  String get whatToDoLabel => 'Что нужно сделать?';

  @override
  String deadlineLabel(Object date) {
    return 'Дедлайн: $date';
  }

  @override
  String get createTaskButton => 'Создать задачу';

  @override
  String get noTasksYet => 'Задач пока нет';

  @override
  String get doneText => 'Готово';

  @override
  String get inProgressText => 'В процессе';

  @override
  String get returnToWork => 'Вернуть в работу';

  @override
  String get startTask => 'Приступить';

  @override
  String get finishTask => 'Завершить';

  @override
  String get descriptionTitle => 'Описание';

  @override
  String get descriptionText =>
      'Необходимо выполнить задание до дедлайна. Проверьте все требования преподавателя, подготовьте необходимые материалы и убедитесь, что решение соответствует стандартам учебного заведения.';

  @override
  String get taskStatusCompleted => 'Завершено';

  @override
  String get taskStatusInProgress => 'В работе';

  @override
  String get taskStatusQueued => 'В очереди';

  @override
  String get deadlineInfo => 'Дедлайн';

  @override
  String get priorityInfo => 'Приоритет';

  @override
  String get categoryInfo => 'Категория';

  @override
  String get highPriority => 'Высокий';

  @override
  String get categoryStudy => 'Учеба';

  @override
  String get closeButton => 'Закрыть';

  @override
  String get doneButton => 'Готово';

  @override
  String get personalData => 'Личные данные';

  @override
  String get security => 'Безопасность';

  @override
  String get logOut => 'Выйти из системы';

  @override
  String get overallGpa => 'Общий GPA';

  @override
  String get topPercentage => 'Топ 5%';

  @override
  String idLabel(Object id) {
    return 'ID: $id';
  }

  @override
  String get nameLabel => 'Имя';

  @override
  String get phoneLabel => 'Телефон';

  @override
  String get lectureLabel => 'ЛЕКЦИЯ';

  @override
  String get timeLabel => 'Время';

  @override
  String get roomLabel => 'Кабинет';

  @override
  String get lessonTopic => 'Тема занятия';

  @override
  String get homework => 'Домашнее задание';

  @override
  String get professor => 'Преподаватель';

  @override
  String get homeworkItem1 => 'Решить задачи №452, 455 из сборника Демидовича.';

  @override
  String get homeworkItem2 => 'Подготовиться к коллоквиуму по первой главе.';

  @override
  String get roomAbbr => 'каб.';

  @override
  String get auditoriumAbbr => 'ауд.';

  @override
  String get labAbbr => 'Лаб.';

  @override
  String get lecture => 'Лекция';

  @override
  String get gym => 'Спортзал';

  @override
  String get compClass1 => 'Комп. класс 1';

  @override
  String get militaryBase => 'Военный корпус';

  @override
  String get subjectHistory => 'История';

  @override
  String get subjectProgramming => 'Программирование';

  @override
  String get subjectMath => 'Высшая математика';

  @override
  String get subjectPhysics => 'Физика';

  @override
  String get subjectInformatics => 'Информатика';

  @override
  String get subjectEnglish => 'Английский язык';

  @override
  String get subjectHistoryKaz => 'История Казахстана';

  @override
  String get subjectPhysicalEducation => 'Физическая культура';

  @override
  String get subjectDiscreteMath => 'Дискретная математика';

  @override
  String get subjectPython => 'Программирование на Python';

  @override
  String get subjectEconomics => 'Экономика';

  @override
  String get subjectCulturalStudies => 'Культурология';

  @override
  String get subjectStatistics => 'Статистика';

  @override
  String get subjectDatabases => 'Базы данных';

  @override
  String get subjectComputerArch => 'Архитектура компьютеров';

  @override
  String get subjectMilitary => 'Военная подготовка';

  @override
  String get time => 'Время';

  @override
  String get room => 'Кабинет';

  @override
  String get teacher => 'Преподаватель';

  @override
  String get mockLessonTopicDescription =>
      'Основы интегрального исчисления и применение определенных интегралов в физических задачах.';

  @override
  String get mockHomework1 => 'Решить задачи №452, 455 из сборника Демидовича.';

  @override
  String get mockHomework2 => 'Подготовиться к коллоквиуму по первой главе.';

  @override
  String get mockTeacherName => 'Иванов Иван Иванович';

  @override
  String get mockTeacherStatus =>
      'Профессор, доктор физико-математических наук';

  @override
  String get performanceTitle => 'Успеваемость';

  @override
  String get newSubjectTitle => 'Новый предмет';

  @override
  String get totalMarks => 'Всего оценок';

  @override
  String get averageScore => 'Средний балл';

  @override
  String get statusLabel => 'Статус';

  @override
  String get passingStatus => 'Проходной';

  @override
  String get lowStatus => 'Низкий';

  @override
  String get enterScoreTitle => 'Введите балл (0-100)';

  @override
  String get scoreExample => 'Например: 85';

  @override
  String get cancelButton => 'Отмена';

  @override
  String get addButton => 'Добавить';

  @override
  String get language => 'Язык';

  @override
  String get selectLanguage => 'Выберите язык';

  @override
  String get notification => 'Уведомления';

  @override
  String get notifications => 'Уведомления';

  @override
  String get today => 'Сегодня';

  @override
  String get yesterday => 'Вчера';

  @override
  String get math => 'Математике';

  @override
  String get physics => 'Физике';

  @override
  String get history => 'Истории';

  @override
  String get deadlineTitle => 'Дедлайн близко!';

  @override
  String get scheduleChangeTitle => 'Изменение в расписании';

  @override
  String get systemUpdateTitle => 'Системное обновление';

  @override
  String newGradeTitle(String subject) {
    return 'Новая оценка по $subject';
  }

  @override
  String newGradeSubtitle(String grade, String workName) {
    return 'Вы получили \"$grade\" за $workName';
  }

  @override
  String deadlineSubtitle(String subject) {
    return 'Завтра последний день сдачи проекта по $subject';
  }

  @override
  String scheduleChangeSubtitle(String subject, String room) {
    return 'Пара по $subject перенесена в аудиторию $room';
  }

  @override
  String systemUpdateSubtitle(String version) {
    return 'Приложение обновлено до версии $version';
  }

  @override
  String minutesAgo(int count) {
    return '$count мин. назад';
  }

  @override
  String hoursAgo(int count) {
    return '$count часа назад';
  }

  @override
  String get enterEmail => 'Введите вашу почту';

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
  String get invalidEmailFormat => 'Неверный формат почты';

  @override
  String get enterPassword => 'Введите пароль';

  @override
  String get passwordTooShort => 'Пароль слишком короткий';

  @override
  String get passwordsDoNotMatch => 'Пароли не совпадают';

  @override
  String get enterName => 'Введите ваше имя';

  @override
  String get adminGreeting => 'Здравствуйте, администратор';

  @override
  String get adminHomeSubtitle => 'Обзор системы и быстрый доступ';

  @override
  String get adminPeopleTitle => 'Управление пользователями';

  @override
  String get adminAcademicTitle => 'Учебная структура';

  @override
  String get adminInsightsTitle => 'Аналитика и коммуникации';

  @override
  String get adminRoleBadge => 'Администратор';

  @override
  String get adminSectionDashboard => 'Главная панель';

  @override
  String get adminDashHome => 'Главная';

  @override
  String get adminDashSystemStats => 'Статистика системы';

  @override
  String get adminDashStudentsCount => 'Количество студентов';

  @override
  String get adminDashTeachersCount => 'Количество преподавателей';

  @override
  String get adminDashGroupsCount => 'Количество групп';

  @override
  String get adminDashUserActivity => 'Активность пользователей';

  @override
  String get adminDashRecentNotifications => 'Последние уведомления';

  @override
  String get adminSectionStudents => 'Управление студентами';

  @override
  String get adminStudentAdd => 'Добавить студента';

  @override
  String get adminStudentEdit => 'Редактировать студента';

  @override
  String get adminStudentDelete => 'Удалить студента';

  @override
  String get adminStudentSearch => 'Поиск студентов';

  @override
  String get adminStudentList => 'Список студентов';

  @override
  String get adminStudentImport => 'Импорт студентов';

  @override
  String get adminStudentExport => 'Экспорт данных';

  @override
  String get adminSectionTeachers => 'Управление преподавателями';

  @override
  String get adminTeacherAdd => 'Добавить преподавателя';

  @override
  String get adminTeacherEdit => 'Редактировать преподавателя';

  @override
  String get adminTeacherDelete => 'Удалить преподавателя';

  @override
  String get adminTeacherAssignSubject => 'Назначить предмет';

  @override
  String get adminTeacherList => 'Список преподавателей';

  @override
  String get adminTeacherSearch => 'Поиск преподавателя';

  @override
  String get adminSectionGroups => 'Управление группами';

  @override
  String get adminGroupCreate => 'Создать группу';

  @override
  String get adminGroupEdit => 'Редактировать группу';

  @override
  String get adminGroupDelete => 'Удалить группу';

  @override
  String get adminGroupAddStudents => 'Добавить студентов в группу';

  @override
  String get adminGroupAssignCurator => 'Назначить куратора';

  @override
  String get adminSectionSubjects => 'Управление предметами';

  @override
  String get adminSubjectAdd => 'Добавить предмет';

  @override
  String get adminSubjectEdit => 'Редактировать предмет';

  @override
  String get adminSubjectDelete => 'Удалить предмет';

  @override
  String get adminSubjectAssignTeacher => 'Назначить преподавателя';

  @override
  String get adminSubjectList => 'Список предметов';

  @override
  String get adminSectionSchedule => 'Расписание';

  @override
  String get adminScheduleCreate => 'Создать расписание';

  @override
  String get adminScheduleEdit => 'Редактировать расписание';

  @override
  String get adminScheduleDelete => 'Удалить расписание';

  @override
  String get adminScheduleAssignRoom => 'Назначить аудиторию';

  @override
  String get adminScheduleAssignTeacher => 'Назначить преподавателя';

  @override
  String get adminScheduleView => 'Просмотр расписания';

  @override
  String get adminSectionPerformance => 'Успеваемость';

  @override
  String get adminPerfViewGrades => 'Просмотр оценок';

  @override
  String get adminPerfGpaStats => 'Статистика GPA';

  @override
  String get adminPerfAnalytics => 'Аналитика успеваемости';

  @override
  String get adminPerfStudentReport => 'Отчет по студентам';

  @override
  String get adminPerfExportReports => 'Экспорт отчетов';

  @override
  String get adminSectionAttendance => 'Посещаемость';

  @override
  String get adminAttView => 'Просмотр посещаемости';

  @override
  String get adminAttReport => 'Отчет посещаемости';

  @override
  String get adminAttAbsenceStats => 'Статистика пропусков';

  @override
  String get adminSectionNotifications => 'Уведомления';

  @override
  String get adminNotifCreate => 'Создать уведомление';

  @override
  String get adminNotifSendMessage => 'Отправить сообщение';

  @override
  String get adminNotifBulk => 'Массовая рассылка';

  @override
  String get adminNotifHistory => 'История уведомлений';

  @override
  String get adminSectionSecurity => 'Безопасность';

  @override
  String get adminSecRoles => 'Управление ролями';

  @override
  String get adminSecResetPassword => 'Сброс пароля';

  @override
  String get adminSecBlockUser => 'Блокировка пользователя';

  @override
  String get adminSecLoginHistory => 'История входов';

  @override
  String get adminSecSettings => 'Настройки безопасности';

  @override
  String get teacherGreeting => 'Здравствуйте, преподаватель';

  @override
  String get teacherHomeSubtitle => 'Рабочее место преподавателя';

  @override
  String get teacherTodayClasses => 'Занятий сегодня';

  @override
  String get teacherPendingReviews => 'Работ к проверке';

  @override
  String get teacherSectionShortcuts => 'Быстрые действия';

  @override
  String get teacherShortcutMyGroups => 'Мои группы';

  @override
  String get teacherShortcutMySchedule => 'Мое расписание';

  @override
  String get teacherShortcutAssignments => 'Задания';

  @override
  String get teacherShortcutGrades => 'Оценки';

  @override
  String get teacherShortcutAttendance => 'Посещаемость';

  @override
  String get teacherGroupsTitle => 'Мои группы';

  @override
  String get teacherSectionMyGroups => 'Группы';

  @override
  String get teacherGroupCs101 => 'CS-101 · 28 студентов';

  @override
  String get teacherGroupMath202 => 'MATH-202 · 22 студента';

  @override
  String get teacherGroupPhysicsLab => 'PHYS-LAB · 18 студентов';

  @override
  String get teacherScheduleTitle => 'Мое расписание';

  @override
  String get teacherScheduleSubtitle => 'Сегодня';

  @override
  String get teacherScheduleItem1Time => '09:00 – 10:30';

  @override
  String get teacherScheduleItem1Title => 'Высшая математика';

  @override
  String get teacherScheduleItem1Room => 'Ауд. 402';

  @override
  String get teacherScheduleItem2Time => '11:00 – 12:30';

  @override
  String get teacherScheduleItem2Title => 'Практикум по программированию';

  @override
  String get teacherScheduleItem2Room => 'Комп. класс 1';

  @override
  String get teacherScheduleItem3Time => '14:00 – 15:30';

  @override
  String get teacherScheduleItem3Title => 'Физика';

  @override
  String get teacherScheduleItem3Room => 'Ауд. 210';

  @override
  String get teacherWorkTitle => 'Преподавание';

  @override
  String get teacherSectionAssignments => 'Задания и проверка';

  @override
  String get teacherAssignments => 'Задания';

  @override
  String get teacherCheckWork => 'Проверка работ';

  @override
  String get teacherSectionGradesAttendance => 'Оценки и посещаемость';

  @override
  String get teacherGrades => 'Оценки';

  @override
  String get teacherAttendance => 'Посещаемость';

  @override
  String get teacherRoleBadge => 'Преподаватель';

  @override
  String get teacherSectionMore => 'Сообщения и профиль';

  @override
  String get teacherMessages => 'Сообщения';

  @override
  String get teacherAnalytics => 'Аналитика';

  @override
  String get teacherProfileSettings => 'Настройки профиля';

  @override
  String get teacherDashOverviewTitle => 'Обзор дня';

  @override
  String get teacherStatReachLabel => 'Студенты (ваши группы)';

  @override
  String get teacherStatGpaLabel => 'Средний GPA (макет)';

  @override
  String get teacherOfficeHoursLabel => 'Консультации';

  @override
  String get teacherLoadMockTitle => 'Часы за неделю (макет)';

  @override
  String get teacherFeedT1 => 'CS-101 · 8 лабораторных на проверке';

  @override
  String get teacherFeedT2 => 'MTH-202 · тест проверен · ср. 78%';

  @override
  String get teacherFeedT3 => 'PHY-LAB · посещаемость за сегодня отмечена';

  @override
  String get teacherRosterPreview => 'Состав (пример)';

  @override
  String get teacherGroupSampleStu1 => 'Алекс Иванов · сдано';

  @override
  String get teacherGroupSampleStu2 => 'Мария Ким · ожидает';

  @override
  String get teacherGroupSampleStu3 => 'Данияр Оспан · опоздал';

  @override
  String get teacherGroupsNextClass => 'Следующая пара';

  @override
  String get teacherScheduleBusyTitle => 'Загрузка по дням (макет)';

  @override
  String get teacherWorkDueTitle => 'Скоро дедлайн';

  @override
  String get teacherMockTaskLine1 => 'Лаб. 4 · CS-101';

  @override
  String get teacherMockTaskSub1 => 'Завтра · 28 студентов';

  @override
  String get teacherMockTaskLine2 => 'Пересдача · MTH-202';

  @override
  String get teacherMockTaskSub2 => 'Через 2 дня · 22 студента';

  @override
  String get teacherMockTaskLine3 => 'Отчёт · PHY-LAB';

  @override
  String get teacherMockTaskSub3 => '18 мая · 18 студентов';

  @override
  String get teacherGradeBlockTitle => 'Оценки · срез';

  @override
  String get teacherMockGradeLine1 => 'CS-101 · ср. балл 4.1';

  @override
  String get teacherMockGradeLine2 => 'MTH-202 · ср. балл 3.7';

  @override
  String get teacherAttYourGroupsTitle => 'Посещаемость · ваши группы (макет)';

  @override
  String get teacherProfileQuickTitle => 'Быстрые действия';

  @override
  String get teacherGroupOpenMock => 'Открыть группу (макет)';

  @override
  String get adminSystemOverviewTitle => 'Обзор системы';

  @override
  String get adminHealthGood => 'Все сервисы в норме';

  @override
  String get adminHealthMeta => 'Резервная копия сегодня · 04:32';

  @override
  String get adminMetricCpu => 'CPU';

  @override
  String get adminMetricMemory => 'ОЗУ';

  @override
  String get adminMetricApi => 'API';

  @override
  String get adminActivitySection => 'Последняя активность';

  @override
  String get adminFeed1 => 'Новая запись · ИИТ-21';

  @override
  String get adminFeed2 => 'Опубликовано расписание · неделя 14';

  @override
  String get adminFeed3 => 'Проверка безопасности · без замечаний';

  @override
  String get adminQuickActionsTitle => 'Быстрые действия';

  @override
  String get adminLoadOverviewTitle => 'Недельная нагрузка (макет)';

  @override
  String get adminPeopleSummaryStudents => 'Студентов в справочнике';

  @override
  String get adminPeopleSummaryTeachers => 'Преподавателей';

  @override
  String adminTrendPositive(String value) {
    return '+$value% за месяц';
  }

  @override
  String get adminAcademicFeaturedGroups => 'Группы';

  @override
  String get adminMockGroup1 => 'ИИТ-21 · 32 студента';

  @override
  String get adminMockGroup2 => 'МТН-09 · 28 студентов';

  @override
  String get adminMockGroup3 => 'ФИЗ-ЛАБ · 18 студентов';

  @override
  String get adminSubjectsActiveLabel => 'Активных предметов';

  @override
  String get adminScheduleNextHint => 'Следующая публикация через 2 дня';

  @override
  String get adminInsightsPassRate => 'Доля успеваемости';

  @override
  String get adminInsightsAttendance => 'Средняя посещаемость';

  @override
  String get adminInsightsNotifications => 'Уведомления (7 дн.)';

  @override
  String get adminProfileSecurityScore => 'Оценка безопасности';

  @override
  String get adminMockSubjectCount => '42 предмета';

  @override
  String get adminPeopleSearchHint => 'Поиск по имени или ID';

  @override
  String get adminPeopleStudentsSample => 'Студенты (пример)';

  @override
  String get adminPeopleTeachersSample => 'Преподаватели (пример)';

  @override
  String get adminPeopleOpenMock => 'Открыть (макет)';

  @override
  String get adminMockStudentLine1 => 'Алекс Иванов · ИИТ-21 · 220104032';

  @override
  String get adminMockStudentLine2 => 'Мария Ким · МТН-09 · 220108011';

  @override
  String get adminMockStudentLine3 => 'Данияр Оспан · ФИЗ-ЛАБ · 219902004';

  @override
  String get adminMockStudentLine4 => 'Софи Ли · ИИТ-21 · 221001015';

  @override
  String get adminMockTeacherLine1 => 'Иванов И. И. · Высшая математика';

  @override
  String get adminMockTeacherLine2 => 'Нурпейсова А. · Программирование';

  @override
  String get adminGroupManageTitle => 'Управление группами';

  @override
  String adminGroupMembers(int count) {
    return '$count студентов';
  }

  @override
  String get adminMockCuratorShort => 'Куратор назначен';

  @override
  String get adminAttWeekTitle => 'Посещаемость за неделю (макет)';

  @override
  String get adminAttTodayList => 'Сегодня (пример)';

  @override
  String get adminMockAttLine1 => 'Алекс Иванов · Присутствует';

  @override
  String get adminMockAttLine2 => 'Мария Ким · Опоздание 8 мин';

  @override
  String get adminMockAttLine3 => 'Данияр Оспан · Присутствует';

  @override
  String get adminMockAttLine4 => 'Софи Ли · Отсутствует';

  @override
  String get profileStudentCardName => 'Дана Каримова';

  @override
  String get profileStudentCardId => '220887015';

  @override
  String get profileStudentCardEmail => 'dana.karimova@student.university.edu';

  @override
  String get loginDemoHint =>
      'Демо: aruka@gmail.com (студент), admin@student.manager (админ), teacher@student.manager (преподаватель) — пароль: password123';
}
