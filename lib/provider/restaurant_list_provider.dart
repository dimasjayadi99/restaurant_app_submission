import 'dart:io';
import 'package:flutter/cupertino.dart';
import '../common/response_state.dart';
import '../data/api/api_service.dart';
import '../data/models/restaurant_list_model.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();
  ResponseState responseState = ResponseState.initial;

  final List<Restaurant> _restaurantList = [];
  List<Restaurant> get restaurantList => _restaurantList;

  String? message;

  /// Fetch list of restaurants
  Future<void> fetchListRestaurant() async {
    responseState = ResponseState.loading;
    notifyListeners();

    try {
      final response = await apiService.fetchListRestaurant();

      if (!response.error) {
        _restaurantList.clear();
        _restaurantList.addAll(response.restaurants);
        responseState = _restaurantList.isEmpty
            ? ResponseState.empty
            : ResponseState.success;
      } else {
        responseState = ResponseState.failed;
        message = response.message;
      }
    } catch (error) {
      responseState = ResponseState.failed;
      if (error is SocketException) {
        message = 'No internet connection';
      } else {
        message = 'An error occurred: $error';
      }
    } finally {
      notifyListeners();
    }
  }

  Future<void> searchRestaurant(String value) async {
    responseState = ResponseState.loading;
    notifyListeners();

    try {
      final response = await apiService.searchRestaurant(value);
      if (response.isNotEmpty) {
        responseState = ResponseState.success;
        _restaurantList.clear();
        _restaurantList.addAll(response);
      } else {
        responseState = ResponseState.empty;
        message = "Data not found";
      }
    } catch (error) {
      responseState = ResponseState.failed;
      if (error is SocketException) {
        message = "No internet connection";
      } else {
        message = "An error occurred: $error";
      }
    } finally {
      notifyListeners();
    }
  }
}
