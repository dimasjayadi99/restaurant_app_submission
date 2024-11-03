import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:submission_restauirant_app/common/app_style.dart';
import 'package:submission_restauirant_app/provider/database_provider.dart';
import 'package:submission_restauirant_app/provider/add_review_provider.dart';
import 'package:submission_restauirant_app/provider/preference_provider.dart';
import 'package:submission_restauirant_app/provider/restaurant_detail_provider.dart';
import 'package:submission_restauirant_app/provider/restaurant_list_provider.dart';
import 'package:submission_restauirant_app/utils/background_service.dart';
import 'package:submission_restauirant_app/utils/notification_helper.dart';
import 'config/routes.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:permission_handler/permission_handler.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables first
  await dotenv.load(fileName: ".env");

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();
  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });

  await initializeDateFormatting('id_ID', null);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => RestaurantListProvider()),
    ChangeNotifierProvider(create: (context) => RestaurantDetailProvider()),
    ChangeNotifierProvider(create: (context) => AddReviewProvider()),
    ChangeNotifierProvider(create: (context) => DatabaseProvider()),
    ChangeNotifierProvider(create: (context) => PreferenceProvider()),
  ], child: const MyApp()));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(textTheme: AppStyle.textTheme),
      debugShowCheckedModeBanner: false,
      initialRoute: Paths.init,
      routes: appRoutes(),
    );
  }
}
