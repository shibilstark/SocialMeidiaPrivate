import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/presentation/shimmers/base.dart';
import 'package:social_media/presentation/widgets/dummy_profile.dart';
import 'package:social_media/presentation/widgets/gap.dart';

class PostTExtureLoading extends StatelessWidget {
  const PostTExtureLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              LimitedBox(
                  child: Row(
                children: [
                  ShimmerBaseCircleWIdget(
                    rad: 20.sm,
                  ),
                  Gap(W: 10.sm),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ShimmerBasicRectangleWidget(
                        W: 60.sm,
                      )
                      // Text(
                      //   "Follow",
                      //   style: Theme.of(context).textTheme.bodyMedium,
                      // )
                    ],
                  )
                ],
              )),
              Spacer(),
              // ShimmerBasicRectangleWidget(
              //   W: 10.sm,
              // )
            ],
          ),
          Gap(
            H: 10.sm,
          ),
          ShimmerBasicRectangleWidget(
            H: 220.sm,
            W: double.infinity,
          ),
          Gap(
            H: 10.sm,
          ),
          Row(
            children: [
              Expanded(
                child: ShimmerBasicRectangleWidget(
                  H: 30.sm,
                  W: double.infinity,
                ),
              ),
              Gap(
                W: 10.sm,
              ),
              Expanded(
                child: ShimmerBasicRectangleWidget(
                  H: 30.sm,
                  W: double.infinity,
                ),
              ),
              Gap(
                W: 10.sm,
              ),
              Expanded(
                child: ShimmerBasicRectangleWidget(
                  H: 30.sm,
                  W: double.infinity,
                ),
              ),
            ],
          ),
          // Gap(
          //   H: 10.sm,
          // ),
          // ShimmerBasicRectangleWidget(
          //   H: 60.sm,
          //   W: double.infinity,
          // )
        ],
      ),
    );
  }
}
