import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app_submission_1/model/restaurant.dart';
import 'package:restaurant_app_submission_1/provider/restaurant_provider.dart';
import 'package:restaurant_app_submission_1/service/api_service.dart';

class MockOfApiService extends Mock implements ApiService {}

const loadRestaurant = {
  "error": false,
  "message": "success",
  "count": 1,
  "restaurants": [
    {
      "id": "s1knt6za9kkfw1e867",
      "name": "Kafe Kita",
      "description":
          "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
      "pictureId": "25",
      "city": "Gorontalo",
      "rating": 4
    }
  ]
};

const Map<String, dynamic> loadRestaurantDetail = {
  "error": false,
  "message": "success",
  "restaurant": {
    "id": "s1knt6za9kkfw1e867",
    "name": "Kafe Kita",
    "description":
        "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
    "city": "Gorontalo",
    "address": "Jln. Pustakawan no 9",
    "pictureId": "25",
    "categories": [
      {"name": "Sop"},
      {"name": "Modern"}
    ],
    "menus": {
      "foods": [
        {"name": "Kari kacang dan telur"},
        {"name": "Ikan teri dan roti"},
        {"name": "roket penne"},
        {"name": "Salad lengkeng"},
        {"name": "Tumis leek"},
        {"name": "Salad yuzu"},
        {"name": "Sosis squash dan mint"}
      ],
      "drinks": [
        {"name": "Jus tomat"},
        {"name": "Minuman soda"},
        {"name": "Jus apel"},
        {"name": "Jus mangga"},
        {"name": "Es krim"},
        {"name": "Kopi espresso"},
        {"name": "Jus alpukat"},
        {"name": "Coklat panas"},
        {"name": "Es kopi"},
        {"name": "Teh manis"},
        {"name": "Sirup"},
        {"name": "Jus jeruk"}
      ]
    },
    "rating": 4,
    "customerReviews": [
      {
        "name": "Ahmad",
        "review": "Tidak ada duanya!",
        "date": "13 November 2019"
      },
      {
        "name": "Arif",
        "review": "Tidak rekomendasi untuk pelajar!",
        "date": "13 November 2019"
      },
      {
        "name": "Gilang",
        "review": "Tempatnya bagus namun menurut saya masih sedikit mahal.",
        "date": "14 Agustus 2018"
      }
    ]
  }
};

const searchedRestaurant = {
  "error": false,
  "founded": 1,
  "restaurants": [
    {
      "id": "s1knt6za9kkfw1e867",
      "name": "Kafe Kita",
      "description":
          "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
      "pictureId": "25",
      "city": "Gorontalo",
      "rating": 4
    }
  ]
};
void main() {
  group('Restaurant Provider Test', () {
    RestaurantProvider? restaurantProvider;
    ApiService? apiService;
    setUp(() {
      apiService = MockOfApiService();
      when(apiService!.loadRestaurant())
          .thenAnswer((_) async => RestaurantResult.fromJson(loadRestaurant));
      restaurantProvider = RestaurantProvider(apiService: apiService!);
    });
    test('verify that fetching all restaurant data JSON to Restaurant Model',
        () {
      print(restaurantProvider!.restaurantsList);
      var result = restaurantProvider!.restaurantsList[0];
      print(result.name);
      List<Map<String, dynamic>> restaurantData =
          loadRestaurant['restaurants'] as List<Map<String, dynamic>>;
      var restaurantModel = Restaurant.fromJson(restaurantData[0]);
      expect(result.id == restaurantModel.id, true);
      expect(result.name == restaurantModel.name, true);
      expect(result.description == restaurantModel.description, true);
      expect(result.pictureId == restaurantModel.pictureId, true);
      expect(result.city == restaurantModel.city, true);
      expect(result.rating == restaurantModel.rating, true);
    });
    test('verify that fetching searched restaurants JSON data run as expected',
        () async {
      when(apiService!.searchRestaurant('kafe')).thenAnswer(
          (_) async => RestaurantResult.fromJson(searchedRestaurant));
      var result = restaurantProvider!.restaurantsList[0];
      List<Map<String, dynamic>> restaurantData =
          loadRestaurant['restaurants'] as List<Map<String, dynamic>>;
      var restaurantModel = Restaurant.fromJson(restaurantData[0]);
      expect(result.id == restaurantModel.id, true);
      expect(result.name == restaurantModel.name, true);
      expect(result.description == restaurantModel.description, true);
      expect(result.pictureId == restaurantModel.pictureId, true);
      expect(result.city == restaurantModel.city, true);
      expect(result.rating == restaurantModel.rating, true);
    });

    test('verify that fetching restaurant detail JSON data run as expected',
        () async {
      Map<String, dynamic> restaurantData = loadRestaurantDetail['restaurant'];
      var id = restaurantData['id'];
      bool isFavourite =
          await apiService!.getIsFavouriteFromSqlite(id) ?? false;
      when(apiService!.loadRestaurantDetail(id)).thenAnswer((_) async =>
          RestaurantResult.detailFromJson(loadRestaurantDetail, isFavourite));
      Restaurant result = restaurantProvider!.restaurantsList[0];
      var restaurantDetailModel =
          Restaurant.detailFromJson(restaurantData, isFavourite);
      expect(result.id == restaurantDetailModel.id, true);
      expect(result.name == restaurantDetailModel.name, true);
      expect(result.description == restaurantDetailModel.description, true);
      expect(result.pictureId == restaurantDetailModel.pictureId, true);
      expect(result.city == restaurantDetailModel.city, true);
      expect(result.rating == restaurantDetailModel.rating, true);
    });
  });
}
