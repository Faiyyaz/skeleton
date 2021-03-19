import 'package:firebase_messaging/firebase_messaging.dart';

/// This service is related to push notification
/// For setup visit the document link https://firebase.flutter.dev/docs/messaging/overview
class PushNotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  /// This function is used to get notification permission for iOS
  Future<AuthorizationStatus> requestIosPermissions() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    return settings.authorizationStatus;
  }

  /// This function is used to get notification token
  Future<String> getToken() async {
    String token = await messaging.getToken();
    return token;
  }

  /// This function is used to delete token on logout
  Future<void> clearInstance() async {
    await messaging.deleteToken();
  }

  /// This function is used to listen to notification while app is foreground
  void listenNotification(Function onNotification) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        //TODO: Handle notification maybe show toast or local notification
      }
      if (message.data != null) {
        onNotification(message.data);
      }
    });
  }
}
