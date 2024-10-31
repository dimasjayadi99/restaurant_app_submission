import 'package:flutter/cupertino.dart';
import 'package:submission_restauirant_app/data/models/restaurant_model.dart';
import 'package:submission_restauirant_app/ui/pages/detail_page.dart';
import 'package:submission_restauirant_app/ui/pages/home_page.dart';
import 'package:submission_restauirant_app/ui/pages/splash_screen_page.dart';

Map<String, WidgetBuilder> appRoutes() {
  return {
    Paths.init : (context) => const SplashScreenPage(),
    Paths.home : (context) => const HomePage(),
    Paths.detail: (context) {
      final Restaurants data = ModalRoute.of(context)?.settings.arguments as Restaurants;
      return DetailPage(data: data);
    },
  };
}

abstract class Paths{
  Paths._();

  static const init = '/';
  static const home = '/home';
  static const detail = '/detail';
  // other path here
}