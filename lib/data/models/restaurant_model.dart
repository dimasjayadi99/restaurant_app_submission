import 'dart:convert';

class RestaurantModel {
  final List<Restaurants> restaurants;

  RestaurantModel({required this.restaurants});

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
        restaurants: (json['restaurants'] as List<dynamic>)
            .map((item) => Restaurants.fromJson(item as Map<String, dynamic>))
            .toList());
  }
}

class Restaurants {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final Menus menus;

  Restaurants(
      {required this.id,
      required this.name,
      required this.description,
      required this.pictureId,
      required this.city,
      required this.rating,
      required this.menus});

  factory Restaurants.fromJson(Map<String, dynamic> json) {
    return Restaurants(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        pictureId: json['pictureId'] as String,
        city: json['city'] as String,
        rating: (json['rating'] as num).toDouble(),
        menus: Menus.fromJson(json['menus'] as Map<String, dynamic>));
  }
}

class Menus {
  final List<Foods> foods;
  final List<Drinks> drinks;

  Menus({required this.foods, required this.drinks});

  factory Menus.fromJson(Map<String, dynamic> json) {
    return Menus(
        foods: (json['foods'] as List<dynamic>)
            .map((item) => Foods.fromJson(item as Map<String, dynamic>))
            .toList(),
        drinks: (json['drinks'] as List<dynamic>)
            .map((item) => Drinks.fromJson(item as Map<String, dynamic>))
            .toList());
  }
}

class Foods {
  final String name;

  Foods({required this.name});

  factory Foods.fromJson(Map<String, dynamic> json) {
    return Foods(name: json['name']);
  }
}

class Drinks {
  final String name;

  Drinks({required this.name});

  factory Drinks.fromJson(Map<String, dynamic> json) {
    return Drinks(name: json['name']);
  }
}

// parse restaurant list
List<Restaurants> parseListRestaurant(String? json) {
  if (json == null) {
    return [];
  }

  final Map<String, dynamic> parseList = jsonDecode(json);
  return (parseList['restaurants'] as List<dynamic>)
      .map((item) => Restaurants.fromJson(item as Map<String, dynamic>))
      .toList();
}
