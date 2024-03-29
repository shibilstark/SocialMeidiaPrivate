import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media/core/colors/colors.dart';

class ShimmerBasicRectangleWidget extends StatelessWidget {
  const ShimmerBasicRectangleWidget({
    Key? key,
    this.W = 0,
    this.H = 15,
    this.rad = 4,
  }) : super(key: key);
  final double W;
  final double H;
  final double rad;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).canvasColor,
      highlightColor: Theme.of(context).canvasColor,
      child: Container(
        height: H,
        width: W,
        decoration: BoxDecoration(
            border: Border.all(width: 0, color: Colors.transparent),
            color: softGrey,
            borderRadius: BorderRadius.circular(rad)),
      ),
    );
  }
}

class ShimmerBaseCircleWIdget extends StatelessWidget {
  const ShimmerBaseCircleWIdget({
    Key? key,
    this.rad = 25,
  }) : super(key: key);
  final double rad;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).canvasColor,
      highlightColor: Theme.of(context).canvasColor,
      child: CircleAvatar(
        radius: rad,
      ),
    );
  }
}
