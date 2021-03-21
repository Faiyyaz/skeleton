import 'package:flutter/material.dart';
import 'package:skeleton/services/api_service.dart';
import 'package:skeleton/services/dialog_service.dart';
import 'package:skeleton/services/local_storage_service.dart';
import 'package:skeleton/services/navigation_service.dart';
import 'package:skeleton/services/service_locator.dart' as serviceLocator;

/// This is custom stateful widget class which will be extended by all stateful widget
abstract class BaseStatefulWidget extends StatefulWidget {
  BaseStatefulWidget({Key key}) : super(key: key);
}

/// This is custom stateful widget state class for which we will create mixin.
/// If you don't know what mixin is please visit the below mentioned blog, it has a good explanation
/// https://medium.com/flutter-community/https-medium-com-shubhamhackzz-dart-for-flutter-mixins-in-dart-f8bb10a3d341#:~:text=%E2%80%9CIn%20object%2Doriented%20programming%20languages,from%20without%20extending%20the%20class.
abstract class BaseState<Page extends BaseStatefulWidget> extends State<Page> {}

mixin BasicPage<Page extends BaseStatefulWidget> on BaseState<Page> {
  final DialogService dialogService = serviceLocator.locator<DialogService>();
  final APIService apiService = serviceLocator.locator<APIService>();
  final NavigationService navigationService =
      serviceLocator.locator<NavigationService>();
  final LocalStorageService localStorageService =
      serviceLocator.locator<LocalStorageService>();

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
