import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:submission_restauirant_app/data/api/api_config.dart';
import 'package:submission_restauirant_app/data/models/restaurant_list_model.dart';

final String baseUrl = ApiConfig.baseUrl;
String endPoint = "";

/// fetch restaurant list with http client
Future<RestaurantListModel> fetchListRestaurant(http.Client client) async {
  endPoint = "$baseUrl/list";
  final response = await client.get(Uri.parse(endPoint));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    return RestaurantListModel.fromJson(data);
  } else {
    throw Exception("Failed to fetch data");
  }
}

void main(){

  setUpAll(() async {
    await dotenv.load(fileName: '.env');
  });

  group('fetch list restaurant', (){
    test('returns list of restaurant', () async {
      final responseSample = {
        "error": false,
        "message": "success",
        "count": 1,
        "restaurants": [
          {
            "id": "rqdv5juczeskfw1e867",
            "name": "Melting Pot",
            "description": "Lorem ipsum dolor sit amet.",
            "pictureId": "14",
            "city": "Medan",
            "rating": 4.2
          },
          {
            "id": "s1knt6za9kkfw1e867",
            "name": "Kafe Kita",
            "description": "Quisque rutrum. Aenean imperdiet.",
            "pictureId": "25",
            "city": "Gorontalo",
            "rating": 4
          }
        ]
      };
      final client = MockClient((_) async => http.Response(jsonEncode(responseSample), 200));

      expect(await fetchListRestaurant(client), isA<RestaurantListModel>());

      final result = await fetchListRestaurant(client);

      expect(result.error, false);
      expect(result.message, "success");
      expect(result.count, 1);
      expect(result.restaurants.length, 2);
      expect(result.restaurants[0].name, "Melting Pot");
      expect(result.restaurants[1].name, "Kafe Kita");
    });

    test('throws an exception when the response is not 200', () async {
      final client = MockClient((_) async => http.Response('Not Found', 404));

      expect(() async => await fetchListRestaurant(client), throwsException);
    });

    test('throws an exception when invalid JSON', () async {
      final client = MockClient((_) async => http.Response('Invalid JSON', 200));

      expect(() async => await fetchListRestaurant(client), throwsException);
    });

    test('returns an empty restaurant list', () async {
      final responseSample = {
        "error": false,
        "message": "success",
        "count": 0,
        "restaurants": []
      };
      final client = MockClient((_) async => http.Response(jsonEncode(responseSample), 200));

      final result = await fetchListRestaurant(client);

      expect(result.restaurants, isEmpty);
      expect(result.count, 0);
    });
  });
}