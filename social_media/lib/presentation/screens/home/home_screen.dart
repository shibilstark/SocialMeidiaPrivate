import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media/application/edit_profile_pics/edit_profile_bloc.dart';
import 'package:social_media/application/home/home_feed_bloc.dart';
import 'package:social_media/application/profile/profile_bloc.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/core/constants/constants.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/presentation/screens/home/end_drawer.dart';
import 'package:social_media/presentation/screens/posts_screen/posts_screen.dart';
import 'package:social_media/presentation/screens/profile/profile_screen.dart';
import 'package:social_media/presentation/screens/search_screen/search_screen.dart';
import 'package:social_media/presentation/widgets/gap.dart';
import 'package:social_media/presentation/widgets/theme_switch.dart';

ValueNotifier<int> _bottomNav = ValueNotifier(0);
final globalBucket = PageStorageBucket();

class HomeScreen extends StatelessWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);

  final _homeScaffold = GlobalKey<ScaffoldState>(debugLabel: "homeScaffold");
  openDrawer() {
    _homeScaffold.currentState!.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    log(Global.USER_DATA.email);
    return Scaffold(
      endDrawer: const EndDrawer(),
      key: _homeScaffold,
      appBar: const PreferredSize(
        preferredSize: appBarHeight,
        child: MainAppBar(),
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: _bottomNav,
        builder: (BuildContext context, int index, _) {
          return ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.sm),
                topRight: Radius.circular(40.sm)),
            child: SizedBox(
              height: 62.sm,
              child: BottomNavigationBar(
                  currentIndex: _bottomNav.value,
                  onTap: (value) {
                    // if (value == 3) {
                    //   // WidgetsBinding.instance.addPostFrameCallback((_) {
                    //   //   context.read<UserDataBloc>().add(GetCurrentUser());
                    //   // });
                    //   _homeScaffold.currentState!.openEndDrawer();
                    // } else {
                    // _bottomNav.value = value;
                    // _bottomNav.notifyListeners();
                    // }
                    _bottomNav.value = value;
                    _bottomNav.notifyListeners();
                  },
                  selectedIconTheme:
                      Theme.of(context).primaryIconTheme.copyWith(size: 27.sm),
                  unselectedIconTheme: Theme.of(context)
                      .primaryIconTheme
                      .copyWith(
                          color: Theme.of(context)
                              .primaryIconTheme
                              .color!
                              .withOpacity(0.7)),
                  // backgroundColor: primaryBlue,
                  elevation: 5,
                  showUnselectedLabels: false,
                  showSelectedLabels: false,
                  type: BottomNavigationBarType.fixed,
                  items: [
                    const BottomNavigationBarItem(
                      icon: Icon(
                        Icons.house,
                      ),
                      label: "Home",
                    ),
                    // BottomNavigationBarItem(
                    //   icon: Icon(Icons.add_photo_alternate),
                    //   label: "Add New Post",
                    // ),
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.search),
                      label: "Search",
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.forum),
                      label: "Chats",
                    ),
                    BottomNavigationBarItem(
                      icon: BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                          if (state is ProfileSuccess) {
                            return BlocBuilder<EditProfileBloc,
                                EditProfileState>(
                              builder: (context, editState) {
                                if (editState is ProfilePicChangeSuccess) {
                                  state.profileModel.user.profileImage =
                                      editState.newProfilePic;
                                }

                                return state.profileModel.user.profileImage ==
                                        null
                                    ? CircleAvatar(
                                        radius: 13.sm,
                                        backgroundColor: secondaryBlue,
                                        backgroundImage: const AssetImage(
                                            "assets/dummy/dummyDP.png"),
                                      )
                                    : CircleAvatar(
                                        radius: 13.sm,
                                        backgroundColor: secondaryBlue,
                                        backgroundImage: NetworkImage(state
                                            .profileModel.user.profileImage!),
                                      );
                              },
                            );
                          } else {
                            return CircleAvatar(
                              radius: 13.sm,
                            );
                          }
                        },
                      ),
                      label: "Profile",
                    ),
                  ]),
            ),
          );
        },
      ),
      resizeToAvoidBottomInset: false,
      body: ValueListenableBuilder(
          valueListenable: _bottomNav,
          builder: (context, int val, _) {
            return SafeArea(child: _screens[_bottomNav.value]);
          }),
    );
  }
}

final _screens = [
  const PostsScreen(),
  const SearchScreen(),
  const Scaffold(),
  const ProfileScreen(),
];

// ValueNotifier<bool> _theme = ValueNotifier(false);

class MainAppBar extends StatelessWidget {
  const MainAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.sm),
          bottomRight: Radius.circular(40.sm)),
      child: ValueListenableBuilder(
          valueListenable: _bottomNav,
          builder: (context, int val, _) {
            return AppBar(
              // backgroundColor: Theme.of(context).appBarTheme.color,
              elevation: 2,
              // titleSpacing: 45.sm,
              centerTitle: true,

              leading: Padding(
                padding: EdgeInsets.only(left: 30.sm),
                child: Builder(builder: (context) {
                  return Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Center(
                        child: IconButton(
                            onPressed: () {
                              context
                                  .read<HomeFeedBloc>()
                                  .add(const GetHomeFeed());
                            },
                            icon: IconTheme(
                              data: Theme.of(context).primaryIconTheme,
                              child: Icon(
                                Icons.notifications,
                                size: 25.sm,
                              ),
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 15.sm, right: 10.sm),
                        child: CircleAvatar(
                          radius: 4.sm,
                          backgroundColor: Colors.redAccent,
                        ),
                      ),
                    ],
                  );
                }),
              ),

              automaticallyImplyLeading: false,
              title: Text(
                "App Name",
                // style: Theme.of(context)
                //     .textTheme
                //     .titleLarge!
                //     .copyWith(fontSize: 23),
                style: GoogleFonts.mouseMemoirs().copyWith(fontSize: 23.sm),
              ),
              actions: [
                // Gap(W: 40.sm),
                // SizedBox(
                //   height: 20.sm,
                //   width: 20,
                //   child: Lottie.asset("assets/lottie/60041-upload.json"),
                // ),
                // Gap(W: 15.sm),
                IconButton(
                  icon: const Icon(Icons.add_photo_alternate),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/newpost');
                  },
                ),
                val == 3 ? Gap(W: 5.sm) : Gap(W: 20.sm),
                val == 3
                    ? IconButton(
                        icon: const Icon(Icons.settings),
                        onPressed: () {},
                      )
                    : SizedBox(),

                val == 3 ? Gap(W: 20.sm) : SizedBox(),
              ],
            );
          }),
    );
  }
}

gotoProfile() {
  _bottomNav.value = 3;
  _bottomNav.notifyListeners();
}
