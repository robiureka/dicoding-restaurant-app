import 'package:intl/intl.dart';

class DateTimeService {
  static DateTime format(){
    final now = DateTime.now();
    final dateFormat = DateFormat('y/M/d');
    final timeSpecific = '00:45:00';
    final completeFormat = DateFormat('y/M/d H:m:s');

    final todayDate = dateFormat.format(now);
    final todayDateAndTime = '$todayDate $timeSpecific';
    var resultToday = completeFormat.parseStrict(todayDateAndTime);

    var formatted = resultToday.add(Duration(minutes: 5));
    final tomorrowDate = dateFormat.format(formatted);
    final tomorrowDateAndTime = '$tomorrowDate $timeSpecific';
    var resultTomorrow = completeFormat.parseStrict(tomorrowDateAndTime);

    return now.isAfter(resultToday) ? resultTomorrow : resultToday;
  }
}