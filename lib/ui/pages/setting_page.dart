import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_restauirant_app/provider/preference_provider.dart';
import 'package:submission_restauirant_app/utils/snack_bar_util.dart';
import '../../common/app_const.dart';

class SettingPage extends StatefulWidget{
  const SettingPage({super.key});

  @override
  SettingPageState createState() => SettingPageState();
}

class SettingPageState extends State<SettingPage>{

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PreferenceProvider>(context, listen: false).getValueNotification();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
      ),
      body: SafeArea(
          child: Padding(padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Consumer<PreferenceProvider>(
                  builder: (context, data, child){
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.black.withOpacity(0.5),
                      ),
                      child: SwitchListTile(
                        value: data.isNotificationEnable,
                        onChanged: (bool value) {
                          Provider.of<PreferenceProvider>(context, listen: false).dailyNotification(value);
                          Provider.of<PreferenceProvider>(context, listen: false).setNotification(value);
                          if(data.isNotificationEnable){
                            SnackBarUtil().showSnackBar(context, data.message, true);
                          }else{
                            SnackBarUtil().showSnackBar(context, data.message, false);
                          }
                        },
                        title: const Text(
                          "Restaurant Notification",
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: const Text(
                          "Enable or disable daily notification",
                          style: TextStyle(color: Colors.white70),
                        ),
                        activeColor: AppConst.secondaryColor,
                        inactiveThumbColor: Colors.grey,
                      ),
                    );
                  },
                ),
              ],
            ),)
      ),
    );
  }

}