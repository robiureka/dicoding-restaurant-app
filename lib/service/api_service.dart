import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app_submission_1/model/restaurant.dart';

class ApiService {
  ApiService();
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev';
  static final String _category = '/list';
  Future<RestaurantResult> loadRestaurant() async {
    final response = await http.get(Uri.parse(_baseUrl + _category));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception("The Restaurant Data Can't be loaded");
    }
  }

  Future<RestaurantResult> loadRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));
    if (response.statusCode == 200) {
      return RestaurantResult.detailFromJson(json.decode(response.body));
    } else {
      throw Exception("The Restaurant Detail Data Can't be loaded");
    }
  }

  Future<RestaurantResult> searchRestaurant(String filter) async {
    final response = await http.get(Uri.parse("$_baseUrl/search?q=$filter"));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception("The Searched Restaurant Can't be Loaded");
    }
  }

  Future<void> requestReview(String name, String review, String id) async {
    await http.post(
      Uri.parse("$_baseUrl/review"),
      headers: {"Content-Type": "application/json", "X-Auth-Token": "12345"},
      body: jsonEncode({"id": id, "name": name, "review": review}),
    );
  }
}
