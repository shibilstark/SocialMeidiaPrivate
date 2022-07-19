import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media/application/edit_profile_pics/edit_profile_bloc.dart';
import 'package:social_media/application/profile/profile_bloc.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/domain/models/post_model/post_model.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';
import 'package:social_media/presentation/screens/profile/edit/edit_cover_picture.dart';
import 'package:social_media/presentation/screens/profile/edit/edit_name_discr.dart';
import 'package:social_media/presentation/screens/profile/edit/edit_profile_picture.dart';
import 'package:social_media/presentation/shimmers/inner_profile_shimmer.dart';
import 'package:social_media/presentation/shimmers/profile_part_shimmer.dart';
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

          return Column(
            children: [
              Stack(
                // alignment: Alignment.,
                children: [
                  BlocBuilder<EditProfileBloc, EditProfileState>(
                    builder: (context, state) {
                      if (state is CoverPicChangeSuccess) {
                        user.coverImage = state.newCoverPic;
                      }
                      return Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          user.coverImage == null
                              ? Container(
                                  constraints:
                                      BoxConstraints(maxHeight: 150.sm),
                                  color: Theme.of(context).canvasColor,
                                  width: double.infinity,
                                )
                              : GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width: double.infinity,
                                    constraints:
                                        BoxConstraints(maxHeight: 150.sm),
                                    child: FadeInImage(
                                        fadeInDuration:
                                            Duration(milliseconds: 100),
                                        fit: BoxFit.cover,
                                        image: NetworkImage(user.coverImage!),
                                        placeholder:
                                            AssetImage(dummyProfilePicture)),
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
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 90.sm, left: 10.sm, right: 10.sm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.center,
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
                                              backgroundImage: AssetImage(
                                                  dummyProfilePicture),
                                              radius: 60.sm,
                                              backgroundColor: Colors.grey[400],
                                            ),
                                          )
                                        : CircleAvatar(
                                            radius: 65.sm,
                                            backgroundColor: darkBlue,
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  user.profileImage!),
                                              radius: 60.sm,
                                              backgroundColor: Colors.grey[400],
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
                              child: Padding(
                                padding: EdgeInsets.only(top: 50.sm),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ItemBox(
                                        title: "Followers",
                                        value:
                                            user.followers.length.toString()),
                                    Gap(
                                      W: 10.sm,
                                    ),
                                    ItemBox(
                                        title: "Following",
                                        value:
                                            user.following.length.toString()),
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
                  )
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
                                child: BlocBuilder<EditProfileBloc,
                                    EditProfileState>(
                                  builder: (context, state) {
                                    if (state is NAmeAndDiscChangeSuccess) {
                                      user.discription = state.obj.disc;
                                    }
                                    return Text(
                                      user.discription!,
                                      // maxLines: 3,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(fontSize: 15.sm),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
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
      width: 70.sm,
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
                .copyWith(fontSize: 15.sm),
          ),
          Gap(
            H: 5.sm,
          ),
          Text(
            value,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontSize: 17.sm),
          )
        ],
      ),
    );
  }
}



 // model.userId != Global.USER_DATA.id
                    //     ? Column(
                    //         children: [
                    //           Gap(
                    //             H: 10.sm,
                    //           ),
                    //           Row(
                    //             children: [
                    //               Expanded(
                    //                   child: ElevatedButton(
                    //                 child: Text(
                    //                   "Follow",
                    //                   style: Theme.of(context)
                    //                       .textTheme
                    //                       .titleSmall!
                    //                       .copyWith(
                    //                           fontSize: 15.sm,
                    //                           fontWeight: FontWeight.w500),
                    //                 ),
                    //                 onPressed: () {},
                    //               )),
                    //               Gap(
                    //                 W: 20.sm,
                    //               ),
                    //               Expanded(
                    //                   child: ElevatedButton(
                    //                 child: Text(
                    //                   "Message",
                    //                   style: Theme.of(context)
                    //                       .textTheme
                    //                       .titleSmall!
                    //                       .copyWith(
                    //                           fontSize: 15.sm,
                    //                           fontWeight: FontWeight.w500),
                    //                 ),
                    //                 onPressed: () {},
                    //               )),
                    //             ],
                    //           ),
                    //         ],
                    //       )
                    //     : SizedBox(),