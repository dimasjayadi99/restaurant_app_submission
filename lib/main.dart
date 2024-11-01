import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:submission_restauirant_app/common/app_style.dart';
import 'package:submission_restauirant_app/provider/add_review_provider.dart';
import 'package:submission_restauirant_app/provider/restaurant_detail_provider.dart';
import 'package:submission_restauirant_app/provider/restaurant_list_provider.dart';
import 'config/routes.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => RestaurantListProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => RestaurantDetailProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => AddReviewProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(textTheme: AppStyle.textTheme),
      debugShowCheckedModeBanner: false,
      initialRoute: Paths.init,
      routes: appRoutes(),
    );
  }
}
