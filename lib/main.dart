import 'package:flutter/material.dart';
import 'package:submission_restauirant_app/common/app_style.dart';
import 'config/routes.dart';

void main() {
  runApp(const MyApp());
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