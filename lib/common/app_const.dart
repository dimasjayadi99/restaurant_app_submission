import 'dart:ui';

class AppConst {
  AppConst._();

  // text
  static const String appName = "MyResto";
  static const String creator = "Dimas Jayadi";
  static const String welcomingText = "Recommendation restaurant for you!";
  static const String searchText = "Type to search...";
  static const String dataNotFound = "No restaurants found.";
  static const String imageError = "Image Error";

  // color
  static const Color primaryColor = Color(0xFF8BC34A);
  static const Color secondaryColor = Color(0xFFF5F5DC);

  // assets
  static const String defaultImageRestaurant =
      "assets/images/default_restaurant.png";
  static const String jsonPath = "assets/json/local_restaurant.json";
  static const String baseImagePath =
      "https://restaurant-api.dicoding.dev/images/medium/";
}
