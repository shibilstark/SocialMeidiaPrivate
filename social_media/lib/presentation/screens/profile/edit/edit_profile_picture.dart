import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/application/edit_profile_pics/edit_profile_bloc.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/presentation/util/functions/pickers.dart';

showEditProfileBottomSheet(BuildContext context) {
  showModalBottomSheet(
      context: context, builder: (context) => EditProfileBottomSheet());
}

class EditProfileBottomSheet extends StatelessWidget {
  const EditProfileBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.sm,
      child: Padding(
        padding: EdgeInsets.all(10.sm),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                // Remove Profile Picture
                Navigator.of(context).pop();
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  context.read<EditProfileBloc>().add(ChangeProfilePic(null));
                });
              },
              child: Container(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Remove Profile Pic",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 18.sm),
                  ),
                ),
              ),
            ),
            Divider(),
            GestureDetector(
              onTap: () async {
                // `Change` Profile Picture
                final newPic = await Utility.pickImage();
                if (newPic == null) {
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).pop();
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    context
                        .read<EditProfileBloc>()
                        .add(ChangeProfilePic(newPic));
                  });
                }
              },
              child: Container(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Change Profile Pic",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 18.sm),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
