import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_submission_1/home_page.dart';
import 'package:restaurant_app_submission_1/provider/scheduling_provider.dart';
import 'package:restaurant_app_submission_1/restaurant_detail.dart';
import 'package:restaurant_app_submission_1/service/notification_service.dart';
import 'package:restaurant_app_submission_1/settings_page.dart';

import 'common/styles.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final NotificationService _notificationService = NotificationService();
  int _currentIndex = 0;
  final screens = [
    HomePage(),
    ChangeNotifierProvider<SchedulingProvider>(
      create: (_) => SchedulingProvider(),
      child: SettingPage(),
    ),
  ];
  @override
  void initState() {
    super.initState();
    _notificationService
        .configureSelectNotificationSubject(RestaurantDetailPage.routeName, context);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: primaryColor,
            selectedItemColor: secondaryColor,
            unselectedItemColor: blackText,
            showUnselectedLabels: false,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ]),
        resizeToAvoidBottomInset: false,
        body: IndexedStack(
          index: _currentIndex,
          children: screens,
        ));
  }
}


