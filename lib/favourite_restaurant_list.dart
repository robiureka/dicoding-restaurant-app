import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_submission_1/provider/favourite_provider.dart';
import 'package:restaurant_app_submission_1/model/restaurant.dart';
import 'package:restaurant_app_submission_1/restaurant_detail.dart';
import 'package:restaurant_app_submission_1/widgets/card_restaurant.dart';

class FavouriteRestaurantList extends StatefulWidget {
  static String routeName = '/favourite_restaurant_list';
  const FavouriteRestaurantList({Key? key}) : super(key: key);

  @override
  _FavouriteRestaurantListState createState() =>
      _FavouriteRestaurantListState();
}

class _FavouriteRestaurantListState extends State<FavouriteRestaurantList> {
  List<Restaurant>? _favouriterestaurantList;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<FavouriteProvider>(
        builder: (context, appState, _) {
          _favouriterestaurantList = appState.favouriteRestaurantList;
          return _favouriterestaurantList!.isEmpty
              ? Center(
                  child: Text(
                  'Tidak ada restaurant favorit',
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
                          itemCount: _favouriterestaurantList!.length,
                          itemBuilder: (context, index) {
                            var restaurant = _favouriterestaurantList![index];
                            dynamic restaurantDetail;
                            print(_favouriterestaurantList);
                            print(_favouriterestaurantList![0].isFavourited);
                            return InkWell(
                                onTap: () async {
                                  restaurantDetail = await appState
                                      .getRestaurantDetailFromFavourite(
                                          restaurant.id!,
                                          restaurant.isFavourited!);
                                  print(restaurantDetail);
                                  print(restaurantDetail!.isFavourited);
                                  Navigator.pushNamed(
                                    context,
                                    RestaurantDetailPage.routeName,
                                    arguments: restaurantDetail,
                                  );
                                },
                                child: CardRestaurant(restaurant: restaurant));
                          },
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
