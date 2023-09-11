// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/widgets.dart';
//
// class FirebaseServices {
//   // Initialize Firebase.
//   FirebaseApp? defaultApp;
//
//   FirebaseServices._internal();
//
//   static final FirebaseServices _instance = FirebaseServices._internal();
//
//   static FirebaseServices get instance => _instance;
//
//   FirebaseMessaging? messaging;
//   NotificationSettings? settings;
//   String? firebaseToken;
//
//   initialiseFirebase() {
//     return Firebase.initializeApp();
//   }
//
//   initFirebaseMessaging() {
//     return FirebaseMessaging.instance;
//   }
//
//   initFirebaseNotificationSettings() {
//     return messaging!.requestPermission(
//       alert: true,
//       announcement: true,
//       badge: true,
//       carPlay: false,
//       criticalAlert: true,
//       provisional: false,
//       sound: true,
//     );
//   }
//
//   setOptions() {
//     messaging!.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//   }
//
//   Future<String?> getFCMToken() async {
//     try {
//       await deleteToken();
//       return await messaging!.getToken();
//     } catch (e) {
//       return null;
//     }
//   }
//
//   Future<void> deleteToken() async {
//     try {
//       await messaging!.deleteToken();
//     } catch (e) {
//       debugPrint('deleteToken ${e.toString()}');
//     }
//   }
//
//   onMessageOpenedApp(RemoteMessage message) {
//     Map<String, dynamic> payload = message.data;
//     debugPrint('payload $payload');
//   }
// }
