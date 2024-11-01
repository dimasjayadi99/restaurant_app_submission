import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:submission_restauirant_app/common/app_const.dart';
import 'package:submission_restauirant_app/common/response_state.dart';
import 'package:submission_restauirant_app/data/models/restaurant_detail_model.dart';
import 'package:submission_restauirant_app/provider/add_review_provider.dart';
import 'package:submission_restauirant_app/provider/restaurant_detail_provider.dart';
import 'package:submission_restauirant_app/shared/widgets/text_fields.dart';
import 'package:submission_restauirant_app/shared/widgets/snackbar.dart';
import 'package:submission_restauirant_app/ui/widgets/card_list_menus.dart';
import '../../shared/widgets/gap.dart';

class DetailPage extends StatefulWidget {
  final String id;

  const DetailPage({super.key, required this.id});

  @override
  DetailPageState createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  late RestaurantDetailProvider restaurantProvider;
  RestaurantDetail? restaurantDetail;

  late TabController _tabController;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late List<bool> isCheckedListFood;
  late List<bool> isCheckedListDrink;

  String id = "";
  bool isAddReview = false;

  List<Tab> tabList = [];

  @override
  void initState() {
    super.initState();
    id = widget.id;
    tabList = const [
      Tab(child: Text("Foods")),
      Tab(child: Text("Drinks")),
    ];
    _tabController = TabController(length: tabList.length, vsync: this);
    restaurantProvider =
        Provider.of<RestaurantDetailProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      restaurantProvider.fetchDetailRestaurant(id);
    });
  }

  @override
  void dispose() {
    super.dispose();
    isCheckedListFood.clear();
    isCheckedListDrink.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<RestaurantDetailProvider>(
        builder: (context, data, child) {
          final state = data.responseState;
          switch (state) {
            case ResponseState.loading:
              return const Center(child: CircularProgressIndicator());
            case ResponseState.empty:
              return const Center(
                child: Text("Data is empty"),
              );
            case ResponseState.success:
              restaurantDetail = data.restaurantDetail;
              isCheckedListFood = List.generate(
                  restaurantDetail!.menus.foods.length, (_) => false);
              isCheckedListDrink = List.generate(
                  restaurantDetail!.menus.drinks.length, (_) => false);
              return CustomScrollView(
                slivers: [
                  // app bar
                  _buildAppBar(),

                  // body content
                  _buildContent(),

                  // Tab bar
                  _buildTabBar(),

                  // Tab view
                  _buildListMenu(),
                ],
              );
            case ResponseState.failed:
              return Center(child: Text(data.message!));
            default:
              return Container();
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(AppConst.primaryColor),
            ),
            onPressed: () {
              // order action here
            },
            child:
                const Text("Order Now", style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }

  // build app bar
  Widget _buildAppBar() {
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
              tag: restaurantDetail!.pictureId,
              child: restaurantDetail!.pictureId.isNotEmpty
                  ? Image.network(
                      "${AppConst.baseImagePath}${restaurantDetail!.pictureId}",
                      fit: BoxFit.cover)
                  : Image.asset(AppConst.defaultImageRestaurant,
                      fit: BoxFit.cover),
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
          title: Text(restaurantDetail!.name,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white)),
          subtitle: Row(
            children: [
              const Icon(Icons.location_on, color: Colors.white, size: 12),
              const Gap.h(w: 4),
              Text(restaurantDetail!.city,
                  style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
        titlePadding: const EdgeInsets.only(left: 0, bottom: 0),
      ),
    );
  }

  // build body content with rating bar and description
  Widget _buildContent() {
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
                  initialRating: restaurantDetail!.rating,
                  minRating: 0,
                  allowHalfRating: true,
                  itemCount: 5,
                  ignoreGestures: true,
                  direction: Axis.horizontal,
                  onRatingUpdate: (value) {},
                ),
                const Gap.h(w: 4),
                Text("(${restaurantDetail!.rating})"),
                const Spacer(),
                const Icon(Icons.bookmark_border),
              ],
            ),
            const Gap.v(h: 8),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: restaurantDetail!.categories.map((category) {
                return Chip(
                  label: Text(
                    category.name,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                );
              }).toList(),
            ),
            const Gap.v(h: 16),
            Text("Description", style: Theme.of(context).textTheme.titleLarge),
            const Gap.v(h: 8),
            Text(restaurantDetail!.description,
                style: Theme.of(context).textTheme.bodyMedium),
            const Gap.v(h: 16),
            Row(
              children: [
                Text("Reviews", style: Theme.of(context).textTheme.titleLarge),
                const Spacer(),
                TextButton.icon(
                    icon: Icon(
                      isAddReview ? Icons.close : Icons.add,
                      size: 16,
                      color: Colors.blue,
                    ),
                    style: ButtonStyle(
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                      splashFactory: NoSplash.splashFactory,
                    ),
                    onPressed: () {
                      setState(() {
                        isAddReview = !isAddReview;
                      });
                    },
                    label: Text(isAddReview ? "Cancel" : "Add Review",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.blue)))
              ],
            ),
            if (isAddReview) ...[
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      buildFormTextField(_nameController, "Nama", Icons.person),
                      const Gap.v(h: 8),
                      buildFormTextField(
                          _reviewController, "Review", Icons.text_snippet),
                      const Gap.v(h: 8),
                      TextButton.icon(
                          iconAlignment: IconAlignment.end,
                          icon: const Icon(
                            Icons.send,
                            size: 16,
                          ),
                          onPressed: () async {
                            final name = _nameController.text.trim();
                            final review = _reviewController.text.trim();
                            if (formKey.currentState!.validate()) {
                              try {
                                final status =
                                    await Provider.of<AddReviewProvider>(
                                            context,
                                            listen: false)
                                        .postReviewRestaurant(id, name, review);

                                if (mounted)
                                  SnackBarUtil()
                                      .showSnackBar(context, status, true);
                                _nameController.clear();
                                _reviewController.clear();
                                restaurantProvider.fetchDetailRestaurant(id);
                              } catch (error) {
                                if (mounted)
                                  SnackBarUtil()
                                      .showSnackBar(context, "$error", false);
                              }
                            }
                          },
                          label: const Text("Send"))
                    ],
                  ),
                ),
              ),
            ],
            CustomScrollView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return ListTile(
                        horizontalTitleGap: 4,
                        dense: true,
                        leading: Text("${index + 1}"),
                        title: Text(
                          restaurantDetail!.customerReviews[index].name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        subtitle: Text(
                            restaurantDetail!.customerReviews[index].review),
                        trailing:
                            Text(restaurantDetail!.customerReviews[index].date),
                      );
                    },
                    childCount: restaurantDetail!.customerReviews.length > 5
                        ? 5
                        : restaurantDetail!.customerReviews.length,
                  ),
                ),
              ],
            ),
            Center(
                child: TextButton(
                    style: ButtonStyle(
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                      splashFactory: NoSplash.splashFactory,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/review',
                          arguments: restaurantDetail!.customerReviews);
                    },
                    child: const Text("See All Reviews")))
          ],
        ),
      ),
    );
  }

  // build tab bar
  Widget _buildTabBar() {
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
  Widget _buildListMenu() {
    return SliverFillRemaining(
      child: TabBarView(
        controller: _tabController,
        children: [
          // list foods
          CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return CardListMenus(
                      value: isCheckedListFood[index],
                      name: restaurantDetail!.menus.foods[index].name,
                      onChanged: (value) {
                        setState(() {
                          isCheckedListFood[index] = value ?? false;
                        });
                      },
                    );
                  },
                  childCount: restaurantDetail!.menus.foods.length,
                ),
              ),
            ],
          ),
          // list drinks
          CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return CardListMenus(
                      value: isCheckedListDrink[index],
                      name: restaurantDetail!.menus.drinks[index].name,
                      onChanged: (value) {
                        setState(() {
                          isCheckedListDrink[index] = value ?? false;
                        });
                      },
                    );
                  },
                  childCount: restaurantDetail!.menus.drinks.length,
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

  SliverAppDelegate(
      {required this.minHeight, required this.maxHeight, required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
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
