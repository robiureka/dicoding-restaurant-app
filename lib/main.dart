import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_submission_1/common/navigation.dart';
import 'package:restaurant_app_submission_1/favourite_restaurant_list.dart';
import 'package:restaurant_app_submission_1/provider/favourite_provider.dart';
import 'package:restaurant_app_submission_1/provider/restaurant_provider.dart';
import 'package:restaurant_app_submission_1/model/restaurant.dart';
import 'package:restaurant_app_submission_1/provider/scheduling_provider.dart';
import 'package:restaurant_app_submission_1/restaurant_detail.dart';
import 'package:restaurant_app_submission_1/restaurant_list_scaffold.dart';
import 'package:restaurant_app_submission_1/service/api_service.dart';
import 'package:restaurant_app_submission_1/common/styles.dart';
import 'package:restaurant_app_submission_1/service/background_service.dart';
import 'package:restaurant_app_submission_1/service/notification_service.dart';
import 'package:restaurant_app_submission_1/service/sqlite_service.dart';
import 'package:restaurant_app_submission_1/settings_page.dart';
import 'package:restaurant_app_submission_1/widgets/no_internet.dart';

final FlutterLocalNotificationsPlugin flnp = FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationService notificationService = NotificationService();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  await AndroidAlarmManager.initialize();
  await notificationService.initNotification(flnp);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => FavouriteProvider(sqLiteService: SQLiteService()),
        ),
        ChangeNotifierProvider(
          create: (_) => SchedulingProvider(),
          child: SettingPage(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primaryColor: primaryColor,
            accentColor: secondaryColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: myTextTheme,
            inputDecorationTheme: InputDecorationTheme()),
        navigatorKey: navigatorKey,
        initialRoute: RestaurantListScaffold.routeName,
        
        routes: {
          NoInterent.routeName: (context) => NoInterent(),
          RestaurantListScaffold.routeName: (context) =>
              RestaurantListScaffold(),
          RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant),
          FavouriteRestaurantList.routeName: (context) =>
              FavouriteRestaurantList(),
        },
      ),
    );
  }
}
