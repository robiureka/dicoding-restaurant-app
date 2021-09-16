import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_submission_1/favourite_restaurant_list.dart';
import 'package:restaurant_app_submission_1/provider/restaurant_provider.dart';
import 'package:restaurant_app_submission_1/restaurant_list_widget.dart';
import 'package:restaurant_app_submission_1/utils/debounce.dart';

import 'common/styles.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              color: primaryColor,
              height: 150,
              child: Column(
                children: [
                  Flexible(
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 15.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: _buildSearchForm(context)),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Flexible(
                              flex: 5,
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context,
                                        FavouriteRestaurantList.routeName);
                                  },
                                  child: Text('Favourite Restaurant')),
                            ),
                            Flexible(
                              flex: 5,
                              child: Text(
                                'Restaurants',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ),
                            Flexible(
                              flex: 5,
                              child: Column(
                                children: [
                                  Text(
                                    'Recommendation Restaurant For You',
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: RestaurantList()),
          ],
        ));
  }
}

Widget _buildSearchForm(BuildContext context) {
  return Consumer<RestaurantProvider>(builder: (context, appState, _) {
    return TextField(
      onChanged: (String value) async {
        debounce(() async {
          appState.setFilter = value;
          appState.getSearchedRestaurantData(appState.filter);
        });
      },
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: blackText,
          ),
          hintText: 'Search...',
          hintStyle: TextStyle(color: blackText),
          filled: true,
          fillColor: whiteText,
          border: InputBorder.none,
          focusColor: secondaryColor),
      cursorColor: secondaryColor,
      style: TextStyle(color: blackText),
    );
  });
}
