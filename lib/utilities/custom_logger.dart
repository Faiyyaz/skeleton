import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart' as foundation;

class CustomLogger {
  static void logEvent({
    required LoggingType loggingType,
    required dynamic message,
  }) {
    /// Here we are allowing logs only in debug mode
    if (foundation.kDebugMode) {
      Logger logger = Logger();
      switch (loggingType) {
        case LoggingType.VERBOSE:
          logger.v(message);
          break;
        case LoggingType.DEBUG:
          logger.d(message);
          break;
        case LoggingType.INFO:
          logger.i(message);
          break;
        case LoggingType.WARNING:
          logger.w(message);
          break;
        case LoggingType.ERROR:
          logger.e(message);
          break;
      }
    }
  }
}

enum LoggingType {
  VERBOSE,
  DEBUG,
  INFO,
  WARNING,
  ERROR,
}
