import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/application/home/home_feed_bloc.dart';
import 'package:social_media/core/constants/constants.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/presentation/screens/home/end_drawer.dart';
import 'package:social_media/presentation/screens/posts_screen/posts_screen.dart';
import 'package:social_media/presentation/widgets/gap.dart';

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
      endDrawer: EndDrawer(),
      key: _homeScaffold,
      appBar: PreferredSize(
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
                    if (value == 3) {
                      // WidgetsBinding.instance.addPostFrameCallback((_) {
                      //   context.read<UserDataBloc>().add(GetCurrentUser());
                      // });
                      _homeScaffold.currentState!.openEndDrawer();
                    } else {
                      _bottomNav.value = value;
                      _bottomNav.notifyListeners();
                    }
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
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.house,
                      ),
                      label: "Home",
                    ),
                    // BottomNavigationBarItem(
                    //   icon: Icon(Icons.add_photo_alternate),
                    //   label: "Add New Post",
                    // ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.search),
                      label: "Search",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.forum),
                      label: "Chats",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.menu),
                      label: "Menu",
                    ),
                  ]),
            ),
          );
        },
      ),
      resizeToAvoidBottomInset: false,
      body: ValueListenableBuilder(
          valueListenable: _bottomNav,
          builder: (context, int, _) {
            return SafeArea(child: _screens[_bottomNav.value]);
          }),
    );
  }
}

final _screens = [
  PostsScreen(),
  Scaffold(),
  Scaffold(),
  Scaffold(),
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
      child: AppBar(
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
                        context.read<HomeFeedBloc>().add(GetHomeFeed());
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
        title: Text("APPLICATION",
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 23)),
        actions: [
          // Gap(W: 40.sm),
          // SizedBox(
          //   height: 20.sm,
          //   width: 20,
          //   child: Lottie.asset("assets/lottie/60041-upload.json"),
          // ),
          // Gap(W: 15.sm),
          IconButton(
            icon: Icon(Icons.add_photo_alternate),
            onPressed: () {
              Navigator.of(context).pushNamed('/newpost');
            },
          ),
          Gap(W: 20.sm),
        ],
      ),
    );
  }
}
