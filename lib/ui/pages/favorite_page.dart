import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_restauirant_app/common/response_state.dart';
import 'package:submission_restauirant_app/provider/database_provider.dart';
import 'package:submission_restauirant_app/ui/widgets/card_list_restaurant.dart';

import '../../common/app_const.dart';

class FavoritePage extends StatefulWidget{
  const FavoritePage({super.key});

  @override
  FavoritePageState createState() => FavoritePageState();
}

class FavoritePageState extends State<FavoritePage>{

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DatabaseProvider>(context, listen: false).fetchListFavoriteRestaurant();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Page"),
      ),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Consumer<DatabaseProvider>(
              builder: (context, data, child){
                final state = data.responseState;
                switch(state){
                  case ResponseState.loading:
                    return const Center(child: CircularProgressIndicator());
                  case ResponseState.empty:
                    return Center(child: Text(data.message ?? AppConst.somethingWentWrong));
                  case ResponseState.failed:
                    return Center(child: Text(data.message ?? AppConst.somethingWentWrong));
                  case ResponseState.success:
                    return ListView.builder(
                        itemBuilder: (context, index){
                          return GestureDetector(
                              onTap: (){
                                Navigator.of(context).pushNamed('/detail', arguments: data.listRestaurant[index].id);
                              },
                              child: CardListRestaurant(listRestaurant: data.listRestaurant, index: index));
                        },
                      itemCount: data.listRestaurant.length,
                    );
                  default:
                    return Container();
                }
              },
            ),
          )
      ),
    );
  }
}