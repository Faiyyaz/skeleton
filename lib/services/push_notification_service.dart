// import 'dart:convert';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// This service is related to push notification
/// For setup visit the document link https://firebase.flutter.dev/docs/messaging/overview
// class PushNotificationService {
//   final FirebaseMessaging _messaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   /// This function is used to get notification permission for iOS
//   Future<AuthorizationStatus> requestIosPermissions() async {
//     NotificationSettings settings = await _messaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//
//     return settings.authorizationStatus;
//   }
//
//   /// This function is used to get notification token
//   Future<String?> getToken() async {
//     String? token = await _messaging.getToken();
//     return token;
//   }
//
//   /// This function is used to delete token on logout
//   Future<void> clearInstance() async {
//     await _messaging.deleteToken();
//   }
//
//   /// This function is used to listen to notification while app is foreground
//   Future<void> listenNotification(
//     SelectNotificationCallback onNotificationClick,
//   ) async {
//     /// Creating local notification channel for the app
//     final AndroidNotificationChannel androidNotificationChannel =
//         AndroidNotificationChannel(
//       'Skeleton',
//       'Skeleton',
//       'This channel is used for important notifications.',
//       importance: Importance.max,
//     );
//
//     await _flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(androidNotificationChannel);
//
//     final AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings(
//       '@mipmap/ic_stat_logo',
//     );
//
//     final IOSInitializationSettings initializationSettingsIOS =
//         IOSInitializationSettings();
//
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );
//
//     await _flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onSelectNotification: onNotificationClick,
//     );
//
//     AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'Skeleton',
//       'Skeleton',
//       'This channel is used for important notifications.',
//       importance: Importance.max,
//       priority: Priority.high,
//       icon: '@mipmap/ic_stat_logo',
//     );
//
//     IOSNotificationDetails iOSPlatformChannelSpecifics =
//         IOSNotificationDetails();
//     NotificationDetails platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: iOSPlatformChannelSpecifics,
//     );
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//       RemoteNotification? notification = message.notification;
//       if (notification != null) {
//         await _flutterLocalNotificationsPlugin.show(
//           DateTime.now().millisecond,
//           message.notification!.title,
//           message.notification!.body,
//           platformChannelSpecifics,
//           payload: jsonEncode(message.data),
//         );
//       }
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
//       Map<String, dynamic> data = message.data;
//       if (data.isNotEmpty) {
//         debugPrint('${message.data}');
//       }
//     });
//   }
// }
