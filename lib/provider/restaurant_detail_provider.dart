import 'dart:io';

import 'package:flutter/cupertino.dart';
import '../common/response_state.dart';
import '../data/api/api_service.dart';
import '../data/models/restaurant_detail_model.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();
  ResponseState responseState = ResponseState.initial;

  RestaurantDetail? _restaurantDetail;
  RestaurantDetail? get restaurantDetail => _restaurantDetail;

  String? message;

  /// fetch detail restaurant
  Future<void> fetchDetailRestaurant(String id) async {
    responseState = ResponseState.loading;
    notifyListeners();

    try {
      final response = await apiService.fetchDetailRestaurant(id);
      if (!response.error) {
        _restaurantDetail = response.restaurant;
        responseState = (_restaurantDetail?.id ?? '').isEmpty
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
        message = 'An error has occurred: $error';
      }
    } finally {
      notifyListeners();
    }
  }
}
