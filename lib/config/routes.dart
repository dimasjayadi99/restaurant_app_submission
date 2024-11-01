import 'package:flutter/cupertino.dart';
import 'package:submission_restauirant_app/ui/pages/detail_page.dart';
import 'package:submission_restauirant_app/ui/pages/home_page.dart';
import 'package:submission_restauirant_app/ui/pages/review_page.dart';
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
  };
}

abstract class Paths {
  Paths._();

  static const init = '/';
  static const home = '/home';
  static const detail = '/detail';
  static const review = '/review';
  // other path here
}
