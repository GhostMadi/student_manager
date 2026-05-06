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
}
