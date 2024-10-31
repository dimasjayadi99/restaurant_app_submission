import 'package:flutter/material.dart';
import 'package:submission_restauirant_app/common/app_const.dart';
import 'package:submission_restauirant_app/config/routes.dart';
import 'package:submission_restauirant_app/shared/widgets/loading.dart';
import 'package:submission_restauirant_app/ui/widgets/card_list_restaurant.dart';
import '../../data/models/restaurant_model.dart';
import '../../shared/widgets/gap.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>{

  late Future<List<Restaurants>> _restaurantFuture;
  List<Restaurants> list = [];

  @override
  void initState() {
    _restaurantFuture = fetchListData();
    super.initState();
  }

  @override
  void dispose() {
    list.clear();
    super.dispose();
  }

  // fetch list data
  Future<List<Restaurants>> fetchListData() async {
    final jsonString = await DefaultAssetBundle.of(context).loadString(AppConst.jsonPath);
    await Future.delayed(const Duration(seconds: 2));
    return parseListRestaurant(jsonString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              _restaurantFuture = fetchListData();
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // welcoming text
                  Text("Hi, ${AppConst.creator}", style: Theme.of(context).textTheme.headlineMedium),
                  const Gap.v(h: 4),
                  const Text(AppConst.welcomingText),
                  const Gap.v(h: 16),
                  // search text field
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: AppConst.searchText,
                      hintStyle: TextStyle(fontWeight: FontWeight.normal),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8))
                      ),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                  const Gap.v(h: 24),
                  // list restaurant
                  FutureBuilder(
                    future: _restaurantFuture,
                    builder: (context, snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                          return Loading().listVerticalShimmer();
                      }
                      else if(snapshot.hasData){
                        list = snapshot.data!;
                        if (list.isEmpty) {
                          return const Center(child: Text(AppConst.dataNotFound));
                        }
                        return ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index){
                              return GestureDetector(
                                  onTap: (){
                                    Navigator.of(context).pushNamed(Paths.detail, arguments: list[index]);
                                  },
                                  child: CardListRestaurant(listRestaurant: list, index: index));
                            },
                            separatorBuilder: (context, index) => const Gap.v(h: 16),
                            itemCount: list.length
                        );
                      }
                      else if(snapshot.hasError){
                        return Center(child: Text("Error : ${snapshot.error}"));
                      }
                      else{
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}