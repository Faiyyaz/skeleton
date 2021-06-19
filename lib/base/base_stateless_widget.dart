import 'package:flutter/material.dart';
import 'package:skeleton/components/loader/loader_widget.dart';
import 'package:skeleton/services/dialog_service.dart';
import 'package:skeleton/services/navigation_service.dart';
import 'package:skeleton/services/service_locator.dart' as serviceLocator;
import 'package:skeleton/utilities/custom_logger.dart';

/// This is custom stateless widget class which will be extended by all stateless widget
abstract class BaseStatelessWidget extends StatelessWidget {
  final DialogService _dialogService = serviceLocator.locator<DialogService>();
  final NavigationService _navigationService =
      serviceLocator.locator<NavigationService>();

  BaseStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return onBackPress();
      },
      child: OrientationBuilder(
        builder: (context, orientation) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: LoaderWidget(
              showLoader: shouldShowLoader(),
              child: getBody(
                context,
                orientation,
              ),
            ),
          );
        },
      ),
    );
  }

  /// This method will be used to create the body of the page
  /// It has two properties
  /// context -> current context
  /// orientation -> current orientation of the device
  Widget getBody(BuildContext context, Orientation orientation);

  /// This method will decide whether we want to enable or disable back using the hardware key on android
  bool onBackPress();

  /// This method will decide whether to show loader or not
  bool shouldShowLoader();

  /// Use this method to show snackbar using dialogService
  void showSnackbar({
    required BuildContext context,
    SnackbarType snackbarType = SnackbarType.ERROR,
    required String message,
    Function? onActionClick,
  }) {
    _dialogService.showSnackbar(
      context,
      snackbarType,
      message,
      onActionClick: onActionClick,
    );
  }

  /// Use this method to navigate using navigationService
  void navigate({
    required BuildContext context,
    required NavigationType navigationType,
    Widget? screen,
    String? routeName,
    bool isFullScreenDialog = false,
    Map<String, dynamic>? arguments,
  }) {
    if (screen == null && routeName == null) {
      CustomLogger.logEvent(
        loggingType: LoggingType.ERROR,
        message: 'Route is blank provide at least a screen widget or routeName',
      );
    } else {
      switch (navigationType) {
        case NavigationType.PUSH_REPLACEMENT:
          if (screen != null) {
            _navigationService.pushReplacement(
              context: context,
              widget: screen,
              isFullScreenDialog: isFullScreenDialog,
            );
          } else {
            _navigationService.pushReplacementNamed(
              context: context,
              routeName: routeName!,
              arguments: arguments,
            );
          }
          break;
        case NavigationType.PUSH:
          if (screen != null) {
            _navigationService.push(
              context: context,
              widget: screen,
              isFullScreenDialog: isFullScreenDialog,
            );
          } else {
            _navigationService.pushNamed(
              context: context,
              routeName: routeName!,
              arguments: arguments,
            );
          }
          break;
        case NavigationType.PUSH_CLEAR_STACK:
          if (screen != null) {
            _navigationService.pushAndClearStack(
              context: context,
              widget: screen,
            );
          } else {
            _navigationService.pushNamedAndClearStack(
              context: context,
              routeName: routeName!,
              arguments: arguments,
            );
          }
          break;
        case NavigationType.PUSH_WITHOUT_ANIMATION:
          _navigationService.pushWithoutAnimation(
            context: context,
            widget: screen!,
          );
          break;
        case NavigationType.PUSH_REPLACEMENT_WITHOUT_ANIMATION:
          _navigationService.pushReplacementWithoutAnimation(
            context: context,
            widget: screen!,
          );
          break;
        case NavigationType.GO_BACK:
          _navigationService.goBack(
            context: context,
          );
          break;
        case NavigationType.GO_BACK_WITH_DATA:
          _navigationService.goBackWithData(
            context: context,
            data: arguments,
          );
          break;
      }
    }
  }
}
