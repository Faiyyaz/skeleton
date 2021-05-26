import 'package:flutter/material.dart';
import 'package:skeleton/services/api_service.dart';
import 'package:skeleton/services/dialog_service.dart';
import 'package:skeleton/services/local_storage_service.dart';
import 'package:skeleton/services/locale_service.dart';
import 'package:skeleton/services/navigation_service.dart';
import 'package:skeleton/services/push_notification_service.dart';
import 'package:skeleton/services/service_locator.dart' as serviceLocator;

/// This is custom stateless widget class which will be extended by all stateless widget
abstract class BaseStatelessWidget extends StatelessWidget {
  final DialogService dialogService = serviceLocator.locator<DialogService>();
  final APIService apiService = serviceLocator.locator<APIService>();
  final NavigationService navigationService =
      serviceLocator.locator<NavigationService>();
  final LocalStorageService localStorageService =
      serviceLocator.locator<LocalStorageService>();
  final LocaleService localeService = serviceLocator.locator<LocaleService>();
  //final PushNotificationService pushNotificationService = serviceLocator.locator<PushNotificationService>();

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
            child: getBody(
              context,
              orientation,
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
}
