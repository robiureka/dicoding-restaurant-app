import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_submission_1/common/navigation.dart';
import 'package:restaurant_app_submission_1/model/restaurant.dart';
import 'package:restaurant_app_submission_1/model/review.dart';
import 'package:restaurant_app_submission_1/provider/restaurant_provider.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String?>();

class NotificationService {
  static const _channelId = "01";
  static const _channelName = "channel_01";
  static const _channelDesc = "restaurant_robi_channel";
  static NotificationService? _instance;
  
  NotificationService._internal() {
    _instance = this;
  }

  factory NotificationService() => _instance ?? NotificationService._internal();

  Future<void> initNotification(FlutterLocalNotificationsPlugin flnp) async {
    var androidInitializeSettings =
        AndroidInitializationSettings('launch_logo');
    var initializationSettings =
        InitializationSettings(android: androidInitializeSettings);
    await flnp.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        print('notification payload: $payload');
      }
      selectNotificationSubject.add(payload ?? 'empty');
    });
  }



  Future<void> showNotification(FlutterLocalNotificationsPlugin flnp,
      RestaurantResult restaurants) async {
    var androidPlatformChannelSpec = AndroidNotificationDetails(
        _channelId, _channelName, _channelDesc,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: DefaultStyleInformation(true, true));
    var paltformChannelSpec =
        NotificationDetails(android: androidPlatformChannelSpec);
    var notificationTitle = "<b>Restaurant Recommendation</b>";
    var restaurantName = restaurants.restaurant!.name;
    print(jsonEncode(restaurants.toJson()));
    await flnp.show(
      1,
      notificationTitle,
      restaurantName,
      paltformChannelSpec,
      payload: jsonEncode(restaurants.toJson()),
    );
  }

  void configureSelectNotificationSubject(String route, BuildContext context) {
    selectNotificationSubject.stream.listen((String? payload) async {
      var json = jsonDecode(payload!);

      var data = RestaurantResult.detailFromJson(json, json['restaurant']['isFavourited']);
      var restaurant = data.restaurant;
      Provider.of<RestaurantProvider>(context, listen: false).setReviewList = restaurant!.reviews as List<Review>;
      await Navigation.intentWithData(route, restaurant);
    });
  }
}
