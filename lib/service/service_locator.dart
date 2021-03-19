import 'package:get_it/get_it.dart';
import 'package:skeleton/service/api_service.dart';
import 'package:skeleton/service/dialog_service.dart';
import 'package:skeleton/service/local_storage_service.dart';
import 'package:skeleton/service/navigation_service.dart';
import 'package:skeleton/service/permission_service.dart';
import 'package:skeleton/service/push_notification_service.dart';

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
  locator.registerLazySingleton(
    () => APIService(),
  );
  locator.registerLazySingleton(
    () => LocalStorageService(),
  );
  locator.registerLazySingleton(
    () => PermissionService(),
  );
  locator.registerLazySingleton(
    () => PushNotificationService(),
  );
}
