import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/application/edit_profile_pics/edit_profile_bloc.dart';
import 'package:social_media/application/post_crud/post_crud_bloc.dart';
import 'package:social_media/application/profile/profile_bloc.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/domain/models/post_model/post_model.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';
import 'package:social_media/presentation/router/router.dart';
import 'package:social_media/presentation/screens/new_post/new_post_screen.dart';
import 'package:social_media/presentation/screens/profile/edit/edit_cover_picture.dart';
import 'package:social_media/presentation/screens/profile/edit/edit_name_discr.dart';
import 'package:social_media/presentation/screens/profile/edit/edit_profile_picture.dart';
import 'package:social_media/presentation/widgets/gap.dart';

final dummyProfilePicture = "assets/dummy/dummyDP.png";

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          UserModel user = (state as ProfileSuccess).profileModel.user;
          List<PostModel> posts = (state as ProfileSuccess).profileModel.posts;

          return BlocBuilder<EditProfileBloc, EditProfileState>(
            builder: (context, nameAndDiscState) {
              if (nameAndDiscState is NAmeAndDiscChangeSuccess) {
                user.discription = nameAndDiscState.obj.disc;
              }
              return Column(
                children: [
                  Stack(
                    children: [
                      ProfileCoverWidget(user: user),
                      ProfileImageAndNameWidget(user: user, posts: posts)
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
            },
          );
        }

        // return const Center(
        //   child: Text("Oops Someting went wrongs"),
        // );
        // },
        );
  }
}

class ProfileImageAndNameWidget extends StatelessWidget {
  const ProfileImageAndNameWidget({
    Key? key,
    required this.user,
    required this.posts,
  }) : super(key: key);

  final UserModel user;
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
              BlocBuilder<EditProfileBloc, EditProfileState>(
                builder: (context, state) {
                  if (state is ProfilePicChangeSuccess) {
                    user.profileImage = state.newProfilePic;
                  }
                  return Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      user.profileImage == null
                          ? CircleAvatar(
                              radius: 65.sm,
                              backgroundColor: darkBlue,
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage(dummyProfilePicture),
                                radius: 60.sm,
                                backgroundColor: Colors.grey[400],
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    '/seeimageonline',
                                    arguments: ScreenArgs(
                                        args: {'path': user.profileImage}));
                              },
                              child: CircleAvatar(
                                radius: 65.sm,
                                backgroundColor: darkBlue,
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(user.profileImage!),
                                  radius: 60.sm,
                                  backgroundColor: Colors.grey[400],
                                ),
                              ),
                            ),
                      CircleAvatar(
                        radius: 15.sm,
                        backgroundColor: primaryBlue,
                        foregroundColor: pureWhite,
                        child: IconButton(
                          icon: Icon(
                            Icons.add_photo_alternate,
                            size: 15.sm,
                          ),
                          onPressed: () {
                            showEditProfileBottomSheet(context);
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
              const Spacer(),
              LimitedBox(
                child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    return Padding(
                      padding: EdgeInsets.only(top: 50.sm),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ItemBox(
                              title: "Followers",
                              value: user.followers.length.toString()),
                          Gap(
                            W: 10.sm,
                          ),
                          ItemBox(
                              title: "Following",
                              value: user.following.length.toString()),
                          Gap(
                            W: 10.sm,
                          ),
                          BlocBuilder<PostCrudBloc, PostCrudState>(
                            builder: (context, countState) {
                              int length = posts.length;

                              if (countState is DeletePostSuccess) {
                                length = (state as ProfileSuccess)
                                    .profileModel
                                    .posts
                                    .length;
                              }

                              return ItemBox(
                                title: "Posts",
                                value: length.toString(),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
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
                BlocBuilder<EditProfileBloc, EditProfileState>(
                  builder: (context, state) {
                    if (state is NAmeAndDiscChangeSuccess) {
                      user.name = state.obj.name;
                    }
                    return Text(
                      user.name,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 18.sm),
                    );
                  },
                ),
                Gap(W: 15.sm),
                CircleAvatar(
                  radius: 10.sm,
                  backgroundColor: primaryBlue,
                  foregroundColor: pureWhite,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.edit,
                      size: 10.sm,
                    ),
                    onPressed: () {
                      showEditNameAndDiscSheet(context);
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ProfileCoverWidget extends StatelessWidget {
  const ProfileCoverWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      builder: (context, state) {
        if (state is CoverPicChangeSuccess) {
          user.coverImage = state.newCoverPic;
        }
        return Stack(
          alignment: Alignment.bottomRight,
          children: [
            user.coverImage == null
                ? Container(
                    constraints: BoxConstraints(maxHeight: 150.sm),
                    color: Theme.of(context).canvasColor,
                    width: double.infinity,
                  )
                : GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/seeimageonline',
                          arguments:
                              ScreenArgs(args: {'path': user.coverImage}));
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
                  ),
            Padding(
              padding: EdgeInsets.all(7.sm),
              child: CircleAvatar(
                radius: 15.sm,
                backgroundColor: primaryBlue,
                foregroundColor: pureWhite,
                child: IconButton(
                  icon: Icon(
                    Icons.add_photo_alternate,
                    size: 15.sm,
                  ),
                  onPressed: () {
                    showEditCoverBottomSheet(context);
                  },
                ),
              ),
            ),
          ],
        );
      },
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
