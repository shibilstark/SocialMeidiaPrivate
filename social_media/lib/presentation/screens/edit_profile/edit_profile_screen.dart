import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/core/constants/constants.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';
import 'package:social_media/presentation/widgets/gap.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key, required this.userModel})
      : super(key: key);

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: EditProfileAppBar(),
        preferredSize: appBarHeight,
      ),
      body: SafeArea(
          child: EditProfileBody(
        userModel: userModel,
      )),
    );
  }
}

class EditProfileAppBar extends StatelessWidget {
  const EditProfileAppBar({Key? key}) : super(key: key);

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
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        title: Text(
          "Edit Profile",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: pureWhite),
        ),
      ),
    );
  }
}

class EditProfileBody extends StatelessWidget {
  const EditProfileBody({Key? key, required this.userModel}) : super(key: key);

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.sm, horizontal: 5.sm),
      child: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.sm),
                topRight: Radius.circular(40.sm)),
            child: userModel.coverImage != "" || userModel.coverImage.isNotEmpty
                ? Container(
                    constraints: BoxConstraints(maxHeight: 150.sm),
                    color: primaryBlue,
                    width: double.infinity,
                  )
                : userModel.coverImage == "" || userModel.coverImage.isEmpty
                    ? Container(
                        width: double.infinity,
                        constraints: BoxConstraints(maxHeight: 150.sm),
                        child: Image.network(
                          userModel.coverImage,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        constraints: BoxConstraints(maxHeight: 150.sm),
                        child: Image.file(
                          File(userModel.coverImage),
                          fit: BoxFit.cover,
                        ),
                      ),
          ),
          Gap(H: 20.sm),
        ],
      )),
    );
  }
}
