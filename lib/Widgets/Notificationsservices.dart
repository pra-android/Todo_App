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
    //IOS Notificatio Details
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
    //IOS Notificatio Details
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
      final now = TZDateTime.now(local);
      print(now);
      TZDateTime scheduledatee = TZDateTime(local, now.year, now.month, now.day,
          timeOfDay.hour, timeOfDay.minute);
      print(scheduledatee);
      print(scheduledatee.runtimeType);

      if (scheduledatee.isBefore(now)) {
        scheduledatee = scheduledatee.add(const Duration(days: 1));
      }
      return scheduledatee;
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
        1,
        title,
        body,
        androidAllowWhileIdle: true,
          _schedulesDailyTime(
            TimeOfDay(hour: datetime.hour, minute: datetime.minute)),
        notis,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

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
        DarwinNotificationDetails(
      presentAlert: true,
      presentSound: true,
      presentBanner: true,
      presentBadge: true,
    );
    NotificationDetails notis = NotificationDetails(
        iOS: darwinNotificationDetails, android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      2,
      title,
      body,
      TZDateTime.from(impdatetime, local),
      notis,
      payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
