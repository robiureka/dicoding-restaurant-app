import 'dart:isolate';
import 'dart:math';

import 'dart:ui';

import 'package:restaurant_app_submission_1/main.dart';
import 'package:restaurant_app_submission_1/provider/restaurant_provider.dart';
import 'package:restaurant_app_submission_1/service/api_service.dart';
import 'package:restaurant_app_submission_1/service/notification_service.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static String _isolateName = 'isolate';
  static BackgroundService? _service;
  static SendPort? _uiSendPort;
  RestaurantProvider restProvider = new RestaurantProvider(apiService: ApiService());
  BackgroundService._createObject();

  factory BackgroundService() {
    if (_service == null) {
      _service = BackgroundService._createObject();
    }
    return _service!;
  }

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
  }

  static Future<int> getRandomRestaurantIndex() async {
    var result = await ApiService().loadRestaurant();
    var dataCount = result!.count;
    Random random = new Random();
    int randomNumber = random.nextInt(dataCount!);
    return randomNumber;
  }

  static  Future<void> callback() async {
    print('Alarm Fired');
    final NotificationService notificationService = NotificationService();
    var dataList = await ApiService().loadRestaurant();
    var randomNumber = await getRandomRestaurantIndex();
    var data = await ApiService().loadRestaurantDetail(
        dataList!.restaurantsData![randomNumber].id!);
        
    await notificationService.showNotification(flnp, data!);
    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }

  Future<void> someTask() async {
    print('Execute some process');
  }
}
