import 'package:flutter/cupertino.dart';
import 'package:submission_restauirant_app/ui/pages/detail_page.dart';
import 'package:submission_restauirant_app/ui/pages/favorite_page.dart';
import 'package:submission_restauirant_app/ui/pages/home_page.dart';
import 'package:submission_restauirant_app/ui/pages/review_page.dart';
import 'package:submission_restauirant_app/ui/pages/setting_page.dart';
import 'package:submission_restauirant_app/ui/pages/splash_screen_page.dart';

import '../data/models/restaurant_detail_model.dart';

Map<String, WidgetBuilder> appRoutes() {
  return {
    Paths.init: (context) => const SplashScreenPage(),
    Paths.home: (context) => const HomePage(),
    Paths.detail: (context) {
      final String id = ModalRoute.of(context)?.settings.arguments as String;
      return DetailPage(id: id);
    },
    Paths.review: (context) {
      final List<CustomerReview> listReview =
          ModalRoute.of(context)?.settings.arguments as List<CustomerReview>;
      return ReviewPage(listReview: listReview);
    },
    Paths.favorite: (context) => const FavoritePage(),
    Paths.setting: (context) => const SettingPage(),
  };
}

abstract class Paths {
  Paths._();

  static const init = '/';
  static const home = '/home';
  static const detail = '/detail';
  static const review = '/review';
  static const favorite = '/favorite';
  static const setting = '/setting';
  // other path here
}
