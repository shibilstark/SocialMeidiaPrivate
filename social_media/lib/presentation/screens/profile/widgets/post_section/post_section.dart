import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/application/user/current_user/current_user_bloc.dart';

import 'package:social_media/presentation/screens/profile/widgets/post_section/own_post_texture.dart';
import 'package:social_media/presentation/shimmers/post_shimmer.dart';
import 'package:social_media/presentation/widgets/gap.dart';

class ProfilePostsSection extends StatelessWidget {
  const ProfilePostsSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CurrentUserBloc, CurrentUserState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is FetchCurrentUserError) {
          return const Center(
            child: Text("Error"),
          );
        } else if (state is FetchCurrentUserLoading) {
          return const Center(
            child: Text("Loading"),
          );
        } else {
          final newState = state as FetchCurrentUserSuccess;
          final posts = state.data.post;
          return ListView.separated(
            separatorBuilder: (context, index) => Gap(
              H: 10.sm,
            ),
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) => OwnPostTexture(index: index),
            itemCount: posts.length,
          );
        }
      },
    );

    //   } else if (state is FetchCurrentUserSuccess) {
    //     final user = state.data.user;
    //     final posts = state.data.post;

    //     if (posts.isEmpty) {
    //       return SizedBox(
    //         child: Center(
    //           child: Text("No Posts Yet"),
    //         ),
    //       );
    //     } else {
    //       return Container(
    //           child: ListView.separated(
    //         separatorBuilder: (context, index) => Gap(
    //           H: 10.sm,
    //         ),
    //         physics: NeverScrollableScrollPhysics(),
    //         scrollDirection: Axis.vertical,
    //         shrinkWrap: true,
    //         itemBuilder: (context, index) => OwnPostTexture(index: index),
    //         itemCount: posts.length,
    //       ));
    //       ;
    //     }
    //   }

    //   return Center(
    //     child: Text("Oops"),
    //   );
    // },

    // return state.status == UserStatesValues.loading
    // ? Container(
    //     child: ListView.separated(
    //     separatorBuilder: (context, index) => Gap(
    //       H: 10.sm,
    //     ),
    //     physics: NeverScrollableScrollPhysics(),
    //     scrollDirection: Axis.vertical,
    //     shrinkWrap: true,
    //     itemBuilder: (context, index) => PostTExtureLoading(),
    //     itemCount: 2,
    //   ))
    //     : state.data!.user.posts.isEmpty
    //         ? SizedBox()
    // : Container(
    //     child: ListView.separated(
    //     separatorBuilder: (context, index) => Gap(
    //       H: 10.sm,
    //     ),
    //     physics: NeverScrollableScrollPhysics(),
    //     scrollDirection: Axis.vertical,
    //     shrinkWrap: true,
    //     itemBuilder: (context, index) =>
    //         OwnPostTexture(index: index),
    //     itemCount: state.data!.user.posts.length,
    //   ));
  }
}
