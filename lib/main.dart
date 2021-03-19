import 'package:flutter/material.dart';
import 'package:skeleton/screens/example_screen.dart';
import 'package:skeleton/service/navigation_service.dart';
import 'package:skeleton/service/service_locator.dart' as serviceLocator;

void main() {
  /// Here we are ensuring that app is initialized
  WidgetsFlutterBinding.ensureInitialized();

  /// Here we are setting up our services on app startup
  serviceLocator.setupLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final NavigationService _navigationService =
      serviceLocator.locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skeleton',

      ///Here we are setting our navigationService navigatorKey which is used to perform navigation
      navigatorKey: _navigationService.navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ExampleScreen(),
    );
  }
}
