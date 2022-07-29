import 'dart:developer';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_media/application/edit_profile_pics/edit_profile_bloc.dart';
import 'package:social_media/application/profile/profile_bloc.dart';
import 'package:social_media/application/upload_post/upload_post_bloc.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/core/controllers/text_controllers.dart';
import 'package:social_media/domain/models/post_model/post_model.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';
import 'package:social_media/presentation/screens/new_post/new_post_screen.dart';
import 'package:social_media/presentation/widgets/gap.dart';

showUploadPostLoadingDialog(context) {
  showDialog(context: context, builder: (context) => UploadPostLoadingDialog());
}

class UploadPostLoadingDialog extends StatelessWidget {
  const UploadPostLoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, profileState) {
        return BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            List<PostModel> posts =
                (state as ProfileSuccess).profileModel.posts;

            return BlocConsumer<UploadPostBloc, UploadPostState>(
              listener: (context, state) {
                if (state is UploadPostSuccess) {
                  bool alreadyFound = false;

                  for (PostModel post in posts) {
                    if (post.postId == state.postModel.postId) {
                      alreadyFound = true;
                      break;
                    }
                  }

                  if (!alreadyFound) {
                    posts.insert(0, state.postModel);
                  }

                  // context.read<ProfileBloc>().add(GetCurrentUser());
                  // (profileState as ProfileSuccess)
                  //     .profileModel
                  //     .posts
                  //     .add(state.postModel);

                  post.value = null;
                  post.notifyListeners();

                  NewPostTextEditControllers.clearControllers();
                  Navigator.of(context).pushReplacementNamed('/home');
                }
                if (state is UploadPostError) {
                  post.value = null;
                  post.notifyListeners();

                  NewPostTextEditControllers.clearControllers();
                  Navigator.of(context).pushReplacementNamed('/home');
                  Fluttertoast.showToast(msg: state.failure.error);
                }
              },
              builder: (context, state) {
                return WillPopScope(
                  onWillPop: () async => false,
                  child: AlertDialog(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    content: Container(
                      height: 80.sm,
                      child: state is UploadingPost
                          ? StreamBuilder<TaskSnapshot>(
                              stream: state.uploadStream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final snap = snapshot.data;

                                  final progress = (snap!.bytesTransferred /
                                          snap.totalBytes) *
                                      100;

                                  final percentage =
                                      progress.toStringAsFixed(2);
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          height: 30.sm,
                                          width: 30.sm,
                                          child: CircularProgressIndicator(
                                              backgroundColor: secondaryBlue,
                                              value: double.parse(percentage),
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .color,
                                              strokeWidth: 2)),
                                      Gap(H: 10.sm),
                                      Text(
                                        "Uploading...  ${double.parse(percentage).round()}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!,
                                      )
                                    ],
                                  );
                                } else {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          height: 30.sm,
                                          width: 30.sm,
                                          child: CircularProgressIndicator(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .color,
                                              strokeWidth: 2)),
                                      Gap(H: 10.sm),
                                      Text(
                                        "Loading...",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!,
                                      )
                                    ],
                                  );
                                }
                              })
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 30.sm,
                                    width: 30.sm,
                                    child: CircularProgressIndicator(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .color,
                                        strokeWidth: 2)),
                                Gap(H: 10.sm),
                                Text(
                                  "Loading...",
                                  style:
                                      Theme.of(context).textTheme.bodyMedium!,
                                )
                              ],
                            ),
                    ),
                    contentPadding: EdgeInsets.all(10.sm),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
