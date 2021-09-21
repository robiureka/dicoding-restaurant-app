import 'package:flutter/foundation.dart';
import 'package:restaurant_app_submission_1/model/restaurant.dart';
import 'package:restaurant_app_submission_1/provider/restaurant_provider.dart';
import 'package:restaurant_app_submission_1/service/api_service.dart';
import 'package:restaurant_app_submission_1/service/sqlite_service.dart';

class FavouriteProvider extends ChangeNotifier {
  List<Restaurant> _favouriteRestaurantList = [];
  bool? _isFavourited = false;

  final SQLiteService sqLiteService;
  RestaurantProvider _restaurantProvider =
      RestaurantProvider(apiService: ApiService());
  List<Restaurant> get favouriteRestaurantList => _favouriteRestaurantList;
  bool? get isFavourite => _isFavourited;
  set setIsFavourite(bool value) => _isFavourited = value;
  FavouriteProvider({required this.sqLiteService}){
    getFavouriteRestaurantList();
  }

  Future<void> insertFavouriteRestaurant(Restaurant restaurant, bool isFavourite) async {
    await sqLiteService.addFavouriteRestaurant(restaurant, isFavourite);
    getFavouriteRestaurantList();
  }

  void deleteFavouriteRestaurant(String id) async {
    await sqLiteService.deleteFavouriteRestaurantById(id);
    getFavouriteRestaurantList();
  }

  void getFavouriteRestaurantList() async {
    _favouriteRestaurantList = await sqLiteService.getAllFavouriteRestaurant();
    notifyListeners();
  }

  Future<dynamic> getRestaurantDetailFromFavourite(String id, bool isFavourite) async {
    var result = await _restaurantProvider.getRestaurantDetailData(id, isFavourite);
    return result;
  }
}
