import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../constants/constants.dart';

/// Contains some useful methods for build contexts.
extension AppLocalizationExtension on BuildContext {
  /// Returns the string associated to the specified key using EzLocalization.
  String getString(String key, [dynamic args]) =>
      AppLocalization.of(this).get(key, args);

  Locale getLocale() => AppLocalization.of(this).locale;
}

/// The AppLocalization class.
class AppLocalization {
  /// The current locale.
  final Locale locale;

  /// The localized strings.
  Map<String, String> _strings = HashMap();

  /// Creates a new ez localization instance.
  AppLocalization({
    this.locale = const Locale('en'),
  });

  /// Returns the AppLocalization instance attached to the specified build config.
  static AppLocalization of(BuildContext context) =>
      Localizations.of<AppLocalization>(context, AppLocalization)!;

  /// Loads the localized strings.
  Future<bool> load() async {
    try {
      String data = await rootBundle
          .loadString('assets/translations/${locale.languageCode}.json');
      Map<String, dynamic> jsonMap = json.decode(data);
      _strings = jsonMap.map((key, value) {
        return MapEntry(key, value.toString());
      });
      return true;
    } catch (exception, stacktrace) {
      debugPrint(exception.toString());
      debugPrint(stacktrace.toString());
    }
    return false;
  }

  /// Returns the string associated to the specified key.
  String get(String key, [dynamic args]) {
    String? value = _strings[key];
    if (value == null) {
      return key;
    }

    if (args != null) {
      value = _formatReturnValue(value, args);
    }

    return value;
  }

  /// Formats the return value according to the specified arguments.
  String _formatReturnValue(String value, dynamic arguments) {
    if (arguments is List) {
      for (int i = 0; i < arguments.length; i++) {
        value = value.replaceAll('{$i}', arguments[i].toString());
      }
    } else if (arguments is Map) {
      arguments.forEach((formatKey, formatValue) =>
          value = value.replaceAll('{$formatKey}', formatValue.toString()));
    }
    return value;
  }
}

/// The AppLocalization delegate class.
class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  /// Contains all supported locales.
  final List<Locale> supportedLocales;

  /// The locale to force (if specified, not recommended except under special circumstances).
  final Locale? locale;

  /// Creates a new app localization delegate instance.
  const AppLocalizationDelegate({
    this.supportedLocales = const [Locale('en'), Locale('hi')],
    this.locale,
  });

  @override
  bool isSupported(Locale locale) =>
      _isLocaleSupported(supportedLocales, locale) != null;

  //TODO : Change Account Name
  @override
  Future<AppLocalization> load(Locale locale) async {
    const storage = FlutterSecureStorage(
      iOptions: IOSOptions(
        accountName: 'skeleton',
      ),
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    );

    String languageCode = await storage.read(
          key: kLanguage,
        ) ??
        'en';

    await initializeDateFormatting(languageCode, null);

    AppLocalization appLocalization = AppLocalization(
      locale: Locale(languageCode),
    );

    await appLocalization.load();
    return appLocalization;
  }

  @override
  bool shouldReload(AppLocalizationDelegate old) => old.locale != locale;

  /// The default locale resolution callback.
  Locale localeResolutionCallback(
    Locale? locale,
    Iterable<Locale> supportedLocales,
  ) {
    if (this.locale != null) {
      return this.locale!;
    }

    if (locale == null) {
      return supportedLocales.first;
    }

    return _isLocaleSupported(supportedLocales, locale) ??
        supportedLocales.first;
  }

  /// The localization delegates to add in your application.
  List<LocalizationsDelegate> get localizationDelegates => [
        this,
      ];

  /// Returns the locale if it's supported by this localization delegate, null otherwise.
  Locale? _isLocaleSupported(Iterable<Locale> supportedLocales, Locale locale) {
    for (Locale supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode ||
          supportedLocale.countryCode == locale.countryCode) {
        return supportedLocale;
      }
    }

    return null;
  }
}
