import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_submission_1/common/styles.dart';
import 'package:restaurant_app_submission_1/delegates.dart';
import 'package:restaurant_app_submission_1/model/restaurant.dart';
import 'package:restaurant_app_submission_1/model/review.dart';
import 'package:restaurant_app_submission_1/provider/favourite_provider.dart';
import 'package:restaurant_app_submission_1/provider/restaurant_provider.dart';

class BuildRestaurantDetailHeader extends StatelessWidget {
  final BuildContext context;
  final Restaurant restaurant;
  const BuildRestaurantDetailHeader(
      {Key? key, required this.context, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          restaurant.name!,
          style: Theme.of(context).textTheme.headline5!,
        ),
        SizedBox(
          height: 7.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              restaurant.city!,
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
                Text(restaurant.rating!,
                    style: Theme.of(context).textTheme.headline6)
              ],
            ),
          ],
        ),
        SizedBox(
          height: 7.0,
        ),
        Text(
          restaurant.address!,
          style: Theme.of(context).textTheme.headline6!,
        ),
      ],
    );
  }
}

class BuildRestaurantDetailDescription extends StatelessWidget {
  final BuildContext context;
  final Restaurant restaurant;
  const BuildRestaurantDetailDescription(
      {Key? key, required this.context, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(restaurant.description!,
        style: Theme.of(context).textTheme.bodyText2);
  }
}



class BuildReviewListItems extends StatelessWidget {
  final BuildContext context;
  final List<Review> reviews;
  const BuildReviewListItems(
      {Key? key, required this.context, required this.reviews})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          var review = reviews[index];
          return Container(
            height: 80,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(review.name!),
                    Text(review.date!),
                  ],
                ),
                Text(review.review!),
                Divider(
                  height: 5.0,
                  thickness: 2.0,
                  color: primaryColor,
                ),
              ],
            ),
          );
        });
  }
}

class AddReviewDialog extends StatelessWidget {
  final BuildContext context;
  final Restaurant restaurant;
  final GlobalKey<FormState> formKey;
  const AddReviewDialog({
    Key? key,
    required this.context,
    required this.restaurant,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProvider>(builder: (context, appState, _) {
      return Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              validator: (String? value) {
                if (value == '' || value!.isEmpty) {
                  return 'Please insert your name';
                }
              },
              cursorColor: secondaryColor,
              decoration: InputDecoration(
                hintText: 'Name',
                border: InputBorder.none,
              ),
              onChanged: (String value) {
                appState.setName = value;
              },
            ),
            TextFormField(
              validator: (String? value) {
                if (value == '' || value!.isEmpty) {
                  return 'Please insert your review';
                }
              },
              decoration: InputDecoration(
                hintText: 'Review',
                border: InputBorder.none,
              ),
              onChanged: (String value) {
                appState.setReview = value;
              },
            ),
            SizedBox(
              height: 15.0,
            ),
            ElevatedButton(
              child: Text('Confirm'),
              style: ElevatedButton.styleFrom(
                textStyle: Theme.of(context).textTheme.button,
                primary: secondaryColor,
              ),
              onPressed: () async {
                final isFavourite = Provider.of<FavouriteProvider>(context, listen: false).isFavourite!;
                if (formKey.currentState!.validate()) {
                  await appState.submitReview(restaurant.id!);
                  await appState.getRestaurantDetailData(restaurant.id!, restaurant.isFavourited!);
                  Navigator.pop(context);
                }
              },
            )
          ],
        ),
      );
    });
  }
}
