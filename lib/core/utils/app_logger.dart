import 'dart:developer' as developer;

class AppLogger {
  static void info(String tag, String message) {
    developer.log(message, name: tag);
  }

  static void error(
    String tag,
    String message, [
    Object? error,
    StackTrace? stackTrace,
  ]) {
    developer.log(
      message,
      name: tag,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
