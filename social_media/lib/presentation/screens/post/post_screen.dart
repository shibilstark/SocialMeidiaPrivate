import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/core/constants/constants.dart';
import 'package:social_media/presentation/screens/home/home_screen.dart';
import 'package:social_media/presentation/screens/post/post_texture.dart';
import 'package:social_media/presentation/shimmers/post_shimmer.dart';
import 'package:social_media/presentation/widgets/gap.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageStorage(
      bucket: globalBucket,
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 998.sm),
          child: Padding(
            padding: postScreenPadding,
            child: Container(
                // child: ListView.separated(
                //   key: PageStorageKey("PostScreenListView"),
                //   itemBuilder: (context, index) => OwnPostTexture(index: index),
                //   separatorBuilder: (context, index) => Divider(
                //     thickness: 0.1.sm,
                //   ),
                //   itemCount: 10,
                // ),
                ),
          ),
        ),
      ),
    );
  }
}
