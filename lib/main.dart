import 'dart:async';

//import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;

import 'data/repositories/common/theme_repository.dart';
import 'domain/use_cases/theme/theme_provider.dart';
//import 'firebase/firebase_services.dart';
import 'localization/app_localization.dart';
import 'localization/app_localization_builder.dart';
import 'utilities/router.dart';
import 'utilities/theme_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // FirebaseServices firebaseServices = FirebaseServices.instance;
  // firebaseServices.defaultApp = await firebaseServices.initialiseFirebase();
  // firebaseServices.messaging = await firebaseServices.initFirebaseMessaging();
  // firebaseServices.settings =
  // await firebaseServices.initFirebaseNotificationSettings();
  // firebaseServices.defaultApp!.setAutomaticDataCollectionEnabled(true);
  //
  // firebaseServices.firebaseToken = await firebaseServices.getFCMToken();
  // firebaseServices.setOptions();

  /// ProviderContainer is used to load async values before app render
  final container = ProviderContainer();
  final AppThemeModeType appTheme =
      await container.read(themeRepositoryProvider).getCurrentTheme();

  // Non-async exceptions
  // FlutterError.onError = (errorDetails) {
  //   FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  // };
  //
  // // Async exceptions
  // PlatformDispatcher.instance.onError = (error, stack) {
  //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //   return true;
  // };

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: MyApp(appTheme),
    ),
  );
}

class MyApp extends ConsumerWidget {
  final AppThemeModeType appTheme;

  const MyApp(
    this.appTheme, {
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return AppLocalizationBuilder(
          delegate: const AppLocalizationDelegate(),
          builder: (context, localizationDelegate) => MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: ThemeConfig.getCurrentTheme(
              ref.watch(appThemeModeProvider).value ?? appTheme,
            ),
            routerConfig: goRouter,
            localizationsDelegates: localizationDelegate.localizationDelegates,
            supportedLocales: localizationDelegate.supportedLocales,
            localeResolutionCallback:
                localizationDelegate.localeResolutionCallback,
            builder: EasyLoading.init(
              builder: (context, widget) {
                ///Overriding textScaleFactor so that it cannot be change from settings
                ///& used .sp so that the font size will be auto adjustable by screen size
                final MediaQueryData data = MediaQuery.of(context);

                return MediaQuery(
                  data: data.copyWith(textScaleFactor: 1.0.sp),
                  child: widget!,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
