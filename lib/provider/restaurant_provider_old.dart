import 'package:flutter/cupertino.dart';
import 'package:submission_restauirant_app/common/response_state.dart';
import 'package:submission_restauirant_app/data/api/api_service.dart';
import 'package:submission_restauirant_app/data/models/restaurant_list_model.dart';
import '../data/models/restaurant_detail_model.dart';

class RestaurantProviderOld extends ChangeNotifier {
  final ApiService apiService = ApiService();
  ResponseState responseState = ResponseState.initial;

  final List<Restaurant> _restaurantList = [];
  List<Restaurant> get restaurantList => _restaurantList;

  RestaurantDetail? _restaurantDetail;
  RestaurantDetail? get restaurantDetail => _restaurantDetail;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? message;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// fetch list of restaurant
  void fetchListRestaurant() async {
    responseState = ResponseState.loading;
    notifyListeners();

    final response = await apiService.fetchListRestaurant();

    if (!response.error) {
      responseState = ResponseState.success;
      _restaurantList.clear();
      _restaurantList.addAll(response.restaurants);
      notifyListeners();
    } else if (response.restaurants.isEmpty) {
      responseState = ResponseState.empty;
      message = "Data not found";
      notifyListeners();
    } else {
      responseState = ResponseState.failed;
      message = response.message;
      notifyListeners();
    }
  }

  /// fetch detail restaurant
  void fetchDetailRestaurant(String id) async {
    responseState = ResponseState.loading;
    notifyListeners();

    final response = await apiService.fetchDetailRestaurant(id);

    if (!response.error) {
      responseState = ResponseState.success;
      _restaurantDetail = response.restaurant;
      notifyListeners();
    } else {
      responseState = ResponseState.failed;
      message = response.message;
      notifyListeners();
    }
  }
}
