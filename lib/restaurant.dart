class Restaurant {
  late String id, name, description, pictureId, city, rating;
  late List foods, drinks;
  late Map<String, dynamic> menus;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.foods,
    required this.drinks,
    required this.menus,
  });

  Restaurant.fromJson(Map<String, dynamic> restaurant) {
    id = restaurant['id'];
    name = restaurant['name'];
    description = restaurant['description'];
    pictureId = restaurant['pictureId'];
    city = restaurant['city'];
    rating = restaurant['rating'].toString();
    menus = restaurant['menus'];
    foods = menus['foods'];
    drinks = menus['drinks'];
  }
}
