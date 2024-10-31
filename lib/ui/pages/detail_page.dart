import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:submission_restauirant_app/common/app_const.dart';
import 'package:submission_restauirant_app/data/models/restaurant_model.dart';
import 'package:submission_restauirant_app/ui/widgets/card_list_menus.dart';
import '../../shared/widgets/gap.dart';

class DetailPage extends StatefulWidget {
  final Restaurants data;
  const DetailPage({super.key, required this.data});

  @override
  DetailPageState createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> with TickerProviderStateMixin {

  late Restaurants _data;
  late TabController _tabController;

  late List<bool> isCheckedListFood;
  late List<bool> isCheckedListDrink;

  List<Tab> tabList = const [
    Tab(child: Text("Foods")),
    Tab(child: Text("Drinks")),
  ];

  @override
  void initState() {
    _data = widget.data;
    _tabController = TabController(length: tabList.length, vsync: this);
    isCheckedListFood = List.generate(_data.menus.foods.length, (index) => false);
    isCheckedListDrink = List.generate(_data.menus.drinks.length, (index) => false);
    super.initState();
  }

  @override
  void dispose() {
    isCheckedListFood.clear();
    isCheckedListDrink.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          CustomScrollView(
            slivers: [

              // app bar
              _buildAppBar(),

              // body content
              _buildContent(),

              // Tab bar
              _buildTabBar(),
              _buildListMenu(),

            ],
          ),

          // button order
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(AppConst.primaryColor),
                    ),
                    onPressed: (){
                      // order action here
                    },
                    child: const Text("Order Now", style: TextStyle(color: Colors.white))
                ),
              )
          )
        ],
      ),
    );
  }

  // build app bar
  Widget _buildAppBar(){
    return SliverAppBar(
        pinned: true,
        backgroundColor: AppConst.primaryColor,
        expandedHeight: 200,
        leading: Container(),
        flexibleSpace: FlexibleSpaceBar(
          expandedTitleScale: 1.4,
          background: Stack(
            fit: StackFit.expand,
            children: [
              // app bar background image
              Hero(
                tag: _data.pictureId,
                child: _data.pictureId.isNotEmpty ?
                Image.network(
                  _data.pictureId,
                  fit: BoxFit.cover)
                    :
                Image.asset(AppConst.defaultImageRestaurant, fit: BoxFit.cover),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(1),
                      Colors.black.withOpacity(0.2),
                    ],
                    stops: const [0.0, 1.0],
                  ),
                ),
              ),
            ],
          ),
          // set name restaurant and city
          title: ListTile(
            title: Text(_data.name, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white)),
            subtitle: Row(
              children: [
                const Icon(Icons.location_on, color: Colors.white, size: 12),
                const Gap.h(w: 4),
                Text(_data.city, style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),
          titlePadding: const EdgeInsets.only(left: 0, bottom: 0),
        ),
      );
  }

  // build body content with rating bar and description
  Widget _buildContent(){
    return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RatingBar.builder(
                    itemBuilder: (context, index) => const Icon(
                      Icons.star_rate_rounded,
                      color: Colors.yellow,
                      size: 18,
                    ),
                    itemSize: 24,
                    glow: false,
                    initialRating: _data.rating,
                    minRating: 0,
                    allowHalfRating: true,
                    itemCount: 5,
                    ignoreGestures: true,
                    direction: Axis.horizontal,
                    onRatingUpdate: (value) {},
                  ),
                  const Gap.h(w: 4),
                  Text("(${_data.rating})"),
                  const Spacer(),
                  const Icon(Icons.bookmark_border),
                ],
              ),
              const Gap.v(h: 16),
              Text("Description", style: Theme.of(context).textTheme.titleLarge),
              const Gap.v(h: 8),
              Text(_data.description, style: Theme.of(context).textTheme.bodyMedium),
              const Gap.v(h: 16),
            ],
          ),
        ),
      );
  }

  // build tab bar
  Widget _buildTabBar(){
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppDelegate(
        minHeight: 48,
        maxHeight: 48,
        child: Container(
          color: Colors.white,
          child: TabBar(
            controller: _tabController,
            indicatorColor: AppConst.primaryColor,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: tabList,
          ),
        ),
      ),
    );
  }

  // build tabview
  Widget _buildListMenu(){
    return SliverFillRemaining(
      child: TabBarView(
        controller: _tabController,
        children: [
          // list foods
          CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return CardListMenus(
                    value: isCheckedListFood[index],
                    name: _data.menus.foods[index].name,
                    onChanged: (value) {
                      setState(() {
                        isCheckedListFood[index] = value ?? false;
                      });
                    },
                  );
                },
                  childCount: _data.menus.foods.length,
                ),
              ),
            ],
          ),
          // list drinks
          CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return CardListMenus(
                    value: isCheckedListDrink[index],
                    name: _data.menus.drinks[index].name,
                    onChanged: (value) {
                      setState(() {
                        isCheckedListDrink[index] = value ?? false;
                      });
                    },
                  );
                },
                  childCount: _data.menus.drinks.length,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Sliver app delegate for SliverPersistentHeader delegate
class SliverAppDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  SliverAppDelegate({
    required this.minHeight, required this.maxHeight, required this.child
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverAppDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}