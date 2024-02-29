import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart';

class NotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    //android setup
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    //IOS setup
    DarwinInitializationSettings darwinInitializationSettings =
        const DarwinInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: true,
            defaultPresentSound: true);

    InitializationSettings initializationSettings = InitializationSettings(
        iOS: darwinInitializationSettings,
        android: androidInitializationSettings);

    bool? int = await flutterLocalNotificationsPlugin
        .initialize(initializationSettings,
            onDidReceiveNotificationResponse: (receiveNotification) {
      final String? payload = receiveNotification.payload;
      if (payload != null) {
        Get.snackbar("Important", payload, snackPosition: SnackPosition.BOTTOM);
      }
    });
    print(int);
  }

  static showNotification({
    int? id = 0,
    required String title,
    required String body,
  }) async {
    print("Succesfuuly send local notifications");
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'flutter-tut',
      'flutter tutorial',
      playSound: true,
      priority: Priority.max,
      importance: Importance.high,
    );
    //IOS Notification Details
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
      presentAlert: true,
      presentSound: true,
      presentBanner: true,
      presentBadge: true,
    );
    NotificationDetails noti = NotificationDetails(
        iOS: darwinNotificationDetails, android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      noti,
    );
  }

  //For Scheduled Notifications

  static showScheduledNotification(
      {int? id = 1,
      required String title,
      required String body,
      required String payload,
      required DateTime datetime}) async {
    print("Succesfuuly send Scheduled notifications");
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'flutter-tut',
      'flutter tutorial',
      playSound: true,
      priority: Priority.max,
      importance: Importance.high,
    );
    //IOS Notification Details
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
      presentAlert: true,
      presentSound: true,
      presentBanner: true,
      presentBadge: true,
    );

    NotificationDetails notis = NotificationDetails(
        iOS: darwinNotificationDetails, android: androidNotificationDetails);

    TZDateTime _schedulesDailyTime(TimeOfDay timeOfDay) {
      final nepal = getLocation('Asia/Kathmandu');
      final now = TZDateTime.now(nepal);
      print(now);
      TZDateTime scheduledatee = TZDateTime(nepal, now.year, now.month, now.day,
          timeOfDay.hour, timeOfDay.minute);
      print(scheduledatee);
      print(scheduledatee.runtimeType);

      if (scheduledatee.isBefore(now)) {
        scheduledatee = scheduledatee.add(Duration(
            days: 1, hours: timeOfDay.hour, minutes: timeOfDay.minute));
      }
      return scheduledatee;
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
        1,
        title,
        body,
        _schedulesDailyTime(
            TimeOfDay(hour: datetime.hour, minute: datetime.minute)),
        notis,
        payload: payload,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  //schedule important task notifications
  static scheduleimportanttask(
      {int? id = 2,
      required String title,
      required String body,
      required String payload,
      required DateTime datetime,
      required DateTime impdatetime}) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('flutter-tut', 'flutter tutorial',
            playSound: true,
            priority: Priority.max,
            importance: Importance.high);
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
      presentAlert: true,
      presentSound: true,
      presentBanner: true,
      presentBadge: true,
    );
    NotificationDetails notis = NotificationDetails(
        iOS: darwinNotificationDetails, android: androidNotificationDetails);

    print("Successfully send Important scheduled local Notifications");
    TZDateTime _scheduledailyimptask(TimeOfDay timeOfDays) {
      final nepal = getLocation('Asia/Kathmandu');
      final now = TZDateTime.now(nepal);
      print(now);
      TZDateTime scheduledatee = TZDateTime(nepal, now.year, now.month, now.day,
          timeOfDays.hour, timeOfDays.minute);
      print(scheduledatee);
      print(scheduledatee.runtimeType);

      if (scheduledatee.isBefore(now)) {
        scheduledatee = scheduledatee.add(Duration(
            days: 1, hours: timeOfDays.hour, minutes: timeOfDays.minute));
      }
      return scheduledatee;
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
      2,
      title,
      body,
      _scheduledailyimptask(
          TimeOfDay(hour: impdatetime.hour, minute: impdatetime.minute)),
      notis,
      payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
