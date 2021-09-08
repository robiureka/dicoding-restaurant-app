import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_submission_1/home.dart';
import 'package:restaurant_app_submission_1/provider/restaurant_provider.dart';
import 'package:restaurant_app_submission_1/widgets/no_internet.dart';

class RestaurantListScaffold extends StatefulWidget {
  static const routeName = '/restaurant_list';
  const RestaurantListScaffold({Key? key}) : super(key: key);

  @override
  _RestaurantListScaffoldState createState() => _RestaurantListScaffoldState();
}

class _RestaurantListScaffoldState extends State<RestaurantListScaffold> {
  @override
  void initState() {
    super.initState();
Provider.of<RestaurantProvider>(context, listen: false)
        .connectivityMonitoring();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<RestaurantProvider>(builder: (context, appState, _) {
        if (appState.isOnline != null) {
          return appState.isOnline! ? Home() : NoInterent();
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
