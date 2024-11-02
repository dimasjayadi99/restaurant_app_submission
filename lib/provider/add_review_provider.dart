import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:submission_restauirant_app/common/app_const.dart';
import 'package:submission_restauirant_app/data/models/restaurant_review_model.dart';

import '../common/response_state.dart';
import '../data/api/api_service.dart';

class AddReviewProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();
  ResponseState responseState = ResponseState.initial;

  RestaurantReviewModel? _addReview;
  RestaurantReviewModel? get addReview => _addReview;

  String? message;

  /// post a new review
  Future<String> postReviewRestaurant(
      String id, String name, String review) async {
    responseState = ResponseState.loading;
    notifyListeners();

    try {
      final response = await apiService.postReview(id, name, review);
      if (!response.error) {
        _addReview = response;
        responseState = ResponseState.success;
        return message = AppConst.successAddReview;
      } else {
        responseState = ResponseState.failed;
        return message = response.message;
      }
    } catch (error) {
      responseState = ResponseState.failed;
      if (error is SocketException) {
        return message = AppConst.noInternetConnection;
      } else {
        return message = "An error has occurred: $error";
      }
    } finally {
      notifyListeners();
    }
  }
}
