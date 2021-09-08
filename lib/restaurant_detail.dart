import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_submission_1/delegates.dart';
import 'package:restaurant_app_submission_1/model/restaurant.dart';
import 'package:restaurant_app_submission_1/model/review.dart';
import 'package:restaurant_app_submission_1/provider/restaurant_provider.dart';
import 'package:restaurant_app_submission_1/common/styles.dart';

class RestaurantDetailPage extends StatefulWidget {
  static final routeName = '/restaurant_detail';
  final Restaurant restaurant;
  const RestaurantDetailPage({Key? key, required this.restaurant})
      : super(key: key);

  @override
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  List<Review> _reviewList = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _reviewList =
        Provider.of<RestaurantProvider>(context, listen: true).reviewList;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height + 400,
            width: MediaQuery.of(context).size.width,
            child:
                Consumer<RestaurantProvider>(builder: (context, appState, _) {
              if (appState.state == ResultState.DetailLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (appState.state == ResultState.DetailNoData) {
                return Center(
                  child: Text(appState.message),
                );
              } else if (appState.state == ResultState.DetailError) {
                return Center(
                  child: Text(appState.message),
                );
              }
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    flex: 5,
                    fit: FlexFit.tight,
                    child: Stack(
                      children: [
                        Hero(
                            tag: widget.restaurant.pictureId!,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(18.0),
                                  bottomRight: Radius.circular(18.0)),
                              child: Image.network(
                                "https://restaurant-api.dicoding.dev/images/large/${widget.restaurant.pictureId!}",
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
                              flex: 3,
                              child: _buildHeader(context, widget.restaurant)),
                          SizedBox(
                            height: 20.0,
                          ),
                          Flexible(
                              flex: 5,
                              fit: FlexFit.tight,
                              child: _buildDescription(
                                  context, widget.restaurant)),
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
                                  children: widget.restaurant.foods!
                                      .map((e) => ListTile(
                                            title: Text(e['name']),
                                          ))
                                      .toList(),
                                ),
                                _header(context, 'drinks'),
                                SliverGrid.count(
                                    crossAxisCount: 2,
                                    childAspectRatio: 4.0,
                                    children:
                                        widget.restaurant.drinks!.map((e) {
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
                  ),
                  Flexible(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Reviews',
                                  style: Theme.of(context).textTheme.headline5,
                                  textAlign: TextAlign.start,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: Text(
                                                'Add Review',
                                                textAlign: TextAlign.center,
                                              ),
                                              content: _buildAddReviewDialog(
                                                  context,
                                                  widget.restaurant,
                                                  _formKey),
                                            ));
                                  },
                                  child: Text('Add Review'),
                                  style: ElevatedButton.styleFrom(
                                      primary: secondaryColor,
                                      textStyle:
                                          Theme.of(context).textTheme.button),
                                )
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Divider(
                              height: 5.0,
                              thickness: 2.0,
                              color: primaryColor,
                            ),
                            Flexible(
                                flex: 4,
                                child: _buildReviewItem(context, _reviewList))
                          ],
                        ),
                      )),
                ],
              );
            }),
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

Widget _buildDescription(BuildContext context, Restaurant restaurant) {
  return Text(restaurant.description!,
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

Widget _buildReviewItem(BuildContext context, List<Review> reviews) {
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

Widget _buildAddReviewDialog(
    BuildContext context, Restaurant restaurant, GlobalKey<FormState> formKey) {
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
              if (formKey.currentState!.validate()) {
                await appState.submitReview(restaurant.id!);
                await appState.getRestaurantDetailData(restaurant.id!);
                Navigator.pop(context);
              }
            },
          )
        ],
      ),
    );
  });
}
