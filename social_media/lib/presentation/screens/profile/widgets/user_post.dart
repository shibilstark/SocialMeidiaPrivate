import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/application/post_crud/post_crud_bloc.dart';
import 'package:social_media/application/profile/profile_bloc.dart';
import 'package:social_media/presentation/screens/new_post/new_post_screen.dart';
import 'package:social_media/presentation/screens/profile/widgets/edit_post.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/domain/models/post_model/post_model.dart';
import 'package:social_media/domain/models/profile_model/profile_model.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';
import 'package:social_media/presentation/router/router.dart';
import 'package:social_media/presentation/screens/profile/widgets/profile_info.dart';
import 'package:social_media/presentation/widgets/dummy_profile.dart';
import 'package:social_media/presentation/widgets/gap.dart';

class UserPost extends StatelessWidget {
  UserPost({
    required Key? postId,
    required this.index,
    required this.profileModel,
  }) : super(key: postId);
  final int index;
  ProfileModel profileModel;

  @override
  Widget build(BuildContext context) {
    UserModel user = profileModel.user;
    List<PostModel> posts = profileModel.posts;
    PostModel post = profileModel.posts[index];
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              LimitedBox(
                  child: Row(
                children: [
                  user.profileImage == null
                      ? DummyProfile()
                      : CircleAvatar(
                          radius: 20.sm,
                          backgroundImage: NetworkImage(user.profileImage!),
                        ),
                  Gap(W: 10.sm),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          log("${ModalRoute.of(context)!.settings.name})");
                        },
                        child: Text(
                          user.name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Text(
                        timeago.format(post.createdAt),
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
              UserPostDropDownWidget(
                postId: post.postId,
                currentDiscr: post.discription,
              )
            ],
          ),
          post.post == null
              ? SizedBox()
              : post.type == PostType.video
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 250.sm,
                          width: double.infinity,
                          color: darkBg,
                          child: Opacity(
                            opacity: 0.6,
                            child: FadeInImage(
                                fadeInDuration: Duration(milliseconds: 100),
                                fit: BoxFit.cover,
                                image: NetworkImage(post.videoThumbnail!),
                                placeholder: AssetImage(dummyProfilePicture)),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                '/onlinevideoplayer',
                                arguments:
                                    ScreenArgs(args: {'path': post.post}));
                          },
                          child: CircleAvatar(
                            radius: 25.sm,
                            backgroundColor: darkBg.withOpacity(0.5),
                            child: Icon(
                              Icons.play_arrow_rounded,
                              color: smoothWhite,
                              size: 25.sm,
                            ),
                          ),
                        )
                      ],
                    )
                  : Column(
                      children: [
                        Gap(H: 10.sm),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5.sm),
                          child: Container(
                            child: Center(
                              child: FadeInImage(
                                  fadeInDuration: Duration(milliseconds: 100),
                                  fit: BoxFit.cover,
                                  image: NetworkImage(post.post!),
                                  placeholder: AssetImage(dummyProfilePicture)),
                            ),
                          ),
                        ),
                      ],
                    ),
          // Gap(H: 5.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // post.tag == null
              //     ? SizedBox()
              //     : Column(
              //         children: [
              //           Gap(H: 10.sm),
              //           Row(
              //             children: [
              //               Text(
              //                 post.tag!,
              //                 // style: Theme.of(context).textTheme.bodyMedium,
              //                 style: TextStyle(
              //                   color: primary,
              //                   fontSize: 14.sm,
              //                   fontWeight: FontWeight.bold,
              //                 ),
              //               ),
              //               Spacer(),
              //             ],
              //           ),
              //         ],
              //       ),
              BlocBuilder<PostCrudBloc, PostCrudState>(
                builder: (context, state) {
                  if (state is EditPostDiscSuccess) {
                    posts.map((e) {
                      if (e.postId == state.postId) {
                        e.discription = state.newDisc;
                      }
                    }).toList();
                  }
                  return Column(
                    children: [
                      post.discription == null
                          ? SizedBox()
                          : Column(
                              children: [
                                Gap(H: 10.sm),
                                ReadMoreText(
                                  post.discription!,
                                  trimMode: TrimMode.Line,
                                  trimLines: 2,
                                  trimCollapsedText: 'Read More',
                                  trimExpandedText: 'Read Less',
                                  lessStyle: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          fontSize: 13.sm,
                                          color: primary.withOpacity(0.7),
                                          fontWeight: FontWeight.w500),
                                  moreStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontSize: 13.sm,
                                          color: primary.withOpacity(0.7),
                                          fontWeight: FontWeight.w500),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                    ],
                  );
                },
              ),
              Gap(H: 10.sm),
              Column(
                children: [
                  Row(
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
                              " ${post.comments.length} Comments",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Gap(H: 10.sm),
                  Row(
                    children: [
                      Expanded(
                        child:
                            // listener: (context, state) {},

                            Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.1.sm, color: darkBlue),
                              borderRadius: BorderRadius.circular(15.sm)),
                          child: IconButton(
                            constraints: BoxConstraints(
                                maxHeight: 36.sm, maxWidth: 36.sm),
                            icon: IconTheme(
                                data: Theme.of(context).iconTheme,
                                child: Icon(
                                  Icons.bolt_outlined,
                                  size: 22.sm,
                                  // color: primaryBlue.withOpacity(0.7),
                                )),
                            onPressed: () {},
                          ),
                        ),
                      ),
                      Gap(W: 10.sm),
                      PostActionButton(icon: Icons.comment),
                      Gap(W: 10.sm),
                      PostActionButton(icon: Icons.download),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UserPostDropDownWidget extends StatelessWidget {
  const UserPostDropDownWidget(
      {Key? key, required this.postId, required this.currentDiscr})
      : super(key: key);

  final String postId;
  final String? currentDiscr;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCrudBloc, PostCrudState>(
      listener: (context, state) {},
      builder: (context, state) {
        return DropdownButtonHideUnderline(
          child: DropdownButton(
            dropdownColor: Theme.of(context).bottomSheetTheme.backgroundColor,
            focusColor: primaryBlue,
            items: _dropItems
                .map((item) =>
                    _buildMenuItem(item, context, postId, currentDiscr))
                .toList(),
            onChanged: (value) {},
            icon: IconTheme(
              data: Theme.of(context).iconTheme.copyWith(size: 18),
              child: Icon(
                Icons.more_vert,
              ),
            ),
          ),
        );
      },
    );
  }
}

final _dropItems = [
  "Edit",
  "Delete",
];

// final dummyLongText =
//     "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec egestas posuere pretium. Nam volutpat dictum lorem in volutpat. Aenean convallis ipsum sed sagittis bibendum. Sed ut bibendum velit, a consectetur est. Suspendisse feugiat nulla in felis mollis dignissim et id lectus. Nullam nec massa orci. Curabitur odio tellus, tempus ut imperdiet in, ullamcorper nec nibh. Praesent nisi nunc";

DropdownMenuItem<String> _buildMenuItem(
    String item, BuildContext context, String postId, String? currentDiscr) {
  return DropdownMenuItem(
    onTap: () {
      if (item == "Edit") {
        showEditPostDiscriptionSheet(
            context: context, postId: postId, currentDisr: currentDiscr);
      }
      if (item == "Delete") {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<PostCrudBloc>().add(DeletePost(id: postId));
        });
      }
    },
    value: item,
    child: BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, profileState) {
        ProfileModel model = (profileState as ProfileSuccess).profileModel;
        return BlocConsumer<PostCrudBloc, PostCrudState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Text(
              item,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14.sm,
                    fontWeight: FontWeight.normal,
                  ),
            );
          },
        );
      },
    ),
  );
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

  // onTap: () {
  //               if (item == "Edit") {}
  //               if (item == "Delete") {
  //                 WidgetsBinding.instance.addPostFrameCallback((_) {
  //                   context
  //                       .read<PostCrudBloc>()
  //                       .add(DeletePost(id: model.posts[index].postId));
  //                 });
  //               }
  //             },