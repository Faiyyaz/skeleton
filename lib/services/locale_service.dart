import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:skeleton/services/navigation_service.dart';
import 'package:skeleton/services/service_locator.dart' as serviceLocator;

/// This class is used to set and retrieve locale
class LocaleService {
  final NavigationService _navigationService =
      serviceLocator.locator<NavigationService>();

  /// This method is used to current locale
  Locale getCurrentLocale() {
    BuildContext? context = _navigationService.navigatorKey.currentContext!;
    return context.locale;
  }

  /// This method is used to set locale for the app
  Future<Locale> setLocale({
    required String language,
  }) async {
    BuildContext? context = _navigationService.navigatorKey.currentContext!;
    Locale locale = Locale(language);
    await context.setLocale(locale);
    Locale updatedLocal = context.locale;
    return updatedLocal;
  }
}
