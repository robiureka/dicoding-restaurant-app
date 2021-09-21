import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app_submission_1/model/restaurant.dart';
import 'package:restaurant_app_submission_1/service/api_service.dart';

void main(){
  test('should receive JSON Object to Restaurant Class Model', () async {
    var apiService = ApiService();
    var result = await apiService.loadRestaurant();
    List<Restaurant> restaurantList = result.restaurantsData!;
    var expected = restaurantList[0].name!.contains('Melting Pot');
    expect(expected, true);
  });
}