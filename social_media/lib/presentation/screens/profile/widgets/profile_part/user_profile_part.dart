import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/application/user/current_user/current_user_bloc.dart';

import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/presentation/screens/profile/widgets/edit/edit_cover_image.dart';
import 'package:social_media/presentation/screens/profile/widgets/edit/edit_name_disc.dart';
import 'package:social_media/presentation/screens/profile/widgets/edit/edit_profile_pic.dart';
import 'package:social_media/presentation/widgets/gap.dart';

const dummyProfilePicture = "assets/dummy/dummyDP.png";

class UserProfilePart extends StatelessWidget {
  const UserProfilePart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CurrentUserBloc, CurrentUserState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is FetchCurrentUserSuccess) {
          return Column(
            children: [
              Stack(
                children: [
                  const ProfilePartCoverImageWidget(),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 90.sm, left: 10.sm, right: 10.sm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            UserProfilePartProfileImagWidget(),
                            Spacer(),
                            UserProflePartFollowerWidget()
                          ],
                        ),
                        Gap(
                          H: 10.sm,
                        ),
                        const UserProfileNameAndDiscWIdget()
                      ],
                    ),
                  )
                ],
              ),
            ],
          );
        } else if (state is FetchCurrentUserLoading) {
          return const Center(
            child: Text("Loading"),
          );
        } else {
          return const Center(
            child: Text("oops"),
          );
        }
      },
    );
  }
}

class UserProfileNameAndDiscWIdget extends StatelessWidget {
  const UserProfileNameAndDiscWIdget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CurrentUserBloc, CurrentUserState>(
      listener: (context, state) {},
      builder: (context, state) {
        final userState = state as FetchCurrentUserSuccess;
        final model = userState.data.user;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.sm),
              child: Row(
                children: [
                  Text(
                    model.name,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 18.sm),
                  ),
                  Gap(
                    W: 20.sm,
                  ),
                  GestureDetector(
                    onTap: () {
                      // showEditNameAndDiscSheet(
                      //     context: context,
                      //     disc: model.discription,
                      //     name: model.name);
                    },
                    child: Container(
                      height: 20.sm,
                      width: 20.sm,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.sm),
                          border: Border.all(
                              width: 0.5,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .color!)),
                      child: Icon(
                        Icons.edit,
                        color: Theme.of(context).textTheme.bodyLarge!.color!,
                        size: 15.sm,
                      ),
                    ),
                  )
                ],
              ),
            ),
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
                      model.discription,
                      // maxLines: 3,
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
        );
      },
    );
  }
}

class UserProflePartFollowerWidget extends StatelessWidget {
  const UserProflePartFollowerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserBloc, CurrentUserState>(
      builder: (context, state) {
        final userState = state as FetchCurrentUserSuccess;
        final model = userState.data.user;
        return LimitedBox(
          child: Padding(
            padding: EdgeInsets.only(top: 50.sm),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ItemBox(
                    title: "Followers",
                    value: model.followers.length.toString()),
                Gap(
                  W: 10.sm,
                ),
                ItemBox(
                    title: "Following",
                    value: model.following.length.toString()),
                Gap(
                  W: 10.sm,
                ),
                ItemBox(title: "Posts", value: model.posts.length.toString()),
              ],
            ),
          ),
        );
      },
    );
  }
}

class UserProfilePartProfileImagWidget extends StatelessWidget {
  const UserProfilePartProfileImagWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CurrentUserBloc, CurrentUserState>(
        listener: (context, state) {
      // if (state is ProfileImageSuccess) {
      //   final userState = state as FetchCurrentUserSuccess;

      //   userState.data.user.copyWith(profileImage: state.model.profileImage);
      // }
    }, builder: (context, state) {
      final userState = state as FetchCurrentUserSuccess;
      final model = userState.data.user;

      // return BlocConsumer<RemoveProfileImageBloc, RemoveProfileImageState>(
      //     listener: (context, profileImageState) {
      //   if (profileImageState is ProfileImageSuccess ||
      //       profileImageState is ProfileImageChangeSuccess) {
      //     context.read<CurrentUserBloc>().add(const FetchCurrentuser());
      //   }
      // }, builder: (context, profileImageState) {
      //   if (profileImageState is ProfileImageLoading ||
      //       profileImageState is ProfileImageChanging) {
      //     return CircleAvatar(
      //       radius: 65.sm,
      //       backgroundColor: secondaryBlue,
      //       child: const Center(
      //           child: CircularProgressIndicator(
      //         color: pureWhite,
      //       )),
      //     );

      //   } else {

      return GestureDetector(
        onTap: () {
          // showProfileActionSheet(context: context);
        },
        child: model.profileImage == ""
            ? CircleAvatar(
                radius: 65.sm,
                backgroundColor: darkBlue,
                child: CircleAvatar(
                  backgroundImage: const AssetImage(dummyProfilePicture),
                  radius: 60.sm,
                  backgroundColor: secondaryBlue,
                ),
              )
            : CircleAvatar(
                radius: 65.sm,
                backgroundColor: darkBlue,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(model.profileImage),
                  radius: 60.sm,
                  backgroundColor: secondaryBlue,
                ),
              ),
      );

      // }
    });
    //   },
    // );
  }
}
// GestureDetector(
//                                 onTap: () {
//                                   Navigator.of(context).pushNamed(
//                                       "/editprofile",
//                                       arguments: ScreenArgs(
//                                           args: {'userModel': model}));
//                                 },
//                                 child: Container(
//                                   height: 28.sm,
//                                   width: 28.sm,
//                                   decoration: BoxDecoration(
//                                       color: primaryBlue,
//                                       borderRadius:
//                                           BorderRadius.circular(5.sm)),
//                                   child: Icon(
//                                     Icons.edit,
//                                     color: pureWhite,
//                                     size: 16.sm,
//                                   ),
//                                 ),
//                               )

class ProfilePartCoverImageWidget extends StatelessWidget {
  const ProfilePartCoverImageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserBloc, CurrentUserState>(
        builder: (context, state) {
      final userState = state as FetchCurrentUserSuccess;
      final model = userState.data.user;

      // return BlocConsumer<RemoveCoverImageBloc, RemoveCoverImageState>(
      //   listener: (context, coverStaet) {
      //     if (coverStaet is CoverImageSuccess ||
      //         coverStaet is CoverImageChangeSuccess) {
      //       context.read<CurrentUserBloc>().add(const FetchCurrentuser());
      //     }
      //   },
      //   builder: (context, coverStaet) {
      //     if (coverStaet is CoverImageLoading ||
      //         coverStaet is CoverImageChanging) {
      //       return Container(
      //         constraints: BoxConstraints(maxHeight: 150.sm),
      //         color: secondaryBlue,
      //         width: double.infinity,
      //         child: const Center(
      //             child: CircularProgressIndicator(
      //           color: pureWhite,
      //         )),
      //       );
      //     } else {
      return GestureDetector(
        onTap: () {
          // showCoverActionSheet(context: context);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.sm),
              topRight: Radius.circular(40.sm)),
          child: model.coverImage == "" || model.coverImage.isEmpty
              ? Container(
                  constraints: BoxConstraints(maxHeight: 150.sm),
                  color: primaryBlue,
                  width: double.infinity,
                )
              : Container(
                  width: double.infinity,
                  constraints: BoxConstraints(maxHeight: 150.sm),
                  child: Image.network(
                    model.coverImage,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
      );
    }
        //       },
        //     );
        //   },
        // );
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