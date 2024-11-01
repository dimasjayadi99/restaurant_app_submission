import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_restauirant_app/common/app_const.dart';
import 'package:submission_restauirant_app/common/response_state.dart';
import 'package:submission_restauirant_app/config/routes.dart';
import 'package:submission_restauirant_app/provider/restaurant_list_provider.dart';
import 'package:submission_restauirant_app/shared/widgets/loading.dart';
import 'package:submission_restauirant_app/ui/widgets/card_list_restaurant.dart';
import '../../shared/widgets/gap.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late RestaurantListProvider restaurantProvider;
  final TextEditingController _searchController = TextEditingController();

  String? message;

  @override
  void initState() {
    super.initState();
    restaurantProvider =
        Provider.of<RestaurantListProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      restaurantProvider.fetchListRestaurant();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await restaurantProvider.fetchListRestaurant();
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome text
                Text("Hi, ${AppConst.creator}",
                    style: Theme.of(context).textTheme.headlineMedium),
                const Gap.v(h: 4),
                const Text(AppConst.welcomingText),
                const Gap.v(h: 16),

                // Search text field
                TextFormField(
                  textInputAction: TextInputAction.search,
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: AppConst.searchText,
                    hintStyle: TextStyle(fontWeight: FontWeight.normal),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onFieldSubmitted: (value) async {
                    await Provider.of<RestaurantListProvider>(context,
                            listen: false)
                        .searchRestaurant(value);
                  },
                ),
                const Gap.v(h: 24),

                // Restaurant list
                Expanded(
                  child: Consumer<RestaurantListProvider>(
                    builder: (context, data, child) {
                      final state = data.responseState;
                      switch (state) {
                        case ResponseState.loading:
                          return Loading().listVerticalShimmer();
                        case ResponseState.empty:
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(data.message ?? "Tidak diketahui"),
                                TextButton(
                                    onPressed: () {
                                      restaurantProvider.fetchListRestaurant();
                                    },
                                    child: const Text("Refresh"))
                              ],
                            ),
                          );
                        case ResponseState.success:
                          return ListView.separated(
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    Paths.detail,
                                    arguments: data.restaurantList[index].id,
                                  );
                                },
                                child: CardListRestaurant(
                                  listRestaurant: data.restaurantList,
                                  index: index,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const Gap.v(h: 16),
                            itemCount: data.restaurantList.length,
                          );
                        case ResponseState.failed:
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(data.message!),
                                TextButton(
                                    onPressed: () {
                                      restaurantProvider.fetchListRestaurant();
                                    },
                                    child: const Text("Refresh"))
                              ],
                            ),
                          );
                        default:
                          return Container();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
