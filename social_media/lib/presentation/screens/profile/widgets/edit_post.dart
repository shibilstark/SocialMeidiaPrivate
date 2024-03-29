import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media/application/edit_profile_pics/edit_profile_bloc.dart';
import 'package:social_media/application/post_crud/post_crud_bloc.dart';
import 'package:social_media/application/profile/profile_bloc.dart';

import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/core/constants/constants.dart';
import 'package:social_media/core/controllers/text_controllers.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/domain/models/post_model/post_model.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';
import 'package:social_media/presentation/screens/profile/edit/dialog.dart';
import 'package:social_media/presentation/screens/profile/widgets/profile_info.dart';
import 'package:social_media/presentation/screens/profile/widgets/user_post.dart';
import 'package:social_media/presentation/shimmers/inner_profile_shimmer.dart';
import 'package:social_media/presentation/widgets/gap.dart';

showEditPostDiscriptionSheet(
    {required BuildContext context,
    required String postId,
    required String? currentDisr}) {
  showBottomSheet(
      context: context,
      builder: (ctx) =>
          EditPostDiscription(postId: postId, currentDisr: currentDisr),
      enableDrag: true);
}

class EditPostDiscription extends StatelessWidget {
  final String postId;
  final String? currentDisr;

  EditPostDiscription(
      {super.key, required this.postId, required this.currentDisr});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var underlineInputBorder = UnderlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).splashColor));

    if (currentDisr != null) {
      TextFielsPostEditControllers.postDiscription.text = currentDisr!;
    }
    // else {
    //   TextFielsPostEditControllers.postDiscription.text = "";
    // }

    return Container(
      height: 180..sm,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.sm.sm, horizontal: 20.sm),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Edit Post Discription",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 17.sm, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(thickness: 0.1),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: TextFielsPostEditControllers.postDiscription,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 16.sm),
                decoration: InputDecoration(
                  hintText: "Discription",
                  hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 13.sm,
                      color: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .color!
                          .withOpacity(0.5)),
                  enabledBorder: underlineInputBorder,
                  focusedBorder: underlineInputBorder,
                  disabledBorder: underlineInputBorder,
                  errorBorder: underlineInputBorder,
                  border: underlineInputBorder,
                ),
              ),
            ),
            Gap(H: 10.sm),
            SizedBox(
                height: 35.sm,
                child: MaterialButton(
                  onPressed: () {
                    if (TextFielsPostEditControllers.postDiscription.text
                                .trim() ==
                            currentDisr ||
                        (TextFielsPostEditControllers.postDiscription.text
                                    .trim() ==
                                "" &&
                            currentDisr == null)) {
                      // WidgetsBinding.instance.addPostFrameCallback((_) {
                      //   context.read<PostCrudBloc>().add(EditPostDisc(
                      //         postId: postId,
                      //         newDisc: null,
                      //       ));
                      // });

                    }
                    //  else if (TextFielsPostEditControllers.postDiscription.text
                    //     .trim()
                    //     .isEmpty) {
                    //   WidgetsBinding.instance.addPostFrameCallback((_) {
                    //     context.read<PostCrudBloc>().add(EditPostDisc(
                    //           postId: postId,
                    //           newDisc: null,
                    //         ));
                    //   });
                    // }
                    else {
                      final newDiscription = TextFielsPostEditControllers
                                  .postDiscription.text
                                  .trim() ==
                              ""
                          ? null
                          : TextFielsPostEditControllers.postDiscription.text
                              .trim();
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        context.read<PostCrudBloc>().add(EditPostDisc(
                              postId: postId,
                              newDisc: newDiscription,
                            ));
                      });
                    }
                    Navigator.of(context).pop();
                    TextFielsPostEditControllers.clearControllers();
                  },
                  color: primaryBlue,
                  child: Text(
                    "Update",
                    style: TextStyle(color: pureWhite, fontSize: 15.sm),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
