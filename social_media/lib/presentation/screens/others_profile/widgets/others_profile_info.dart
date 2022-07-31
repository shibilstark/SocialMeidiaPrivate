import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/application/edit_profile_pics/edit_profile_bloc.dart';
import 'package:social_media/application/follow/follow_bloc.dart';
import 'package:social_media/application/others_profile/others_profile_bloc.dart';
import 'package:social_media/application/post_crud/post_crud_bloc.dart';
import 'package:social_media/application/profile/profile_bloc.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/domain/models/post_model/post_model.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';
import 'package:social_media/presentation/router/router.dart';
import 'package:social_media/presentation/screens/new_post/new_post_screen.dart';
import 'package:social_media/presentation/screens/profile/edit/edit_cover_picture.dart';
import 'package:social_media/presentation/screens/profile/edit/edit_name_discr.dart';
import 'package:social_media/presentation/screens/profile/edit/edit_profile_picture.dart';
import 'package:social_media/presentation/widgets/gap.dart';

final dummyProfilePicture = "assets/dummy/dummyDP.png";

class OthersProfileInfo extends StatelessWidget {
  const OthersProfileInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OthersProfileBloc, OthersProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          UserModel user = (state as OthersProfileSuccess).profileModel.user;
          List<PostModel> posts = state.profileModel.posts;

          return Column(
            children: [
              Stack(
                children: [
                  OthersProfileCoverWidget(user: user),
                  OthersProfileImageAndNameWidget(user: user, posts: posts)
                ],
              ),
              user.discription == null
                  ? SizedBox()
                  : Column(
                      children: [
                        Gap(
                          H: 10.sm,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.sm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  user.discription!,
                                  softWrap: true,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontSize: 15.sm),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ],
          );
        }

        // return const Center(
        //   child: Text("Oops Someting went wrongs"),
        // );
        // },
        );
  }
}

class OthersProfileImageAndNameWidget extends StatelessWidget {
  OthersProfileImageAndNameWidget({
    Key? key,
    required this.user,
    required this.posts,
  }) : super(key: key);

  UserModel user;
  final List<PostModel> posts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 90.sm, left: 10.sm, right: 10.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              user.profileImage == null
                  ? CircleAvatar(
                      radius: 65.sm,
                      backgroundColor: darkBlue,
                      child: CircleAvatar(
                        backgroundImage: AssetImage(dummyProfilePicture),
                        radius: 60.sm,
                        backgroundColor: Colors.grey[400],
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/seeimageonline',
                            arguments:
                                ScreenArgs(args: {'path': user.profileImage}));
                      },
                      child: CircleAvatar(
                        radius: 65.sm,
                        backgroundColor: darkBlue,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(user.profileImage!),
                          radius: 60.sm,
                          backgroundColor: Colors.grey[400],
                        ),
                      ),
                    ),
              const Spacer(),
              LimitedBox(
                child: Padding(
                  padding: EdgeInsets.only(top: 50.sm),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, profileState) {
                          return BlocBuilder<FollowBloc, FollowState>(
                            builder: (context, state) {
                              if (state is FollowSuccess) {
                                if (!user.followers
                                    .contains(Global.USER_DATA.id)) {
                                  user.followers.add(state.profileId);

                                  if (profileState is ProfileSuccess) {
                                    if (!profileState
                                        .profileModel.user.following
                                        .contains(Global.USER_DATA.id)) {
                                      profileState.profileModel.user.following
                                          .add(Global.USER_DATA.id);
                                    }
                                  }
                                }
                              }
                              if (state is UnFollowSuccess) {
                                if (user.followers
                                    .contains(Global.USER_DATA.id)) {
                                  user.followers.remove(state.profileId);

                                  if (profileState is ProfileSuccess) {
                                    if (profileState.profileModel.user.following
                                        .contains(Global.USER_DATA.id)) {
                                      profileState.profileModel.user.following
                                          .remove(Global.USER_DATA.id);
                                    }
                                  }
                                }
                              }

                              return ItemBox(
                                  title: "Followers",
                                  value: user.followers.length.toString());
                            },
                          );
                        },
                      ),
                      Gap(
                        W: 10.sm,
                      ),
                      ItemBox(
                          title: "Following",
                          value: user.following.length.toString()),
                      Gap(
                        W: 10.sm,
                      ),
                      ItemBox(
                        title: "Posts",
                        value: posts.length.toString(),
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
            child: Row(
              children: [
                Text(
                  user.name,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 18.sm),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class OthersProfileCoverWidget extends StatelessWidget {
  const OthersProfileCoverWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return user.coverImage == null
        ? Container(
            constraints: BoxConstraints(maxHeight: 150.sm),
            color: Theme.of(context).canvasColor,
            width: double.infinity,
          )
        : GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/seeimageonline',
                  arguments: ScreenArgs(args: {'path': user.coverImage}));
            },
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(maxHeight: 150.sm),
              child: FadeInImage(
                  fadeInDuration: Duration(milliseconds: 100),
                  fit: BoxFit.cover,
                  image: NetworkImage(user.coverImage!),
                  placeholder: AssetImage(dummyProfilePicture)),
            ),
          );
  }
}

class ItemBox extends StatelessWidget {
  const ItemBox({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.sm,
      // width: 70.sm,
      decoration: BoxDecoration(
          // color: smoothWhite,
          borderRadius: BorderRadius.circular(10.sm)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontSize: 14.sm),
          ),
          Gap(
            H: 5.sm,
          ),
          Text(
            value,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontSize: 16.sm),
          )
        ],
      ),
    );
  }
}
