import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media/application/edit_profile_pics/edit_profile_bloc.dart';
import 'package:social_media/application/follow/follow_bloc.dart';
import 'package:social_media/application/home/home_feed_bloc.dart';
import 'package:social_media/application/others_profile/others_profile_bloc.dart';
import 'package:social_media/application/post_crud/post_crud_bloc.dart';
import 'package:social_media/application/profile/profile_bloc.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/core/constants/constants.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';
import 'package:social_media/presentation/screens/others_profile/widgets/others_profile_info.dart';
import 'package:social_media/presentation/screens/posts_screen/global_post.dart';
import 'package:social_media/presentation/screens/profile/edit/dialog.dart';
import 'package:social_media/presentation/shimmers/inner_profile_shimmer.dart';
import 'package:social_media/presentation/widgets/gap.dart';
import 'package:social_media/presentation/widgets/theme_switch.dart';

class OthersProfileScreen extends StatelessWidget {
  const OthersProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {});

    return Scaffold(
      appBar:
          PreferredSize(child: ProfileAppBar(), preferredSize: appBarHeight),
      body: SafeArea(
          child: BlocConsumer<PostCrudBloc, PostCrudState>(
        listener: (context, state) {
          if (state is DeletePostProcessing ||
              state is EditPostDiscProcessing) {
            showProfileEditLodingDialog(context);
          }
        },
        builder: (context, state) {
          return BlocListener<EditProfileBloc, EditProfileState>(
            listener: (context, state) {
              if (state is ProfileShowLoadingDialogue) {
                showProfileEditLodingDialog(context);
              }
            },
            child: ProfileBody(),
          );
        },
      )),
    );
  }
}

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.sm),
          bottomRight: Radius.circular(40.sm)),
      child: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 15.sm),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        title: Text(
          "Profile",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: pureWhite),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/newpost');
              },
              icon: Icon(Icons.add_photo_alternate)),
          IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
          Gap(
            W: 15.sm,
          )
        ],
      ),
    );
  }
}

class ProfileBody extends StatelessWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: constPadding,
      child: BlocBuilder<OthersProfileBloc, OthersProfileState>(
        builder: (context, state) {
          if (state is OthersProfileError) {
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/svg/404.svg",
                      width: 200.sm,
                    ),
                    Gap(H: 20.sm),
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            context.read<ProfileBloc>().add(GetCurrentUser());
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: primaryBlue, width: 0.5),
                              borderRadius: BorderRadius.circular(5.sm)),
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.sm, horizontal: 30.sm),
                              child: Text("Retry")),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else if (state is OthersProfileSuccess) {
            return RefreshIndicator(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              color: primaryBlue,
              onRefresh: () async {
                return WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.read<ProfileBloc>().add(GetCurrentUser());
                });
              },
              child: ListView(
                children: [
                  OthersProfileInfo(),
                  Gap(H: 15.sm),
                  FollowMessageWidget(),
                  // ThemChangeButton(),
                  Gap(H: 15.sm),
                  Text("Posts",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 20.sm, fontWeight: FontWeight.bold)),
                  Divider(
                    thickness: 0.1,
                  ),
                  Gap(H: 10.sm),
                  BlocBuilder<HomeFeedBloc, HomeFeedState>(
                    builder: (context, globaFeedState) {
                      return BlocBuilder<PostCrudBloc, PostCrudState>(
                        builder: (context, deleteState) {
                          if (deleteState is DeletePostSuccess) {
                            state.profileModel.posts.removeWhere((element) {
                              return element.postId.contains(deleteState.id);
                            });

                            if (globaFeedState is HomeFeedSuccess) {
                              globaFeedState.homeFeed.removeWhere((element) {
                                return element.post.postId
                                    .contains(deleteState.id);
                              });
                            }
                          }

                          return ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: List.generate(
                                state.profileModel.posts.length, (index) {
                              return Column(
                                children: [
                                  GlobalPost(
                                    postId: ValueKey(
                                        state.profileModel.posts[index].postId),
                                    post: state.profileModel.posts[index],
                                    user: state.profileModel.user,
                                    index: index,
                                  ),
                                  index == state.profileModel.posts.length - 1
                                      ? Column(
                                          children: [
                                            Divider(thickness: 0.4.sm),
                                            Text("Completed"),
                                          ],
                                        )
                                      : Divider(thickness: 0.4.sm)
                                ],
                              );
                            }),
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            );
          }
          return InnerProfileLoading();
        },
      ),
    );
  }
}

class FollowMessageWidget extends StatelessWidget {
  const FollowMessageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OthersProfileBloc, OthersProfileState>(
      builder: (context, profilestate) {
        bool following = false;
        UserModel user =
            (profilestate as OthersProfileSuccess).profileModel.user;

        if (user.followers.contains(Global.USER_DATA.id)) {
          following = true;
        }

        return BlocBuilder<FollowBloc, FollowState>(
          builder: (context, state) {
            if (state is FollowSuccess) {
              following = true;
            }
            if (state is UnFollowSuccess) {
              following = false;
            }
            return Container(
              child: Row(children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        if (profilestate.profileModel.user.followers
                            .contains(Global.USER_DATA.id)) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            context
                                .read<FollowBloc>()
                                .add(UnFollow(profileId: user.userId));
                          });
                        } else {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            context
                                .read<FollowBloc>()
                                .add(Follow(profileId: user.userId));
                          });
                        }
                      },
                      child: following ? Text("Following") : Text("Follow")),
                ),
                Gap(W: 10.sm),
                ElevatedButton(onPressed: () {}, child: Text("Message"))
              ]),
            );
          },
        );
      },
    );
  }
}
