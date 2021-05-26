import 'package:easy_localization/easy_localization.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skeleton/screens/example_screen.dart';
import 'package:skeleton/screens/list_example_screen.dart';
import 'package:skeleton/screens/splash_screen.dart';
import 'package:skeleton/services/service_locator.dart' as serviceLocator;
import 'package:skeleton/services/navigation_service.dart';
import 'package:eraser/eraser.dart';

// /// This method is used to listen notification in background. Here you cannot update any ui since it is outside application context
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   /// Initialization is required only if listening to notification in background
//   await Firebase.initializeApp();
//   print("Handling a background message: ${message.messageId}");
// }

Future<void> main() async {
  /// Here we are ensuring that app is initialized
  WidgetsFlutterBinding.ensureInitialized();

  /// Here we are ensuring that localization is initialized
  await EasyLocalization.ensureInitialized();

  /// Here we are setting up our services on app startup
  serviceLocator.setupLocator();

  /// Here we are setting firebase notification background listener
  //await Firebase.initializeApp();
  //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

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
      EasyLocalization(
        supportedLocales: [
          Locale('en'),
          Locale('hi'),
        ],

        /// In this path we need to create json files for all locale we are defining
        path: 'assets/translations',
        fallbackLocale: Locale('en'),
        useOnlyLangCode: true,
        child: MyApp(),
      ),
    );
  });

  /// Clearing tray notifications & remove badge count for iOS on app open
  Eraser.clearAllAppNotifications();
  Eraser.resetBadgeCountAndRemoveNotificationsFromCenter();
}

class MyApp extends StatelessWidget {
  final NavigationService _navigationService =
      serviceLocator.locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skeleton',

      ///Here we are setting current locale
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      ///Here we are setting our navigationService navigatorKey which is used to perform navigation
      navigatorKey: _navigationService.navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      onGenerateRoute: _getRoute,
    );
  }

  /// This method is used for named navigation
  Route? _getRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/example':
        return _buildRoute(
          settings,
          ExampleScreen(),
        );
      case '/listExample':
        return _buildRoute(
          settings,
          ListExampleScreen(),
        );
    }
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
