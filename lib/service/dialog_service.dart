import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:skeleton/components/button/custom_text_button.dart';
import 'package:skeleton/components/text/custom_text.dart';
import 'package:skeleton/components/textstyle/custom_text_style.dart';
import 'package:skeleton/service/service_locator.dart' as serviceLocator;
import 'package:skeleton/components/dialog/loader.dart';
import 'package:skeleton/service/navigation_service.dart';

/// This class is used to show dialog without context
class DialogService {
  final NavigationService _navigationService =
      serviceLocator.locator<NavigationService>();

  bool isShowing = false;

  /// This method is used to show loader
  Future<void> showLoader() async {
    Loader loader = Loader(
      context: _navigationService.navigatorKey.currentContext,
    );
    await loader.show();
  }

  /// This method is used to hide loader
  Future<void> hideLoader() async {
    Loader loader = Loader(
      context: _navigationService.navigatorKey.currentContext,
    );
    if (loader.isShowing()) {
      await loader.hide();
    }
  }

  /// This method is used to show snackbar
  /// Here we are using 4 parameters
  /// snackbarType -> To decide color
  /// message -> Text to be shown at snackbar
  /// actionLabel -> actionLabel if any
  /// onActionClick -> Callback on action click if required
  Future<void> showSnackbar(
    SnackbarType snackbarType,
    String message, {
    String actionLabel,
    Function onActionClick,
  }) async {
    if (!isShowing) {
      isShowing = true;
      await showFlash(
        context: _navigationService.navigatorKey.currentContext,
        duration: Duration(seconds: 3),
        builder: (context, controller) {
          return Flash(
            backgroundColor: snackbarType == SnackbarType.SUCCESS
                ? Colors.green
                : Colors.red,
            controller: controller,
            style: FlashStyle.grounded,
            child: FlashBar(
              message: CustomText(
                text: message,
                textStyle: CustomTextStyle.getTextStyle(
                  Colors.white,
                  12.0,
                ),
              ),
              primaryAction: Visibility(
                visible: onActionClick != null,
                child: CustomTextButton(
                  onButtonPress: () {
                    controller.dismiss();
                  },
                  title: actionLabel,
                  titleTextStyle: CustomTextStyle.getTextStyle(
                    Colors.white,
                    12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ).whenComplete(() {
        isShowing = false;
        if (onActionClick != null) {
          onActionClick();
        }
      });
    }
  }
}

enum SnackbarType {
  SUCCESS,
  ERROR,
}
