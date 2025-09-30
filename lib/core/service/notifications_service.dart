import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsService {
  static late FirebaseMessaging messaging;
  static late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  static Future<void> initFirebaseMessaging() async {
    messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      log("❌ User denied notifications permission");
      return;
    }

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);
    await flutterLocalNotificationsPlugin.initialize(initSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("📩 Foreground Notification: ${message.notification?.title}");

      if (message.notification != null) {
        showLocalNotification(
          title: message.notification!.title ?? "No title",
          body: message.notification!.body ?? "No body",
        );
      }
    });
  }

  static Future<void> showLocalNotification({
    required String title,
    required String body,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'default_channel',
      'General Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(0, title, body, details);
  }

  static Future<String?> getFCMToken() async {
    return await messaging.getToken();
  }
}
