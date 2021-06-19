import 'package:get_it/get_it.dart';
import 'package:skeleton/services/dialog_service.dart';
import 'package:skeleton/services/navigation_service.dart';

GetIt locator = GetIt.instance;

/// Here we are setting up the services like navigation, api, etc
/// This method will be called once during app startup
void setupLocator() {
  locator.registerLazySingleton(
    () => NavigationService(),
  );
  locator.registerLazySingleton(
    () => DialogService(),
  );
}
