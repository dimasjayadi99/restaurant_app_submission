import 'package:flutter/material.dart';
import 'package:submission_restauirant_app/data/models/restaurant_list_model.dart';
import '../../common/app_const.dart';
import '../../shared/widgets/gap.dart';
import '../../shared/widgets/loading.dart';

class CardListRestaurant extends StatelessWidget {
  final List<Restaurant> listRestaurant;
  final int index;
  const CardListRestaurant(
      {super.key, required this.listRestaurant, required this.index});

  @override
  Widget build(BuildContext context) {
    final Restaurant restaurant = listRestaurant[index];

    return Container(
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// restaurant image
          /// if image is not empty, load from internet / network
          /// else load from assets -> images
          Hero(
            tag: restaurant.pictureId,
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: restaurant.pictureId.isNotEmpty
                    ? Image.network(
                        "${AppConst.baseImagePath}${restaurant.pictureId}",
                        width: 120,
                        height: 100,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Loading().imageLoading(120, 100);
                        },
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          return Loading().imageError(120, 100);
                        },
                      )
                    : Image.asset(
                        AppConst.defaultImageRestaurant,
                        width: 120,
                        height: 100,
                        fit: BoxFit.cover,
                      )),
          ),
          const Gap.h(w: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // restaurant name
                Text(restaurant.name,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                const Gap.v(h: 4),
                // restaurant city
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const Gap.h(w: 4),
                    Text(restaurant.city,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
                const Gap.v(h: 16),
                // restaurant rating
                Row(
                  children: [
                    const Icon(Icons.star_rate_rounded,
                        size: 16, color: Colors.yellow),
                    const Gap.h(w: 4),
                    Text(restaurant.rating.toString()),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
