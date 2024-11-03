import 'package:flutter/cupertino.dart';
import 'package:submission_restauirant_app/common/app_const.dart';
import 'package:submission_restauirant_app/common/response_state.dart';
import 'package:submission_restauirant_app/data/db/database_helper.dart';
import 'package:submission_restauirant_app/data/models/restaurant_list_model.dart';

class DatabaseProvider extends ChangeNotifier{

  DatabaseHelper databaseHelper = DatabaseHelper();
  ResponseState responseState = ResponseState.initial;

  List<Restaurant> _listRestaurant = [];
  List<Restaurant> get listRestaurant => _listRestaurant;

  String? message;

  Future<void> addFavoriteRestaurant(Restaurant restaurant) async {
    try {
      responseState = ResponseState.success;
      await databaseHelper.insertFavoriteRestaurant(restaurant);
      message = AppConst.favoriteSuccessAdd;
      notifyListeners();
    } catch (error) {
      responseState = ResponseState.failed;
      message = AppConst.favoriteFailedAdd;
      notifyListeners();
    }
  }

  Future<void> fetchListFavoriteRestaurant() async {
    responseState = ResponseState.loading;
    notifyListeners();

    try{
      _listRestaurant = await databaseHelper.fetchListFavoriteRestaurant();
      if(_listRestaurant.isNotEmpty){
        responseState = ResponseState.success;
      }else{
        responseState = ResponseState.empty;
        message = AppConst.dataNotFound;
      }
    }catch(error){
      responseState = ResponseState.failed;
      message = "An error has occurred: $error";
    }finally{
      notifyListeners();
    }
  }

  Future<bool> checkExistData(String id) async {
    final checkData = await databaseHelper.isFavoriteRestaurant(id);
    if(!checkData){
      return true;
    }else{
      return false;
    }
  }

  Future<bool> removeFavoriteRestaurant(String id) async {
    try{
      responseState = ResponseState.success;
      await databaseHelper.removeFavoriteRestaurant(id);
      message = AppConst.favoriteSuccessRemove;
      notifyListeners();
      return true;
    }catch(error){
      responseState = ResponseState.failed;
      message = AppConst.favoriteFailedRemove;
      notifyListeners();
      return false;
    }
  }

}