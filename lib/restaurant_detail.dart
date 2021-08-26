import 'package:flutter/material.dart';
import 'package:restaurant_app_submission_1/delegates.dart';
import 'package:restaurant_app_submission_1/restaurant.dart';
import 'package:restaurant_app_submission_1/styles.dart';

class RestaurantDetailPage extends StatelessWidget {
  static final routeName = '/restaurant_detail';
  final Restaurant restaurant;
  const RestaurantDetailPage({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height + 200,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  flex: 5,
                  fit: FlexFit.loose,
                  child: Stack(
                    children: [
                      Hero(
                          tag: restaurant.pictureId,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25.0),
                                bottomRight: Radius.circular(25.0)),
                            child: Image.network(
                              restaurant.pictureId,
                              fit: BoxFit.cover,
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back)),
                          backgroundColor: primaryColor,
                          foregroundColor: blackText,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Flexible(
                  flex: 8,
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 15.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                            fit: FlexFit.loose,
                            flex: 2,
                            child: _buildHeader(context, restaurant)),
                        SizedBox(
                          height: 20.0,
                        ),
                        Flexible(
                            flex: 5,
                            fit: FlexFit.tight,
                            child: _buildDescription(context, restaurant)),
                        SizedBox(
                          height: 15.0,
                        ),
                        Flexible(
                          flex: 6,
                          fit: FlexFit.loose,
                          child: CustomScrollView(
                            shrinkWrap: true,
                            slivers: [
                              _header(context, 'foods'),
                              SliverGrid.count(
                                crossAxisCount: 2,
                                childAspectRatio: 4.0,
                                children: restaurant.foods
                                    .map((e) => ListTile(
                                          title: Text(e['name']),
                                        ))
                                    .toList(),
                              ),
                              _header(context, 'drinks'),
                              SliverGrid.count(
                                  crossAxisCount: 2,
                                  childAspectRatio: 4.0,
                                  children: restaurant.drinks.map((e) {
                                    return ListTile(
                                      title: Text(e['name']),
                                    );
                                  }).toList()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildHeader(BuildContext context, Restaurant restaurant) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(
        restaurant.name,
        style: Theme.of(context).textTheme.headline5!,
      ),
      SizedBox(
        height: 7.0,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            restaurant.city,
            style: Theme.of(context).textTheme.headline6!,
          ),
          Row(
            children: [
              Icon(
                Icons.star,
                color: primaryColor,
              ),
              SizedBox(
                width: 8.0,
              ),
              Text(restaurant.rating,
                  style: Theme.of(context).textTheme.headline6)
            ],
          )
        ],
      ),
      SizedBox(
        height: 7.0,
      ),
    ],
  );
}

Widget _buildDescription(BuildContext context, Restaurant restaurant) {
  return Text(restaurant.description,
      style: Theme.of(context).textTheme.bodyText2);
}

SliverPersistentHeader _header(BuildContext context, String text) {
  return SliverPersistentHeader(
    delegate: SliverAppBarDelegate(
        minHeight: 40,
        maxHeight: 50,
        child: Container(
          color: primaryColor,
          child: Center(
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: blackText),
            ),
          ),
        )),
    pinned: true,
  );
}
