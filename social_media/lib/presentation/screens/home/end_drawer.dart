import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/application/user/current_user/current_user_bloc.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/presentation/routes/app_router.dart';
import 'package:social_media/presentation/screens/profile/widgets/profile_part/user_profile_part.dart';
import 'package:social_media/presentation/shimmers/profile_part_shimmer.dart';
import 'package:social_media/presentation/widgets/gap.dart';
import 'package:social_media/presentation/widgets/theme_change_switch.dart';

class EndDrawer extends StatelessWidget {
  const EndDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60.sm),
          // bottomLeft: Radius.circular(40.sm)
        ),
        child: Drawer(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const EndDrawerMiniProfile(),
                  Container(
                    padding: EdgeInsets.all(20.sm),
                    child: Column(
                      children: const [
                        ThemChangeSwitch(),
                        Divider(),
                        MenuTiles(
                          icon: Icons.settings,
                          title: "Settings",
                          whereTo: Scaffold(),
                        ),
                        Divider(),
                        MenuTiles(
                          icon: Icons.privacy_tip,
                          title: "Privacy Policy",
                          whereTo: Scaffold(),
                        ),
                        Divider(),
                        MenuTiles(
                          icon: Icons.gavel,
                          title: "Terms % Conditions",
                          whereTo: Scaffold(),
                        ),
                        Divider(),
                        MenuTiles(
                          icon: Icons.info,
                          title: "About",
                          whereTo: Scaffold(),
                        ),
                        Divider(),
                        MenuTiles(
                          icon: Icons.redeem,
                          title: "Invite a Friend",
                          whereTo: Scaffold(),
                        ),
                        Divider(),
                        MenuTiles(
                          icon: Icons.spoke,
                          title: "Connect with us",
                          whereTo: Scaffold(),
                        ),
                        Divider(),
                        LogOutTile(),
                        Divider(
                          color: primary,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EndDrawerMiniProfile extends StatelessWidget {
  const EndDrawerMiniProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).popAndPushNamed("/profile",
              arguments: ScreenArgs(args: {"userId": Global.USER_DATA.id}));
        },
        child: Container(
            padding: EdgeInsets.all(20.sm),
            color: primaryBlue,
            child: BlocConsumer<CurrentUserBloc, CurrentUserState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is FetchCurrentUserError) {
                  return Container(
                    height: 100.sm,
                    child: Center(child: Text("OOPS")),
                  );
                } else if (state is FetchCurrentUserSuccess) {
                  final user = state.data.user;
                  final profile = user.profileImage;
                  final email = user.email;

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      profile == "" || profile.isEmpty
                          ? CircleAvatar(
                              radius: 25.sm,
                              backgroundColor: secondaryBlue,
                              backgroundImage: AssetImage(dummyProfilePicture),
                            )
                          : CircleAvatar(
                              radius: 25.sm,
                              backgroundColor: secondaryBlue,
                              backgroundImage: NetworkImage(profile),
                            ),
                      Gap(
                        W: 10.sm,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            // user == null ? "" : user.name,
                            user.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontSize: 17.sm,
                                    fontWeight: FontWeight.w500,
                                    color: pureWhite),
                          ),
                          Gap(
                            H: 3.sm,
                          ),
                          Text(
                            // user == null ? "" : user.email,
                            email,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: pureWhite.withOpacity(0.7),
                                  fontSize: 12.sm,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return ProfilePartLoading();
                }
              },
            )));
  }
  // ),
  //     ),
  //   );
  // }
}

class LogOutTile extends StatelessWidget {
  const LogOutTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return GestureDetector(
            onTap: () async {},
            child: SizedBox(
              height: 35.sm,
              child: Row(
                children: [
                  IconTheme(
                      data: Theme.of(context).iconTheme,
                      child: const Icon(
                        Icons.logout,
                        size: 20,
                      )),
                  Gap(
                    W: 10.sm,
                  ),
                  Text(
                    "Log Out",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 18.sm, fontWeight: FontWeight.w400),
                    //   ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}

class MenuTiles extends StatelessWidget {
  const MenuTiles(
      {Key? key,
      required this.icon,
      required this.title,
      required this.whereTo})
      : super(key: key);

  final String title;
  final IconData icon;
  final Scaffold whereTo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => whereTo));
      },
      child: SizedBox(
        height: 35.sm,
        child: Row(
          children: [
            IconTheme(
                data: Theme.of(context).iconTheme,
                child: Icon(
                  icon,
                  size: 20,
                )),
            Gap(
              W: 10.sm,
            ),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: 18.sm, fontWeight: FontWeight.w400),
              //   ),
            ),
          ],
        ),
      ),
    );
  }
}
