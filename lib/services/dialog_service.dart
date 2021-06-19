import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeleton/components/button/text/custom_text_button.dart';
import 'package:skeleton/components/text/custom_text.dart';
import 'package:skeleton/components/textstyle/custom_text_style.dart';
import 'package:skeleton/utilities/custom_logger.dart';

class DialogService {
  bool isShowing = false;

  /// This method is used to show snackbar
  /// Here we are using 4 parameters
  /// snackbarType -> To decide color
  /// message -> Text to be shown at snackbar
  /// actionLabel -> actionLabel if any
  /// onActionClick -> Callback on action click if required
  Future<void> showSnackbar(
    BuildContext context,
    SnackbarType snackbarType,
    String message, {
    String? actionLabel,
    Function? onActionClick,
  }) async {
    try {
      /// The below line check if the context passed is of current screen
      if (ModalRoute.of(context)!.isCurrent) {
        if (!isShowing) {
          isShowing = true;
          await showFlash(
            context: context,
            duration: Duration(seconds: 3),
            builder: (context, controller) {
              return Flash(
                backgroundColor: snackbarType == SnackbarType.SUCCESS
                    ? Colors.green
                    : Colors.red,
                controller: controller,
                behavior: FlashBehavior.fixed,
                child: FlashBar(
                  content: CustomText(
                    text: message,
                    textStyle: CustomTextStyle.getTextStyle(
                      textColor: Colors.white,
                      fontSize: 12.0,
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
                        textColor: Colors.white,
                        fontSize: 12.0,
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

enum SnackbarType {
  SUCCESS,
  ERROR,
}
