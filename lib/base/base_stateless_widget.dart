import 'package:flutter/material.dart';
import 'package:skeleton/components/loader/loader_widget.dart';
import 'package:skeleton/services/dialog_service.dart';
import 'package:skeleton/services/navigation_service.dart';
import 'package:skeleton/services/service_locator.dart' as serviceLocator;

/// This is custom stateless widget class which will be extended by all stateless widget
abstract class BaseStatelessWidget extends StatelessWidget {
  final DialogService dialogService = serviceLocator.locator<DialogService>();
  final NavigationService navigationService =
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
    dialogService.showSnackbar(
      context,
      snackbarType,
      message,
      onActionClick: onActionClick,
    );
  }

  /// Use this method to navigate using navigationService
  void navigation({
    required BuildContext context,
    required String routeName,
    required NavigationType navigationType,
    Widget? namelessRoute,
    Map<String, dynamic>? arguments,
  }) {
    switch (navigationType) {
      case NavigationType.PUSH_REPLACEMENT:
        navigationService.pushReplacement(
          context: context,
          widget: namelessRoute!,
        );
        break;
      case NavigationType.PUSH:
        navigationService.push(
          context: context,
          widget: namelessRoute!,
        );
        break;
      case NavigationType.PUSH_CLEAR_STACK:
        navigationService.pushAndClearStack(
          context: context,
          widget: namelessRoute!,
        );
        break;
      case NavigationType.PUSH_REPLACEMENT_NAMED:
        navigationService.pushReplacementNamed(
          context: context,
          routeName: routeName,
          arguments: arguments,
        );
        break;
      case NavigationType.PUSH_NAMED:
        navigationService.pushNamed(
          context: context,
          routeName: routeName,
          arguments: arguments,
        );
        break;
      case NavigationType.PUSH_CLEAR_STACK_NAMED:
        navigationService.pushNamedAndClearStack(
          context: context,
          routeName: routeName,
          arguments: arguments,
        );
        break;
      case NavigationType.PUSH_WITHOUT_ANIMATION:
        navigationService.pushWithoutAnimation(
          context: context,
          widget: namelessRoute!,
        );
        break;
      case NavigationType.PUSH_REPLACEMENT_WITHOUT_ANIMATION:
        navigationService.pushReplacementWithoutAnimation(
          context: context,
          widget: namelessRoute!,
        );
        break;
      case NavigationType.GO_BACK:
        navigationService.goBack(
          context: context,
        );
        break;
      case NavigationType.GO_BACK_WITH_DATA:
        navigationService.goBackWithData(
          context: context,
          data: arguments,
        );
        break;
    }
  }
}
