import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/ui_constants.dart';
import '../domain/use_cases/theme/theme_provider.dart';

class ThemeConfig {
  static ThemeData? getCurrentTheme(
    AppThemeModeType? appThemeModeType,
  ) {
    switch (appThemeModeType) {
      case AppThemeModeType.light:
        return getLightTheme();
      case AppThemeModeType.dark:
        return getDarkTheme();
      default:
        return null;
    }
  }

  static ThemeData getLightTheme() {
    return ThemeData.light(
      useMaterial3: true,
    );
  }

  static ThemeData getDarkTheme() {
    return ThemeData.dark(
      useMaterial3: true,
    );
  }
}
