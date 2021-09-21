import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_app_submission_1/model/restaurant.dart';
import 'package:restaurant_app_submission_1/model/review.dart';
import 'package:restaurant_app_submission_1/service/api_service.dart';
import 'package:restaurant_app_submission_1/service/sqlite_service.dart';
import 'package:restaurant_app_submission_1/utils/result_state.dart';

class RestaurantProvider extends ChangeNotifier {
  final Connectivity _connectivity = new Connectivity();
  final ApiService apiService;
  final SQLiteService sqLiteService = SQLiteService();
  RestaurantResult? _restaurantsResult;
  String _message = '', _filter = '', _review = '', _name = '';
  ResultState? _state;
  Restaurant? _restaurant;
  bool? _isOnline;

  RestaurantProvider({required this.apiService});

  RestaurantResult? get result => _restaurantsResult;
  ResultState? get state => _state;
  String get message => _message;
  Restaurant? get restaurant => _restaurant;
  String get filter => _filter;
  String get review => _review;
  String get name => _name;
  bool? get isOnline => _isOnline;

  set setFilter(String value) => _filter = value;
  set setReview(String value) => _review = value;
  set setName(String value) => _name = value;

  List<Restaurant> _restaurantsList = [];
  List<Restaurant> get restaurantsList => _restaurantsList;
  List<Review> _reviewList = [];
  List<Review> get reviewList => _reviewList;
  set setReviewList(List<Review> review) {
    _reviewList = review;
    notifyListeners();
  }

  connectivityMonitoring() async {
    await initConnections();
    _connectivity.onConnectivityChanged.listen((result) async {
      if (result == ConnectivityResult.none) {
        _isOnline = false;
        notifyListeners();
      } else {
        await _updateConnectivityStatus().then((bool isConnected) {
          _isOnline = isConnected;
          getAllRestaurantData();
          notifyListeners();
        });
      }
    });
  }

  Future<dynamic> getAllRestaurantData() async {
    try {
      _state = ResultState.Loading;
      final restaurants = await apiService.loadRestaurant();
      notifyListeners();
      if (restaurants.restaurantsData!.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = "No Restaurant Data";
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantsList = restaurants.restaurantsData!;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> getRestaurantDetailData(String id, bool isFavourite) async {
    try {
      _state = ResultState.DetailLoading;
      final restaurantsResult = await apiService.loadRestaurantDetail(id);
      notifyListeners();
      if (restaurantsResult.restaurant == null) {
        _state = ResultState.DetailNoData;
        notifyListeners();
        return _message = "No Restaurant Data";
      } else {
        _state = ResultState.DetailHasData;
        _reviewList = restaurantsResult.restaurant!.reviews! as List<Review>;
        notifyListeners();
        return _restaurant = restaurantsResult.restaurant;
      }
    } catch (e) {
      _state = ResultState.DetailError;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> getSearchedRestaurantData(String filter) async {
    try {
      _state = ResultState.Loading;
      final restaurantsResult = await apiService.searchRestaurant(filter);
      notifyListeners();
      if (restaurantsResult.restaurantsData == null) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = "No Restaurant Data";
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantsList = restaurantsResult.restaurantsData!;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<void> initConnections() async {
    try {
      var status = await _connectivity.checkConnectivity();
      if (status == ConnectivityResult.none) {
        _isOnline = false;
        notifyListeners();
      } else {
        _isOnline = true;
        notifyListeners();
      }
    } on PlatformException catch (e) {
      print("PlatformException : " + e.toString());
    }
  }

  Future<bool> _updateConnectivityStatus() async {
    bool isConnected = false;
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } on SocketException catch (_) {
      isConnected = false;
    }
    return isConnected;
  }

  Future<void> submitReview(String id) async {
    await apiService.requestReview(name, review, id);
  }
}
