import 'dart:ui';

class AppConst {
  AppConst._();

  // text
  static const String appName = "MyResto";
  static const String creator = "Dimas Jayadi";
  static const String welcomingText = "Find your favorite restaurant!";
  static const String searchText = "Type to search...";
  static const String dataNotFound = "No restaurants found";
  static const String imageError = "Image Error";
  static const String noInternetConnection = "No internet connection";
  static const String successAddReview = "Success add a new review";
  static const String notificationKey = 'notification';
  static const String favoriteSuccessAdd = "Added to favorites successfully";
  static const String favoriteSuccessRemove = "Removed from favorites";
  static const String favoriteFailedAdd = "Failed to add to favorites";
  static const String favoriteFailedRemove = "Failed to remove from favorites";
  static const String notificationEnable = "Daily Notification Enable";
  static const String notificationDisable = "Daily Notification Disable";

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
