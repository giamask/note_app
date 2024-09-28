import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

Future<void> setReminder(dynamic flutterLocalNotificationsPlugin, int id,
    DateTime date, String? title, String? body) async {
  if (date.isBefore(DateTime.now())) return;
  await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title ?? '',
      body ?? '',
      tz.TZDateTime.from(date, tz.local),
      const NotificationDetails(
          android: AndroidNotificationDetails('channel id', 'channel name',
              channelDescription: 'description')),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime);
}
