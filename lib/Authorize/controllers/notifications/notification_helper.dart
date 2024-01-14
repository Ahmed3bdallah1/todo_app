import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as time;
import 'package:timezone/data/latest.dart' as time;
import 'package:todo/features/onboard/notifications.dart';
import 'package:todo/utilties/constants.dart';
import 'package:todo/utilties/task_model.dart';

class NotificationHelper {
  final WidgetRef ref;

  NotificationHelper({required this.ref});

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String? notificationsPayload;
  final BehaviorSubject<String?> subject = BehaviorSubject<String?>();

  initializeNotifications() async {
    _configureSelectedNotificationSubject();
    await configureLocalTimeZone();
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            requestBadgePermission: false,
            requestSoundPermission: false,
            requestAlertPermission: false,
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('todo_app_icon');

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: androidInitializationSettings,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (data) {
      print(data);
      if (data != null) {
        debugPrint('notification payload ${data.payload}');
      }
      subject.add(data.payload);
    });
  }

  void requestIOSPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          sound: true,
          alert: true,
          badge: true,
        );
  }

  Future<void> configureLocalTimeZone() async {
    time.initializeTimeZones();
    const String timeZoneName = 'Africa/Cairo';
    time.setLocalLocation(time.getLocation(timeZoneName));
  }

  @pragma('vm:entry-point')
  Future<void> onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payLoad) async {
    showDialog(
        context: ref.context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text(Constants.titles),
              content: Text(Constants.descs),
              actions: [
                CupertinoDialogAction(
                    isDestructiveAction: true,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('close')),
                CupertinoDialogAction(
                  child: const Text('View'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const NotificationsPage()));
                    Navigator.pop(context);
                  },
                )
              ],
            ));
  }

  scheduledNotifications(int minutes, TaskModel taskModel) async {
    print("schedled");
    await flutterLocalNotificationsPlugin.zonedSchedule(
        taskModel.id ?? 0,
        taskModel.title,
        taskModel.description,
        time.TZDateTime.now(time.local).add(Duration(minutes: minutes)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
          "your channel id",
          "your channel name",
        )),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload:
            "${taskModel.title}|${taskModel.description}|${taskModel.date}|${taskModel.startTime}|${taskModel.endTime}");
  }

  void _configureSelectedNotificationSubject() {
    subject.stream.listen((String? payload) async {
      var title = payload!.split('|')[0];
      var body = payload.split('|')[1];
      showDialog(
          context: ref.context,
          builder: (BuildContext context) => CupertinoAlertDialog(
                title: Text(title),
                content: Text(body, textAlign: TextAlign.justify, maxLines: 2),
                actions: [
                  CupertinoDialogAction(
                      isDestructiveAction: true,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('close')),
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  NotificationsPage(load: payload)));
                    },
                    child: const Text('View'),
                  )
                ],
              ));
    });
  }
}
