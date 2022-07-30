import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/core/constants/constants.dart';
import 'package:social_media/presentation/screens/posts_screen/global_post.dart';
import '../../../application/home/home_feed_bloc.dart';

final _globalBucket = PageStorageBucket();
ScrollController globalPostslistScrollController = ScrollController();

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageStorage(
      bucket: _globalBucket,
      child: Padding(
        padding: constPadding,
        child:
            BlocBuilder<HomeFeedBloc, HomeFeedState>(builder: (context, state) {
          if (state is HomeFeedLoding) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeFeedError) {
            return Center(
              child: Text("Error"),
            );
          } else {
            final homeFeed = (state as HomeFeedSuccess).homeFeed;

            return RefreshIndicator(
                onRefresh: () async =>
                    context.read<HomeFeedBloc>().add(GetHomeFeed()),
                child: ListView(
                  controller: globalPostslistScrollController,
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  children: List.generate(homeFeed.length, (index) {
                    final currenGlobalPost = homeFeed[index];
                    return Column(
                      children: [
                        GlobalPost(
                          postId: Key(currenGlobalPost.post.postId),
                          index: index,
                          user: currenGlobalPost.user,
                          post: currenGlobalPost.post,
                        ),
                        index == state.homeFeed.length - 1
                            ? HomeFeedCompleteRefreshButtonWidget()
                            : Divider(thickness: 0.4.sm)
                      ],
                    );
                  }),

                  // itemBuilder: (context, index) {
                  //   final currenGlobalPost = homeFeed[index];

                  //   return GlobalPost(
                  //     postId: Key(currenGlobalPost.post.postId),
                  //     index: index,
                  //     user: currenGlobalPost.user,
                  //     post: currenGlobalPost.post,
                  //   );
                  // },
                  // separatorBuilder: (context, index) => Divider(
                  //       thickness: 0.1,
                  //     ),
                  // itemCount: homeFeed.length),
                ));
          }
        }),
      ),
    );
  }
}

class HomeFeedCompleteRefreshButtonWidget extends StatelessWidget {
  const HomeFeedCompleteRefreshButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(thickness: 0.4.sm),
        TextButton.icon(
            onPressed: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.read<HomeFeedBloc>().add(GetHomeFeed());
              });
              globalPostslistScrollController.jumpTo(0);
            },
            icon: Icon(
              Icons.refresh,
              color: Theme.of(context).textTheme.bodyMedium!.color,
            ),
            label: Text(
              "Refresh",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 14.sm),
            ))
      ],
    );
  }
}
