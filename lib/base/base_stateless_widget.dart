import 'package:flutter/material.dart';
import 'package:skeleton/service/api_service.dart';
import 'package:skeleton/service/dialog_service.dart';
import 'package:skeleton/service/local_storage_service.dart';
import 'package:skeleton/service/locale_service.dart';
import 'package:skeleton/service/navigation_service.dart';
import 'package:skeleton/service/service_locator.dart' as serviceLocator;

/// This is custom stateless widget class which will be extended by all stateless widget
abstract class BaseStatelessWidget extends StatelessWidget {
  final DialogService dialogService = serviceLocator.locator<DialogService>();
  final APIService apiService = serviceLocator.locator<APIService>();
  final NavigationService navigationService =
      serviceLocator.locator<NavigationService>();
  final LocalStorageService localStorageService =
      serviceLocator.locator<LocalStorageService>();
  final LocaleService localeService = serviceLocator.locator<LocaleService>();

  BaseStatelessWidget({Key key}) : super(key: key);

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
