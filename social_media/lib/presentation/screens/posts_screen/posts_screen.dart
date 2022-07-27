import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/application/profile/profile_bloc.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/core/constants/constants.dart';
import 'package:social_media/presentation/screens/profile/widgets/profile_info.dart';
import 'package:social_media/presentation/widgets/gap.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: constPadding,
        child: ListView.separated(
            itemBuilder: (context, index) => Container(
                  height: 100.sm,
                  width: double.infinity,
                ),
            separatorBuilder: (context, index) => Divider(
                  thickness: 0.1,
                ),
            itemCount: 3),
      ),
    );
  }
}
