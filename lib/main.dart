import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_submission_1/favourite_restaurant_list.dart';
import 'package:restaurant_app_submission_1/provider/favourite_provider.dart';
import 'package:restaurant_app_submission_1/provider/restaurant_provider.dart';
import 'package:restaurant_app_submission_1/model/restaurant.dart';
import 'package:restaurant_app_submission_1/restaurant_detail.dart';
import 'package:restaurant_app_submission_1/restaurant_list_scaffold.dart';
import 'package:restaurant_app_submission_1/service/api_service.dart';
import 'package:restaurant_app_submission_1/common/styles.dart';
import 'package:restaurant_app_submission_1/service/sqlite_service.dart';
import 'package:restaurant_app_submission_1/widgets/no_internet.dart';

void main() {
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
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primaryColor: primaryColor,
            accentColor: secondaryColor,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: myTextTheme,
            inputDecorationTheme: InputDecorationTheme()),
        initialRoute: RestaurantListScaffold.routeName,
        routes: {
          NoInterent.routeName: (context) => NoInterent(),
          RestaurantListScaffold.routeName: (context) => RestaurantListScaffold(),
          RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(restaurant:ModalRoute.of(context)?.settings.arguments as Restaurant),
          FavouriteRestaurantList.routeName: (context) => FavouriteRestaurantList(),
        },
      ),
    );
  }
}
