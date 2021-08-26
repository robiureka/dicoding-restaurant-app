import 'package:flutter/material.dart';
import 'package:restaurant_app_submission_1/restaurant.dart';
import 'package:restaurant_app_submission_1/restaurant_detail.dart';
import 'package:restaurant_app_submission_1/restaurant_list_scaffold.dart';
import 'package:restaurant_app_submission_1/styles.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: primaryColor,
          accentColor: secondaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: myTextTheme,
          inputDecorationTheme: InputDecorationTheme()),
      initialRoute: RestaurantListScaffold.routeName,
      routes: {
        RestaurantListScaffold.routeName: (context) => RestaurantListScaffold(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
            restaurant:
                ModalRoute.of(context)?.settings.arguments as Restaurant)
      },
    );
  }
}
