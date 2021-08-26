import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurant_app_submission_1/restaurant.dart';
import 'package:restaurant_app_submission_1/restaurant_detail.dart';
import 'package:restaurant_app_submission_1/styles.dart';

class RestaurantList extends StatefulWidget {
  final String? filter;
  const RestaurantList({Key? key, this.filter}) : super(key: key);

  @override
  _RestaurantListState createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  List<Restaurant> parseRestaurant(String json) {
    if (json.isEmpty) {
      return [];
    }
    final List parsed = jsonDecode(json);
    return parsed.map((e) => Restaurant.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context)
          .loadString('assets/local_restaurant.json'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        final Map<String, dynamic> data = jsonDecode(snapshot.data!);
        final List<dynamic> restaurantsData = data['restaurants'];
        final List<Restaurant> restaurants;
        widget.filter == ''
            ? restaurants =
                restaurantsData.map((e) => Restaurant.fromJson(e)).toList()
            : restaurants = restaurantsData
                .map((e) => Restaurant.fromJson(e))
                .where((element) {
                final nameLower = element.name.toLowerCase();
                final cityLower = element.city.toLowerCase();
                final filterLower = widget.filter!.toLowerCase();
                return nameLower.contains(filterLower) ||
                    cityLower.contains(filterLower);
              }).toList();
        return restaurants.isEmpty
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
                        itemCount: restaurants.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RestaurantDetailPage.routeName,
                                    arguments: restaurants[index]);
                              },
                              child: _buildRestaurantItem(
                                  context, restaurants[index]));
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

Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    child: Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0)),
              child: Hero(
                tag: restaurant.pictureId,
                child: Container(
                  width: 100,
                  height: 120,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: NetworkImage(
                      restaurant.pictureId,
                    ),
                    fit: BoxFit.fill,
                  )),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                left: 18.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(restaurant.name,
                      style: Theme.of(context).textTheme.headline6!),
                  SizedBox(height: 3.0),
                  Text(
                    restaurant.city,
                    style: Theme.of(context).textTheme.subtitle2!,
                  ),
                  SizedBox(height: 15.0),
                  Row(children: [
                    Icon(
                      Icons.star,
                      color: primaryColor,
                    ),
                    SizedBox(
                      width: 7.0,
                    ),
                    Text(restaurant.rating)
                  ])
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
