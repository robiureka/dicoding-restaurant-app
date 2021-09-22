import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app_submission_1/service/background_service.dart';
import 'package:restaurant_app_submission_1/service/date_time_service.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;
  bool get isScheduled => _isScheduled;
  Future<bool> scheduledRestaurant(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      print('Scheduled Restaurant Active');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeService.format(),
        exact: true,
        wakeup: true,
      );

    } else{
      print('Scheduled Restaurant Deactivated');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
