import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_submission_1/delegates.dart';
import 'package:restaurant_app_submission_1/model/restaurant.dart';
import 'package:restaurant_app_submission_1/model/review.dart';
import 'package:restaurant_app_submission_1/provider/favourite_provider.dart';
import 'package:restaurant_app_submission_1/provider/restaurant_provider.dart';
import 'package:restaurant_app_submission_1/common/styles.dart';
import 'package:restaurant_app_submission_1/utils/result_state.dart';
import 'package:restaurant_app_submission_1/widgets/restaurant_detail_custom_widget.dart'
    as resDetail;

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
                          child: Consumer<FavouriteProvider>(
                            builder: (context, favState, _) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(Icons.arrow_back)),
                                  backgroundColor: primaryColor,
                                  foregroundColor: blackText,
                                ),
                                CircleAvatar(
                                  child: IconButton(
                                      onPressed: () async {
                                        if (widget.restaurant.isFavourited ==
                                            false) {
                                          favState.setIsFavourite = true;
                                          final restaurant = Restaurant(
                                            id: widget.restaurant.id,
                                            city: widget.restaurant.city,
                                            rating: widget.restaurant.rating,
                                            pictureId:
                                                widget.restaurant.pictureId,
                                            name: widget.restaurant.name,
                                            isFavourited: favState.isFavourite,
                                          );
                                          print(favState.isFavourite!);
                                          if (favState.isFavourite!) {
                                            await favState
                                                .insertFavouriteRestaurant(
                                                    restaurant,
                                                    favState.isFavourite!);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "You Added Favourite Restaurant",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1,
                                                ),
                                                backgroundColor: primaryColor,
                                              ),
                                            );
                                            widget.restaurant.isFavourited =
                                                true;
                                          }
                                        } else {
                                          favState.deleteFavouriteRestaurant(
                                              widget.restaurant.id!);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                              "You Removed Favourite Restaurant",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1!.copyWith(color: whiteText),
                                            ),
                                            backgroundColor: secondaryColor,
                                          ));
                                          widget.restaurant.isFavourited =
                                              false;
                                        }
                                      },
                                      icon: widget.restaurant.isFavourited ==
                                              false
                                          ? Icon(Icons.favorite_outline)
                                          : Icon(Icons.favorite)),
                                  backgroundColor: primaryColor,
                                  foregroundColor: secondaryColor,
                                ),
                              ],
                            ),
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
                              child: resDetail.BuildRestaurantDetailHeader(
                                  context: context,
                                  restaurant: widget.restaurant)),
                          SizedBox(
                            height: 20.0,
                          ),
                          Flexible(
                              flex: 5,
                              fit: FlexFit.tight,
                              child: resDetail.BuildRestaurantDetailDescription(
                                  context: context,
                                  restaurant: widget.restaurant)),
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
                                              content:
                                                  resDetail.AddReviewDialog(
                                                      context: context,
                                                      restaurant:
                                                          widget.restaurant,
                                                      formKey: _formKey),
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
                              child: resDetail.BuildReviewListItems(
                                context: context,
                                reviews: _reviewList,
                              ),
                            )
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
