import 'package:flutter/material.dart';
import 'package:restaurant_app_submission_1/model/restaurant.dart';


import 'package:restaurant_app_submission_1/common/styles.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;
  const CardRestaurant({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  tag: restaurant.pictureId!,
                  child: Container(
                    width: 100,
                    height: 120,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: NetworkImage(
                        "https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId!}",
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
                    Text(restaurant.name!,
                        style: Theme.of(context).textTheme.headline6!),
                    SizedBox(height: 3.0),
                    Text(
                      restaurant.city!,
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
                      Text(restaurant.rating!)
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
}
