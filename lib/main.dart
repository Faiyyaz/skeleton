import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skeleton/screens/splash_screen.dart';
import 'package:skeleton/services/service_locator.dart' as serviceLocator;

Future<void> main() async {
  /// Here we are ensuring that app is initialized
  WidgetsFlutterBinding.ensureInitialized();

  /// Here we are setting up our services on app startup
  serviceLocator.setupLocator();

  /// Making status bar transparent
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  /// Setting the values
  await SystemChrome.setEnabledSystemUIOverlays(
    SystemUiOverlay.values,
  );

  /// Locking the orientation to portrait only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(
      MyApp(),
    );
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skeleton',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      onGenerateRoute: _getRoute,
    );
  }

  /// This method is used for named navigation
  Route? _getRoute(RouteSettings settings) {
    return null;
  }

  /// This function is where the navigation happens
  MaterialPageRoute _buildRoute(RouteSettings settings, Widget widget) {
    return MaterialPageRoute(
      settings: settings,
      builder: (ctx) => widget,
    );
  }
}
