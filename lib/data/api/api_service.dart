import 'dart:convert';
import 'package:submission_restauirant_app/data/api/api_config.dart';
import 'package:http/http.dart' as http;
import 'package:submission_restauirant_app/data/models/restaurant_detail_model.dart';
import 'package:submission_restauirant_app/data/models/restaurant_list_model.dart';
import 'package:submission_restauirant_app/data/models/restaurant_review_model.dart';

class ApiService {
  final String baseUrl = ApiConfig.baseUrl;
  String endPoint = "";

  /// fetch restaurant list
  Future<RestaurantListModel> fetchListRestaurant() async {
    endPoint = "$baseUrl/list";

    http.Response response = await http.get(Uri.parse(endPoint));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return RestaurantListModel.fromJson(data);
    } else {
      throw Exception("Failed to fetch data");
    }
  }

  /// fetch detail restaurant
  Future<RestaurantDetailModel> fetchDetailRestaurant(String id) async {
    endPoint = "$baseUrl/detail/$id";

    http.Response response = await http.get(Uri.parse(endPoint));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return RestaurantDetailModel.fromJson(data);
    } else {
      throw Exception("Failed to fetch data");
    }
  }

  /// post a review
  Future<RestaurantReviewModel> postReview(
      String id, String name, String review) async {
    endPoint = "$baseUrl/review";

    Map<String, dynamic> bodyJson = {"id": id, "name": name, "review": review};

    http.Response response = await http
        .post(Uri.parse(endPoint), body: json.encode(bodyJson), headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 201) {
      final Map<String, dynamic> data = json.decode(response.body);
      return RestaurantReviewModel.fromJson(data);
    } else {
      throw Exception("Failed to send data");
    }
  }

  /// search resturant list
  Future<List<Restaurant>> searchRestaurant(String value) async {
    endPoint = "$baseUrl/search?q=$value";

    final response = await http.get(Uri.parse(endPoint));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> restaurantData = data['restaurants'];
      return restaurantData.map((json) => Restaurant.fromJson(json)).toList();
    } else {
      throw Exception("Failed to search data");
    }
  }
}
