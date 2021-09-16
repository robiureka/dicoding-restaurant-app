import 'dart:isolate';

import 'package:restaurant_app_submission_1/model/review.dart';
import 'package:restaurant_app_submission_1/provider/favourite_provider.dart';
import 'package:restaurant_app_submission_1/service/sqlite_service.dart';

class Restaurant {
  String? id, name, description, pictureId, city, rating, address;
  List? foods, drinks, categories, reviews;
  bool? isFavourited;
  Map<String, dynamic>? menus;
  FavouriteProvider _favouriteProvider =
      FavouriteProvider(sqLiteService: SQLiteService());
  Restaurant({
    required this.id,
    required this.name,
    this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    this.isFavourited,
    this.foods,
    this.drinks,
    this.menus,
    this.categories,
    this.address,
    this.reviews,
  });

  Restaurant.fromJson(Map<String, dynamic> restaurant) {
    id = restaurant["id"];
    name = restaurant["name"];
    pictureId = restaurant["pictureId"];
    city = restaurant["city"];
    rating = restaurant["rating"].toString();
    isFavourited = restaurant["isFavourite"] == 1 ? true : false;
  }

  Map<String, dynamic> restaurantToMap(bool isFavourite) {
    return {
      'id': id,
      'name': name,
      'pictureId': pictureId,
      'city': city,
      'rating': rating,
      'isFavourite': isFavourite == true ? 1 : 0
    };
  }

  Restaurant.detailFromJson(Map<String, dynamic> restaurant, bool? isFavourite) {
    id = restaurant["id"];
    name = restaurant["name"];
    description = restaurant["description"];
    pictureId = restaurant["pictureId"];
    city = restaurant["city"];
    rating = restaurant["rating"].toString();
    menus = restaurant["menus"];
    categories = restaurant["categories"];
    address = restaurant["address"];
    foods = restaurant["menus"]["foods"];
    drinks = restaurant["menus"]["drinks"];
    isFavourited = isFavourite;
    reviews = List<Review>.from(
        (restaurant["customerReviews"] as List).map((e) => Review.fromJson(e)));
  }
}

class RestaurantResult {
  String? message;
  bool error;
  int? count, founded;
  List<Restaurant>? restaurantsData;
  Restaurant? restaurant;

  RestaurantResult({
    this.count,
    required this.error,
    this.message,
    this.founded,
    this.restaurantsData,
    this.restaurant,
  });

  factory RestaurantResult.fromJson(Map<String, dynamic> json) {
    return RestaurantResult(
      count: json["count"] ?? 0,
      founded: json["founded"] ?? 0,
      error: json["error"],
      message: json["message"] ?? "Tidak Ada",
      restaurantsData: List<Restaurant>.from(
        (json["restaurants"] as List).map(
          (e) => Restaurant.fromJson(e),
        ),
      ),
    );
  }

  factory RestaurantResult.detailFromJson(Map<String, dynamic> json, bool isFavourite) {
    return RestaurantResult(
      restaurant: Restaurant.detailFromJson(json["restaurant"], isFavourite),
      error: json["error"],
      message: json["message"],
    );
  }
}
