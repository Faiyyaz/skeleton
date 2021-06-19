import 'package:flutter/material.dart';
import 'package:skeleton/utilities/custom_logger.dart';

/// This class is used to perform page navigation
class NavigationService {
  /// This method removes the current page and replaces with the page pushed in the navigation stack
  Future<dynamic>? pushReplacement({
    required BuildContext context,
    required Widget widget,
    bool isFullScreenDialog = false,
  }) {
    try {
      /// The below line check if the context passed is of current screen
      if (ModalRoute.of(context)!.isCurrent) {
        return Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => widget,
            fullscreenDialog: isFullScreenDialog,
          ),
        );
      } else {
        CustomLogger.logEvent(
          loggingType: LoggingType.INFO,
          message: 'The context is not for current route check your code',
        );
        return null;
      }
    } catch (e) {
      CustomLogger.logEvent(
        loggingType: LoggingType.ERROR,
        message: e,
      );
      return null;
    }
  }

  /// This method adds the page to the current navigation stack
  Future<dynamic>? push({
    required BuildContext context,
    required Widget widget,
    bool isFullScreenDialog = false,
  }) {
    try {
      /// The below line check if the context passed is of current screen
      if (ModalRoute.of(context)!.isCurrent) {
        return Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => widget,
            fullscreenDialog: isFullScreenDialog,
          ),
        );
      } else {
        CustomLogger.logEvent(
          loggingType: LoggingType.INFO,
          message: 'The context is not for current route check your code',
        );
        return null;
      }
    } catch (e) {
      CustomLogger.logEvent(
        loggingType: LoggingType.ERROR,
        message: e,
      );
      return null;
    }
  }

  /// This method adds the page after clearing the navigation stack
  Future<dynamic>? pushAndClearStack({
    required BuildContext context,
    required Widget widget,
  }) {
    try {
      /// The below line check if the context passed is of current screen
      if (ModalRoute.of(context)!.isCurrent) {
        return Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (ctx) => widget,
          ),
          (Route<dynamic> route) => false,
        );
      } else {
        CustomLogger.logEvent(
          loggingType: LoggingType.INFO,
          message: 'The context is not for current route check your code',
        );
        return null;
      }
    } catch (e) {
      CustomLogger.logEvent(
        loggingType: LoggingType.ERROR,
        message: e,
      );
      return null;
    }
  }

  /// This method adds the page (using its name) to the current navigation stack
  Future<dynamic>? pushNamed({
    required BuildContext context,
    required String routeName,
    dynamic arguments,
  }) {
    try {
      /// The below line check if the context passed is of current screen
      if (ModalRoute.of(context)!.isCurrent) {
        return Navigator.of(context).pushNamed(
          routeName,
          arguments: arguments,
        );
      } else {
        CustomLogger.logEvent(
          loggingType: LoggingType.INFO,
          message: 'The context is not for current route check your code',
        );
        return null;
      }
    } catch (e) {
      CustomLogger.logEvent(
        loggingType: LoggingType.ERROR,
        message: e,
      );
      return null;
    }
  }

  Future<dynamic>? pushReplacementNamed({
    required BuildContext context,
    required String routeName,
    dynamic arguments,
  }) {
    try {
      /// The below line check if the context passed is of current screen
      if (ModalRoute.of(context)!.isCurrent) {
        return Navigator.of(context).pushReplacementNamed(
          routeName,
          arguments: arguments,
        );
      } else {
        CustomLogger.logEvent(
          loggingType: LoggingType.INFO,
          message: 'The context is not for current route check your code',
        );
        return null;
      }
    } catch (e) {
      CustomLogger.logEvent(
        loggingType: LoggingType.ERROR,
        message: e,
      );
      return null;
    }
  }

  /// This method adds the page (using its name) after clearing the navigation stack
  Future<dynamic>? pushNamedAndClearStack({
    required BuildContext context,
    required String routeName,
    dynamic arguments,
  }) {
    try {
      /// The below line check if the context passed is of current screen
      if (ModalRoute.of(context)!.isCurrent) {
        return Navigator.of(context).pushNamedAndRemoveUntil(
          routeName,
          (Route<dynamic> route) => false,
          arguments: arguments,
        );
      } else {
        CustomLogger.logEvent(
          loggingType: LoggingType.INFO,
          message: 'The context is not for current route check your code',
        );
        return null;
      }
    } catch (e) {
      CustomLogger.logEvent(
        loggingType: LoggingType.ERROR,
        message: e,
      );
      return null;
    }
  }

  /// This method adds the page (using its name) without animation in the navigation stack
  Future<dynamic>? pushWithoutAnimation({
    required BuildContext context,
    required Widget widget,
  }) {
    try {
      /// The below line check if the context passed is of current screen
      if (ModalRoute.of(context)!.isCurrent) {
        return Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => widget,
          ),
        );
      } else {
        CustomLogger.logEvent(
          loggingType: LoggingType.INFO,
          message: 'The context is not for current route check your code',
        );
        return null;
      }
    } catch (e) {
      CustomLogger.logEvent(
        loggingType: LoggingType.ERROR,
        message: e,
      );
      return null;
    }
  }

  /// This method adds the page (using its name) without animation after clearing the navigation stack
  Future<dynamic>? pushReplacementWithoutAnimation({
    required BuildContext context,
    required Widget widget,
  }) {
    try {
      /// The below line check if the context passed is of current screen
      if (ModalRoute.of(context)!.isCurrent) {
        return Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => widget,
          ),
        );
      } else {
        CustomLogger.logEvent(
          loggingType: LoggingType.INFO,
          message: 'The context is not for current route check your code',
        );
        return null;
      }
    } catch (e) {
      CustomLogger.logEvent(
        loggingType: LoggingType.ERROR,
        message: e,
      );
      return null;
    }
  }

  /// This method check whether there is any page to go back or not
  bool canGoBack({
    required BuildContext context,
  }) {
    try {
      /// The below line check if the context passed is of current screen
      if (ModalRoute.of(context)!.isCurrent) {
        return Navigator.of(context).canPop();
      } else {
        CustomLogger.logEvent(
          loggingType: LoggingType.INFO,
          message: 'The context is not for current route check your code',
        );
        return false;
      }
    } catch (e) {
      CustomLogger.logEvent(
        loggingType: LoggingType.ERROR,
        message: e,
      );
      return false;
    }
  }

  /// This method pop the current page and go one page back
  void goBack({
    required BuildContext context,
  }) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  /// This method pop the current page with some data
  void goBackWithData({
    required BuildContext context,
    required dynamic data,
  }) {
    try {
      /// The below line check if the context passed is of current screen
      if (ModalRoute.of(context)!.isCurrent) {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop(data);
        }
      } else {
        CustomLogger.logEvent(
          loggingType: LoggingType.INFO,
          message: 'The context is not for current route check your code',
        );
      }
    } catch (e) {
      CustomLogger.logEvent(
        loggingType: LoggingType.ERROR,
        message: e,
      );
    }
  }
}

enum NavigationType {
  PUSH_REPLACEMENT,
  PUSH,
  PUSH_CLEAR_STACK,
  PUSH_REPLACEMENT_NAMED,
  PUSH_NAMED,
  PUSH_CLEAR_STACK_NAMED,
  PUSH_WITHOUT_ANIMATION,
  PUSH_REPLACEMENT_WITHOUT_ANIMATION,
  GO_BACK,
  GO_BACK_WITH_DATA,
}
