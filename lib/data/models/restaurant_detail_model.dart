import 'package:submission_restauirant_app/data/models/restaurant_list_model.dart';

class RestaurantDetailModel {
  final bool error;
  final String message;
  final RestaurantDetail restaurant;

  RestaurantDetailModel({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory RestaurantDetailModel.fromJson(Map<String, dynamic> json) {
    return RestaurantDetailModel(
      error: json['error'],
      message: json['message'],
      restaurant: RestaurantDetail.fromJson(json['restaurant']),
    );
  }
}

class RestaurantDetail {
  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  final List<Category> categories;
  final Menus menus;
  final double rating;
  final List<CustomerReview> customerReviews;

  RestaurantDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) {
    var categoryList = json['categories'] as List;
    var menusData = json['menus'] as Map<String, dynamic>;
    var customerReviewsList = json['customerReviews'] as List;

    return RestaurantDetail(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      city: json['city'],
      address: json['address'],
      pictureId: json['pictureId'],
      categories: categoryList.map((i) => Category.fromJson(i)).toList(),
      menus: Menus.fromJson(menusData),
      rating: json['rating'].toDouble(),
      customerReviews:
          customerReviewsList.map((i) => CustomerReview.fromJson(i)).toList(),
    );
  }

  Restaurant toRestaurant() {
    return Restaurant(
      id: id,
      name: name,
      description: description,
      pictureId: pictureId,
      city: city,
      rating: rating,
    );
  }
}

class Category {
  final String name;

  Category({required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(name: json['name']);
  }
}

class Menus {
  final List<Food> foods;
  final List<Drink> drinks;

  Menus({required this.foods, required this.drinks});

  factory Menus.fromJson(Map<String, dynamic> json) {
    var foodsList = json['foods'] as List;
    var drinksList = json['drinks'] as List;

    return Menus(
      foods: foodsList.map((i) => Food.fromJson(i)).toList(),
      drinks: drinksList.map((i) => Drink.fromJson(i)).toList(),
    );
  }
}

class Food {
  final String name;

  Food({required this.name});

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(name: json['name']);
  }
}

class Drink {
  final String name;

  Drink({required this.name});

  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(name: json['name']);
  }
}

class CustomerReview {
  final String name;
  final String review;
  final String date;

  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  factory CustomerReview.fromJson(Map<String, dynamic> json) {
    return CustomerReview(
      name: json['name'],
      review: json['review'],
      date: json['date'],
    );
  }
}
