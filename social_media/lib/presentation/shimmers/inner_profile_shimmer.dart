import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/presentation/screens/post/post_texture.dart';
import 'package:social_media/presentation/shimmers/base.dart';
import 'package:social_media/presentation/widgets/gap.dart';

class InnerProfileLoading extends StatelessWidget {
  const InnerProfileLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            // alignment: Alignment.,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.sm),
                    topRight: Radius.circular(40.sm)),
                child: ShimmerBasicRectangleWidget(
                  W: double.infinity,
                  H: 150.sm,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 90.sm, left: 10.sm, right: 10.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 65.sm,
                          backgroundImage:
                              AssetImage("assets/dummy/dummyDP.png"),
                        ),
                        Spacer(),
                        LimitedBox(
                          child: Padding(
                            padding: EdgeInsets.only(top: 50.sm),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ShimmerBasicRectangleWidget(
                                  H: 50.sm,
                                  W: 50.sm,
                                ),
                                Gap(
                                  W: 20.sm,
                                ),
                                ShimmerBasicRectangleWidget(
                                  H: 50.sm,
                                  W: 50.sm,
                                ),
                                Gap(
                                  W: 20.sm,
                                ),
                                ShimmerBasicRectangleWidget(
                                  H: 50.sm,
                                  W: 50.sm,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Gap(
                      H: 10.sm,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.sm),
                      child: ShimmerBasicRectangleWidget(
                        W: 100.sm,
                        H: 20.sm,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Gap(
            H: 10.sm,
          ),
          ShimmerBasicRectangleWidget(
            W: double.infinity,
            H: 60.sm,
          ),
        ],
      ),
    );
  }
}

class _DummyBox extends StatelessWidget {
  const _DummyBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: 70.sm,
        width: 70.sm,
        decoration: BoxDecoration(
            // color: smoothWhite,
            borderRadius: BorderRadius.circular(10.sm)),
      ),
    );
  }
}
