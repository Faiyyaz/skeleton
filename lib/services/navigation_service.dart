import 'package:flutter/material.dart';

/// This class is used to perform page navigation
class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// This method removes the current page and replaces with the page pushed in the navigation stack
  Future<dynamic> pushReplacement({
    @required Widget widget,
    bool isFullScreenDialog = false,
  }) {
    return navigatorKey.currentState.pushReplacement(
      MaterialPageRoute(
        builder: (_) => widget,
        fullscreenDialog: isFullScreenDialog,
      ),
    );
  }

  /// This method adds the page to the current navigation stack
  Future<dynamic> push({
    @required Widget widget,
    bool isFullScreenDialog = false,
  }) {
    return navigatorKey.currentState.push(
      MaterialPageRoute(
        builder: (_) => widget,
        fullscreenDialog: isFullScreenDialog,
      ),
    );
  }

  /// This method adds the page after clearing the navigation stack
  Future<dynamic> pushAndClearStack({
    @required Widget widget,
  }) {
    return navigatorKey.currentState.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (ctx) => widget,
      ),
      (Route<dynamic> route) => false,
    );
  }

  /// This method adds the page (using its name) to the current navigation stack
  Future<dynamic> pushNamed({
    @required String routeName,
    dynamic arguments,
  }) {
    return navigatorKey.currentState.pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  Future<dynamic> pushReplacementNamed({
    @required String routeName,
    dynamic arguments,
  }) {
    return navigatorKey.currentState.pushReplacementNamed(
      routeName,
      arguments: arguments,
    );
  }

  /// This method adds the page (using its name) after clearing the navigation stack
  Future<dynamic> pushNamedAndClearStack({
    @required String routeName,
    dynamic arguments,
  }) {
    return navigatorKey.currentState.pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }

  /// This method adds the page (using its name) without animation in the navigation stack
  Future<dynamic> pushWithoutAnimation({
    @required Widget route,
  }) {
    return navigatorKey.currentState.push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => route,
      ),
    );
  }

  /// This method adds the page (using its name) without animation after clearing the navigation stack
  Future<dynamic> pushReplacementWithoutAnimation({
    @required Widget route,
  }) {
    return navigatorKey.currentState.pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => route,
      ),
    );
  }

  /// This method check whether there is any page to go back or not
  bool canGoBack() {
    return navigatorKey.currentState.canPop();
  }

  /// This method pop the current page and go one page back
  void goBack() {
    if (navigatorKey.currentState.canPop()) {
      navigatorKey.currentState.pop();
    }
  }

  /// This method pop the current page with some data
  void goBackWithData({
    @required Map<String, dynamic> data,
  }) {
    if (navigatorKey.currentState.canPop()) {
      navigatorKey.currentState.pop(data);
    }
  }
}
