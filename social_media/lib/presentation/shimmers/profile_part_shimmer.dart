import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/presentation/shimmers/base.dart';
import 'package:social_media/presentation/widgets/gap.dart';

class ProfilePartLoading extends StatelessWidget {
  const ProfilePartLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ShimmerBaseCircleWIdget(),
        Gap(
          W: 10.sm,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerBasicRectangleWidget(W: 50.sm),
            Gap(
              H: 3.sm,
            ),
            ShimmerBasicRectangleWidget(
              W: 120.sm,
              H: 12.sm,
            ),
          ],
        ),
      ],
    );
  }
}
