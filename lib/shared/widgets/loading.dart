import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:submission_restauirant_app/common/app_const.dart';
import 'package:submission_restauirant_app/shared/widgets/gap.dart';

class Loading{

  // shimmer for the restaurant list
  Widget listVerticalShimmer(){
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.separated(
          itemBuilder: (context, index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey[300],
                  ),
                  width: 120,
                  height: 100,
                ),

                const Gap.h(w: 16),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        color: Colors.grey[300],
                      ),
                      width: 200,
                      height: 16,
                    ),
                    const Gap.v(h: 16),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        color: Colors.grey[300],
                      ),
                      width: 150,
                      height: 16,
                    ),
                    const Gap.v(h: 16),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        color: Colors.grey[300],
                      ),
                      width: 80,
                      height: 16,
                    ),
                  ],
                ),
              ],
            );
          },
          itemCount: 5,
          shrinkWrap: true,
          separatorBuilder: (context, index) => const Gap.v(h: 16)
      ),
    );
  }

  // display a loading for the image
  Widget imageLoading(double? w, double? h) {
    return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(child: CircularProgressIndicator()
      ),
    );
  }

  // display an error for the image
  Widget imageError(double? w, double? h) {
    return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.error, color: Colors.red),
              Gap.v(h: 4),
              Text(AppConst.imageError)
            ],
          )),
    );
  }

}