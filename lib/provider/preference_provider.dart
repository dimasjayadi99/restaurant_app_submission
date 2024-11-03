import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:submission_restauirant_app/utils/background_service.dart';

import '../common/app_const.dart';

class PreferenceProvider extends ChangeNotifier {

  bool _isNotificationEnable = false;
  bool get isNotificationEnable => _isNotificationEnable;
  String _message = "";
  String get message => _message;

  Future<void> setNotification(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConst.notificationKey, value);
    _isNotificationEnable = value;
    notifyListeners();
  }

  Future<void> getValueNotification() async {
    final prefs = await SharedPreferences.getInstance();
    _isNotificationEnable = prefs.getBool(AppConst.notificationKey) ?? false;
    notifyListeners();
  }

  Future<bool> dailyNotification(bool value) async {
    _isNotificationEnable = value;
    if (_isNotificationEnable) {
      notifyListeners();
      DateTime now = DateTime.now();
      DateTime scheduledTime = DateTime(now.year, now.month, now.day, 11, 00, 0);

      if (now.isAfter(scheduledTime)) {
        scheduledTime = scheduledTime.add(const Duration(days: 1));
      }

      _message = AppConst.notificationEnable;

      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: scheduledTime,
        exact: true,
        wakeup: true,
      );
    } else {
      _message = AppConst.notificationDisable;
      notifyListeners();
      return AndroidAlarmManager.cancel(1);
    }
  }
}
