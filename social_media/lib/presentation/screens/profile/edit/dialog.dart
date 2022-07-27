import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_media/application/edit_profile_pics/edit_profile_bloc.dart';
import 'package:social_media/application/post_crud/post_crud_bloc.dart';
import 'package:social_media/application/profile/profile_bloc.dart';

import 'package:social_media/domain/models/user_model/user_model.dart';
import 'package:social_media/presentation/widgets/gap.dart';

showProfileEditLodingDialog(context) {
  showDialog(context: context, builder: (context) => ProfileLoadingDialog());
}

class ProfileLoadingDialog extends StatelessWidget {
  const ProfileLoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        UserModel user = (state as ProfileSuccess).profileModel.user;

        return BlocConsumer<PostCrudBloc, PostCrudState>(
          listener: (context, state) {
            if (state is DeletePostSuccess) {
              Navigator.of(context).pop();
            }
            if (state is DeletePostError) {
              Navigator.of(context).pop();

              // Fluttertoast.showToast(msg: state.failures.error);
            }
            if (state is EditPostDiscError) {
              Navigator.of(context).pop();
            }
            if (state is EditPostDiscSuccess) {
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            return BlocConsumer<EditProfileBloc, EditProfileState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is ProfilePicChangeSuccess) {
                  Navigator.of(context).pop();
                }

                if (state is ProfilePicChangeError) {
                  Navigator.of(context).pop();
                  Fluttertoast.showToast(msg: state.failure.error);
                }
                if (state is CoverPicChangeSuccess) {
                  Navigator.of(context).pop();
                }
                if (state is CoverPicChangeError) {
                  Navigator.of(context).pop();
                  Fluttertoast.showToast(msg: state.failure.error);
                }
                if (state is NAmeAndDiscChangeSuccess) {
                  Navigator.of(context).pop();
                }
                if (state is NAmeAndDiscChangeError) {
                  Navigator.of(context).pop();
                  Fluttertoast.showToast(msg: state.failure.error);
                }

                return WillPopScope(
                  onWillPop: () async => false,
                  child: AlertDialog(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    content: Container(
                      height: 80.sm,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 20.sm,
                              width: 20.sm,
                              child: CircularProgressIndicator(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .color,
                                  strokeWidth: 1)),
                          Gap(H: 10.sm),
                          Text(
                            "Loading...",
                            style: Theme.of(context).textTheme.bodyMedium!,
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
