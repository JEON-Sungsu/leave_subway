import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:leave_subway/service/service_config.dart';

final FlutterLocalNotificationsPlugin localNotification =
    FlutterLocalNotificationsPlugin();

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
  await localNotification.initialize(initSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {});
}

void showLocalPush(
    {required String title, required String body, String? isLast}) async {
  await localNotification.show(0, title, body, NOTIFICATION_DETAIL,
      payload: isLast);
}
