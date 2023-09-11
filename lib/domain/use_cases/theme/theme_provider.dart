import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/repositories/common/theme_repository.dart';

part 'theme_provider.g.dart';

@riverpod
class AppThemeMode extends _$AppThemeMode {
  @override
  Future<AppThemeModeType> build() {
    return _getCurrentTheme();
  }

  Future<AppThemeModeType> _getCurrentTheme() async {
    AppThemeModeType? appThemeModeType =
        await ref.read(themeRepositoryProvider).getCurrentTheme();
    return appThemeModeType;
  }

  Future<void> updateCurrentTheme({
    required AppThemeModeType appThemeModeType,
  }) async {
    await ref
        .read(themeRepositoryProvider)
        .updateCurrentTheme(appThemeModeType: appThemeModeType);
    state = AsyncData(appThemeModeType);
  }
}

enum AppThemeModeType {
  light,
  dark,
}
