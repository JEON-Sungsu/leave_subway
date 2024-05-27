import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin localNotification = FlutterLocalNotificationsPlugin();


Future<void> initLocalNotification() async {
  AndroidInitializationSettings initSettingsAndroid =
  const AndroidInitializationSettings('ic_launcher');
  DarwinInitializationSettings initSettingsIOS =
  const DarwinInitializationSettings(
    requestSoundPermission: false,
    requestBadgePermission: false,
    requestAlertPermission: false,
  );
  InitializationSettings initSettings = InitializationSettings(
    android: initSettingsAndroid,
    iOS: initSettingsIOS,
  );
  await localNotification.initialize(
    initSettings,
  );
}

Future<void> showLocalPush() async {
  NotificationDetails details = const NotificationDetails(
    iOS: DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    ),
    android: AndroidNotificationDetails(
        "show_test", "show_test",
        importance: Importance.max,
        priority: Priority.high,
        icon: 'ic_launcher'),
  );
  await localNotification.show(
    0,
    "타이틀이 보여지는 영역입니다.",
    "컨텐츠 내용이 보여지는 영역입니다.",
    details,
  );
}