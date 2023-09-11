import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../constants/constants.dart';
import '../../../domain/use_cases/theme/theme_provider.dart';
import '../../services/local_storage_service.dart';

part 'theme_repository.g.dart';

@riverpod
ThemeRepository themeRepository(ThemeRepositoryRef ref) {
  return ThemeRepository(client: ref.read(localStorageServiceProvider));
}

class ThemeRepository {
  ThemeRepository({
    required this.client,
  });

  final LocalStorageService client;

  Future<AppThemeModeType> getCurrentTheme() async {
    String? themeMode = await client.getString(key: kThemeMode);
    AppThemeModeType appThemeModeType;
    if (themeMode != null) {
      appThemeModeType = AppThemeModeType.values.firstWhere(
        (e) => e.name == themeMode,
      );
    } else {
      appThemeModeType =
          SchedulerBinding.instance.platformDispatcher.platformBrightness ==
                  Brightness.dark
              ? AppThemeModeType.dark
              : AppThemeModeType.light;
    }
    return appThemeModeType;
  }

  Future<void> updateCurrentTheme({
    required AppThemeModeType appThemeModeType,
  }) async {
    await client.setString(
      key: kThemeMode,
      value: appThemeModeType.name,
    );
  }
}
