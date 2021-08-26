import 'package:flutter/material.dart';
import 'package:restaurant_app_submission_1/restaurant_list_widget.dart';
import 'package:restaurant_app_submission_1/styles.dart';

class RestaurantListScaffold extends StatefulWidget {
  static const routeName = '/restaurant_list';
  const RestaurantListScaffold({Key? key}) : super(key: key);

  @override
  _RestaurantListScaffoldState createState() => _RestaurantListScaffoldState();
}

class _RestaurantListScaffoldState extends State<RestaurantListScaffold> {
  String filter = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                                child: Text(
                                  'Restaurants',
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ),
                              Flexible(
                                flex: 5,
                                child: Text(
                                  'Recommendation Restaurant For You',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(child: RestaurantList(filter: this.filter)),
            ],
          )),
    );
  }

  Widget _buildSearchForm(BuildContext context) {
    return TextField(
      onChanged: (String value) {
        setState(() {
          filter = value;
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
  }
}
