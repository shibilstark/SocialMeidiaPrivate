import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/application/user/current_user/current_user_bloc.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/core/constants/constants.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';
import 'package:social_media/presentation/screens/profile/widgets/post_section/post_section.dart';
import 'package:social_media/presentation/screens/profile/widgets/profile_part/user_profile_part.dart';
import 'package:social_media/presentation/shimmers/inner_profile_shimmer.dart';
import 'package:social_media/presentation/widgets/gap.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key, required this.userId}) : super(key: key);

  final String userId;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {});

    return const Scaffold(
      appBar:
          PreferredSize(child: ProfileAppBar(), preferredSize: appBarHeight),
      body: SafeArea(child: ProfileBody()),
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
            icon: const Icon(Icons.arrow_back),
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
              icon: const Icon(Icons.add_photo_alternate)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
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
      child: BlocConsumer<CurrentUserBloc, CurrentUserState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is FetchCurrentUserLoading) {
            return ListView(
              children: const [
                InnerProfileLoading(),
              ],
            );
          } else if (state is FetchCurrentUserError) {
            return const Center(
              child: Text("oops Somthing went wrong"),
            );
          } else {
            return RefreshIndicator(
              color: Theme.of(context).appBarTheme.backgroundColor,
              onRefresh: () async {
                context.read<CurrentUserBloc>().add(FetchCurrentuser());
              },
              child: ListView(
                children: [
                  UserProfilePart(),
                  Gap(
                    H: 20.sm,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "POSTS",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 18),
                        ),
                        const Divider(),
                        const ProfilePostsSection(),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
