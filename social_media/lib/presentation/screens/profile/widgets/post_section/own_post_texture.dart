import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';
import 'package:social_media/application/user/current_user/current_user_bloc.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/domain/models/post_model/post_model.dart';
import 'package:social_media/presentation/routes/app_router.dart';
import 'package:social_media/presentation/widgets/dummy_profile.dart';
import 'package:social_media/presentation/widgets/gap.dart';

final _dropItems = [
  "Follw",
  "Report",
];

const dummyLongText =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec egestas posuere pretium. Nam volutpat dictum lorem in volutpat. Aenean convallis ipsum sed sagittis bibendum. Sed ut bibendum velit, a consectetur est. Suspendisse feugiat nulla in felis mollis dignissim et id lectus. Nullam nec massa orci. Curabitur odio tellus, tempus ut imperdiet in, ullamcorper nec nibh. Praesent nisi nunc";

DropdownMenuItem<String> _buildMenuItem(String item) {
  return DropdownMenuItem(
    child: Text(
      item,
      style: TextStyle(
        fontSize: 15.sm,
        fontWeight: FontWeight.w400,
        color: primary,
      ),
    ),
    value: item,
  );
}

class OwnPostTexture extends StatelessWidget {
  const OwnPostTexture({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserBloc, CurrentUserState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserProfileTopPotionWidget(index: index),
            Gap(H: 10.sm),
            UserProfilePostPart(index: index),
            Gap(H: 5.sm),
            UserProfileTagAndDicriptionWidget(index: index),
          ],
        );
      },
    );
  }
}

class UserProfileTagAndDicriptionWidget extends StatelessWidget {
  const UserProfileTagAndDicriptionWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserBloc, CurrentUserState>(
      builder: (context, state) {
        final userState = state as FetchCurrentUserSuccess;
        final post = userState.data.post[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserProfileInteractionCountWidget(index: index),
            Gap(H: 10.sm),
            Row(
              children: [
                post.tag == "" || post.tag == null
                    ? SizedBox()
                    : Text(
                        post.tag.toString(),
                        // style: Theme.of(context).textTheme.bodyMedium,
                        style: TextStyle(
                          color: primary,
                          fontSize: 14.sm,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                Spacer(),
              ],
            ),
            Gap(
              H: 5.sm,
            ),
            post.discription == "" || post.discription == null
                ? SizedBox()
                : ReadMoreText(
                    dummyLongText,
                    trimMode: TrimMode.Line,
                    trimLines: 2,
                    trimCollapsedText: 'Read More',
                    trimExpandedText: 'Read Less',
                    lessStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 13.sm,
                        color: primary.withOpacity(0.7),
                        fontWeight: FontWeight.w500),
                    moreStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 13.sm,
                        color: primary.withOpacity(0.7),
                        fontWeight: FontWeight.w500),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
            Gap(H: 10.sm),
            Row(
              children: [
                PostActionButton(icon: Icons.bolt_outlined),
                Gap(W: 10.sm),
                PostActionButton(icon: Icons.comment),
                Gap(W: 10.sm),
                PostActionButton(icon: Icons.download),
              ],
            ),
          ],
        );
      },
    );
  }
}

class UserProfileInteractionCountWidget extends StatelessWidget {
  const UserProfileInteractionCountWidget({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserBloc, CurrentUserState>(
      builder: (context, state) {
        final userState = state as FetchCurrentUserSuccess;
        final post = userState.data.post[index];
        return Row(
          children: [
            LimitedBox(
              child: Row(
                children: [
                  IconTheme(
                      data: Theme.of(context).iconTheme,
                      child: Icon(
                        Icons.bolt,
                        size: 13.sm,
                      )),
                  Text(
                    "${post.lights.length} lights",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            Spacer(),
            LimitedBox(
              child: Row(
                children: [
                  IconTheme(
                      data: Theme.of(context).iconTheme,
                      child: Icon(
                        Icons.comment,
                        size: 13.sm,
                      )),
                  Text(
                    "  ${post.comments.length} Comments",
                    style: Theme.of(context).textTheme.bodyMedium,
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

class UserProfilePostPart extends StatelessWidget {
  const UserProfilePostPart({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserBloc, CurrentUserState>(
      builder: (context, state) {
        final userState = state as FetchCurrentUserSuccess;
        final post = userState.data.post[index];
        return GestureDetector(
          onTap: () {
            if (post.type == PostType.image) {
              Navigator.of(context).pushNamed('/seeimageonline',
                  arguments: ScreenArgs(args: {'path': post.post}));
            } else {
              Navigator.of(context).pushNamed('/onlinevideoplayer',
                  arguments: ScreenArgs(args: {'path': post.post}));
            }
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.sm),
            child: post.type == PostType.video
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        color: darkBg,
                        height: 250.sm,
                        width: double.infinity,
                        child: Opacity(
                          opacity: 0.5,
                          child: Image.network(
                            post.videoThumbnail!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 30.sm,
                        backgroundColor: darkBg.withOpacity(0.3),
                        child: Icon(
                          Icons.play_arrow_rounded,
                          size: 30.sm,
                          color: pureWhite,
                        ),
                      )
                    ],
                  )
                : Container(
                    child: Center(
                      child: post.post == "" || post.post.isEmpty
                          ? SizedBox()
                          : Image.network(
                              post.post,
                              fit: BoxFit.fitWidth,
                            ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}

class UserProfileTopPotionWidget extends StatelessWidget {
  const UserProfileTopPotionWidget({Key? key, required this.index})
      : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserBloc, CurrentUserState>(
      builder: (context, state) {
        final userState = state as FetchCurrentUserSuccess;
        final user = userState.data.user;
        final post = userState.data.post[index];
        return Row(
          children: [
            LimitedBox(
                child: Row(
              children: [
                user.profileImage == "" || user.profileImage.isEmpty
                    ? DummyProfile()
                    : CircleAvatar(
                        radius: 20.sm,
                        backgroundColor: secondaryBlue,
                        backgroundImage: NetworkImage(user.profileImage),
                      ),
                Gap(W: 10.sm),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      post.createdAt.toLocal().toString().split(" ").first,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 11.sm),
                    ),
                  ],
                )
              ],
            )),
            Spacer(),
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                items: _dropItems.map(_buildMenuItem).toList(),
                onChanged: (value) {},
                icon: IconTheme(
                  data: Theme.of(context).iconTheme.copyWith(size: 18),
                  child: Icon(
                    Icons.more_vert,
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

class PostActionButton extends StatelessWidget {
  const PostActionButton({Key? key, required this.icon}) : super(key: key);
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 0.1.sm, color: darkBlue),
            borderRadius: BorderRadius.circular(15.sm)),
        child: IconButton(
          constraints: BoxConstraints(maxHeight: 36.sm, maxWidth: 36.sm),
          icon: IconTheme(
              data: Theme.of(context).iconTheme,
              child: Icon(
                icon,
                size: 22.sm,
                // color: primaryBlue.withOpacity(0.7),
              )),
          onPressed: () {},
        ),
      ),
    );
  }
}
