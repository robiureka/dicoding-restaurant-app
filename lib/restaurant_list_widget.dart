import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_submission_1/provider/favourite_provider.dart';
import 'package:restaurant_app_submission_1/provider/restaurant_provider.dart';
import 'package:restaurant_app_submission_1/model/restaurant.dart';
import 'package:restaurant_app_submission_1/restaurant_detail.dart';
import 'package:restaurant_app_submission_1/utils/result_state.dart';
import 'package:restaurant_app_submission_1/widgets/card_restaurant.dart';

class RestaurantList extends StatefulWidget {
  const RestaurantList({Key? key}) : super(key: key);

  @override
  _RestaurantListState createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  List<Restaurant>? _restaurantList;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, appState, _) {
        if (appState.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (appState.state == ResultState.NoData) {
          return Center(
            child: Text(appState.message),
          );
        } else if (appState.state == ResultState.Error) {
          return Center(child: Text(appState.message));
        }
        _restaurantList = appState.restaurantsList;
        _restaurantList!.where((element) {
          final filterLower = appState.filter.toLowerCase();
          final nameLower = element.name!.toLowerCase();
          return nameLower.contains(filterLower);
        });
        return _restaurantList!.isEmpty
            ? Center(
                child: Text(
                'Tidak ada data dengan kata kunci tersebut',
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ))
            : Column(
                children: [
                  Expanded(
                    flex: 10,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: ListView.builder(
                        itemCount: _restaurantList!.length,
                        itemBuilder: (context, index) {
                          var restaurant = _restaurantList![index];
                          return Consumer<FavouriteProvider>(
                            builder: (context, favState, _) => InkWell(
                                onTap: () async {
                                  await appState.getRestaurantDetailData(
                                      restaurant.id!, restaurant.isFavourited!);
                                  print(appState.restaurant);
                                  print(restaurant.isFavourited);
                                 Navigator.pushNamed(
                                   context,
                                    RestaurantDetailPage.routeName,
                                    arguments: appState.restaurant!,
                                  );
                                },
                                child: CardRestaurant(restaurant: restaurant)),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
      },
    );
  }
}
