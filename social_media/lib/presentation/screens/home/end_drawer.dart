// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media/application/auth/auth_bloc.dart';
import 'package:social_media/application/profile/profile_bloc.dart';
import 'package:social_media/application/theme/theme_bloc.dart';

import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';
import 'package:social_media/presentation/router/router.dart';
import 'package:social_media/presentation/shimmers/profile_part_shimmer.dart';
import 'package:social_media/presentation/widgets/gap.dart';
import 'package:social_media/presentation/widgets/theme_switch.dart';
import '../../../core/constants/enums.dart';

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
            child: ListView(
              children: [
                const EndDrawerMiniProfile(),
                Container(
                  padding: EdgeInsets.all(20.sm),
                  child: Column(
                    children: [
                      ThemChangeButton(),
                      const Divider(),
                      const MenuTiles(
                        icon: Icons.settings,
                        title: "Settings",
                        whereTo: Scaffold(),
                      ),
                      const Divider(),
                      const MenuTiles(
                        icon: Icons.privacy_tip,
                        title: "Privacy Policy",
                        whereTo: Scaffold(),
                      ),
                      const Divider(),
                      const MenuTiles(
                        icon: Icons.gavel,
                        title: "Terms % Conditions",
                        whereTo: Scaffold(),
                      ),
                      const Divider(),
                      const MenuTiles(
                        icon: Icons.info,
                        title: "About",
                        whereTo: Scaffold(),
                      ),
                      const Divider(),
                      const MenuTiles(
                        icon: Icons.redeem,
                        title: "Invite a Friend",
                        whereTo: Scaffold(),
                      ),
                      const Divider(),
                      const MenuTiles(
                        icon: Icons.spoke,
                        title: "Connect with us",
                        whereTo: Scaffold(),
                      ),
                      const Divider(),
                      const LogOutTile(),
                      const Divider(
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
          Navigator.of(context).popAndPushNamed("/profile");
        },
        child: Container(
            padding: EdgeInsets.all(20.sm),
            color: primaryBlue,
            child: Container(
                height: 50.sm,
                child: BlocConsumer<ProfileBloc, ProfileState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is ProfileError) {
                      return Row(
                        children: [
                          SvgPicture.asset(
                            "assets/svg/404.svg",
                            height: 50.sm,
                          ),
                          Gap(W: 20.sm),
                          Expanded(
                              child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3.sm)),
                            onPressed: () {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                context
                                    .read<ProfileBloc>()
                                    .add(GetCurrentUser());
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Reload",
                                  style: TextStyle(
                                      color: pureWhite,
                                      fontSize: 15.sm,
                                      fontWeight: FontWeight.normal),
                                ),
                                Gap(W: 10.sm),
                                Icon(
                                  Icons.replay,
                                  size: 20.sm,
                                  color: smoothWhite,
                                ),
                              ],
                            ),
                          ))
                        ],
                      );
                    }
                    if (state is ProfileSuccess) {
                      final user = (state as ProfileSuccess).profileModel.user;

                      return Row(children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            user.profileImage == null
                                ? CircleAvatar(
                                    radius: 25.sm,
                                    backgroundColor: secondaryBlue,
                                    backgroundImage: const AssetImage(
                                        "assets/dummy/dummyDP.png"),
                                  )
                                : CircleAvatar(
                                    radius: 25.sm,
                                    backgroundColor: secondaryBlue,
                                    backgroundImage:
                                        NetworkImage(user.profileImage!),
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
                                  user.email,
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
                        ),
                      ]);
                    }

                    return const ProfilePartLoading();
                  },
                ))));
  }
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
            onTap: () async {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                context.read<AuthBloc>().add(LoggedOut());
                Navigator.of(context).pushReplacementNamed('/login');
              });
            },
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
