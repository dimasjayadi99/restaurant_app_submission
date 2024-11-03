import 'dart:convert';
import 'dart:math';
import 'package:submission_restauirant_app/data/models/restaurant_list_model.dart';
import '../data/models/notification_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

final selectNotificationSubject = BehaviorSubject<String?>();
final didReceiveLocalNotificationSubject =
BehaviorSubject<ReceivedNotification>();

class NotificationHelper {
  static const _channelId = "01";
  static const _channelName = "channel_01";
  static const _channelDesc = "myresto channel";
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
    const AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = const DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        final payload = details.payload;
        if (payload != null) {
          debugPrint('notification payload: $payload');
        }
        selectNotificationSubject.add(payload ?? 'empty payload');
      },
    );
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin, RestaurantListModel list) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        _channelId, _channelName,
        channelDescription: _channelDesc,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    var restaurantList = list.restaurants;
    var restaurantTitle = restaurantList[Random().nextInt(restaurantList.length)].name;

    var payload = json.encode({
      'restaurants': list.toJson(),
      'randomIndex': Random().nextInt(restaurantList.length),
    });

    await flutterLocalNotificationsPlugin.show(
      0,
      'MyResto Notification',
      restaurantTitle,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  void configureSelectNotificationSubject(String route, BuildContext context) {
    selectNotificationSubject.stream.listen((String? payload) async {
      if (payload != null) {
        var data = json.decode(payload);
        var restaurantListResult =
        RestaurantListModel.fromJson(data['restaurants']);
        var randomIndex = data['randomIndex'];
        var restaurant = restaurantListResult.restaurants[randomIndex];
        Navigator.of(context).pushNamed(route, arguments: restaurant);
      }
    });
  }
}