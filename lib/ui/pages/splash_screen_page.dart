import 'package:flutter/material.dart';
import 'package:submission_restauirant_app/common/app_const.dart';
import 'package:submission_restauirant_app/config/routes.dart';
import '../../common/app_style.dart';
import '../../shared/widgets/gap.dart';

class SplashScreenPage extends StatefulWidget{
  const SplashScreenPage({super.key});

  @override
  SplashScreenPageState createState() => SplashScreenPageState();
}

class SplashScreenPageState extends State<SplashScreenPage>{

  // time load in second
  final int timeLoad = 2;

  @override
  void initState() {
    // call startAppFlow function
    startAppFlow();
    super.initState();
  }

  // navigate to home page
  Future<void> startAppFlow() async {
    await Future.delayed(Duration(seconds: timeLoad));
    if(mounted) Navigator.pushReplacementNamed(context, Paths.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConst.secondaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(AppConst.appName, style: AppStyle.logoStyle()),
            const Gap.v(h: 8),
            const Text("by ${AppConst.creator}"),
          ],
        ),
      )
    );
  }
}