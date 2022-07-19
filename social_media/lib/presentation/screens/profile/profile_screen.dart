import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media/application/edit_profile_pics/edit_profile_bloc.dart';
import 'package:social_media/application/profile/profile_bloc.dart';

import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/core/constants/constants.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';
import 'package:social_media/presentation/screens/profile/edit/dialog.dart';
import 'package:social_media/presentation/screens/profile/widgets/profile_info.dart';
import 'package:social_media/presentation/shimmers/inner_profile_shimmer.dart';
import 'package:social_media/presentation/widgets/gap.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {});

    return Scaffold(
      appBar:
          PreferredSize(child: ProfileAppBar(), preferredSize: appBarHeight),
      body: SafeArea(
          child: BlocListener<EditProfileBloc, EditProfileState>(
        listener: (context, state) {
          if (state is ProfileShowLoadingDialogue) {
            showProfileEditLodingDialog(context);
          }
        },
        child: ProfileBody(),
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
                // showNewPostBottomSheet(context: context);
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
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileError) {
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
          } else if (state is ProfileLoading) {
            return InnerProfileLoading();
          }

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
                ProfileInfo(),
                Gap(H: 20.sm),
                Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}

// InnerProfilePart(),
//               Gap(
//                 H: 20.sm,
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "POSTS",
//                       style: Theme.of(context)
//                           .textTheme
//                           .titleMedium!
//                           .copyWith(fontSize: 18),
//                     ),
//                     Divider(),
//                     state is GetUserSuccess
//                         ? ProfilePostsSection()
//                         : state is GetUserError
//                             ? Column(children: [
//                                 SvgPicture.asset(
//                                   "assets/svg/404.svg",
//                                   width: 300.sm,
//                                 ),
//                                 Gap(H: 10.sm),
//                                 MaterialButton(
//                                     shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(3.sm)),
//                                     onPressed: () {
//                                       WidgetsBinding.instance
//                                           .addPostFrameCallback((_) {
//                                         context
//                                             .read<ProfileBloc>()
//                                             .add(GetUser());
//                                       });
//                                     })
//                               ])
//                             : Center(
//                                 child: CircularProgressIndicator(
//                                     color: Theme.of(context)
//                                         .textTheme
//                                         .bodyMedium!
//                                         .color),
//                               ),
//                   ],
//                 ),
//               )
