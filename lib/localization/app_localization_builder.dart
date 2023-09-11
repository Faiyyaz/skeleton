import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants/constants.dart';
import 'app_localization.dart';

/// A simple but useful widget that allows to load EzLocalization easier.
class AppLocalizationBuilder extends StatefulWidget {
  /// The delegate builder.
  final AppLocalizationDelegate delegate;

  /// The widget builder.
  final Widget Function(
    BuildContext context,
    AppLocalizationDelegate appLocalizationDelegate,
  ) builder;

  /// Creates a new AppLocalization builder instance.
  const AppLocalizationBuilder({
    super.key,
    this.delegate = const AppLocalizationDelegate(),
    required this.builder,
  });

  @override
  State<StatefulWidget> createState() => AppLocalizationBuilderState();

  /// Allows to change the preferred locale (if using the builder).
  static AppLocalizationBuilderState of(BuildContext context) =>
      context.findAncestorStateOfType<AppLocalizationBuilderState>()!;
}

/// The AppLocalization builder state.
class AppLocalizationBuilderState extends State<AppLocalizationBuilder> {
  /// The current AppLocalization delegate.
  late AppLocalizationDelegate _appLocalizationDelegate;

  @override
  void initState() {
    super.initState();
    _appLocalizationDelegate = widget.delegate;
  }

  @override
  Widget build(BuildContext context) =>
      widget.builder(context, _appLocalizationDelegate);

  //TODO : Change Account Name
  /// Allows to change the preferred locale.
  Future<void> changeLocale(String language) async {
    const storage = FlutterSecureStorage(
      iOptions: IOSOptions(
        accountName: 'skeleton',
      ),
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    );

    await storage.write(
      key: kLanguage,
      value: language,
    );

    Locale locale = Locale(language);

    if (mounted) {
      setState(() {
        _appLocalizationDelegate = AppLocalizationDelegate(
          supportedLocales: _appLocalizationDelegate.supportedLocales,
          locale: locale,
        );
      });
    }
  }
}
