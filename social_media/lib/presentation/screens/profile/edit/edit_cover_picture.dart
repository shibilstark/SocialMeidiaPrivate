// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// showEditCoverPictureBottomSheet({required BuildContext context}) {
//   showModalBottomSheet(
//       context: context, builder: (context) => EditCoverBottomSheet());
// }

// class EditCoverBottomSheet extends StatelessWidget {
//   const EditCoverBottomSheet({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: double.infinity,
//       child: Padding(
//         padding: EdgeInsets.all(10.sm),
//         child: Column(
//           children: [
//             Container()
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/application/edit_profile_pics/edit_profile_bloc.dart';
import 'package:social_media/application/profile/profile_bloc.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/presentation/util/functions/pickers.dart';

showEditCoverBottomSheet(BuildContext context) {
  showModalBottomSheet(
      context: context, builder: (context) => EditCoverBottomSheetS());
}

class EditCoverBottomSheetS extends StatelessWidget {
  const EditCoverBottomSheetS({super.key});

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
                // Remove Cover Picture
                Navigator.of(context).pop();
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  context.read<EditProfileBloc>().add(ChangeCoverPic(null));
                });
              },
              child: Container(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Remove Cover Pic",
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
                // `Change` Cover Picture

                final newPic = await Utility.pickImage();
                if (newPic == null) {
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).pop();
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    context.read<EditProfileBloc>().add(ChangeCoverPic(newPic));
                  });
                }
              },
              child: Container(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Change Cover Pic",
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


//  Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Container(
//               height: 50.sm,
//               width: 50.sm,
//               decoration: BoxDecoration(
//                   color: primaryBlue,
//                   border: Border.all(
//                     width: 0.5,
//                     color: secondaryBlue,
//                   ),
//                   borderRadius: BorderRadius.circular(10.sm)),
//             ),
//             Container(
//               height: 50.sm,
//               width: 50.sm,
//               decoration: BoxDecoration(
//                   color: primaryBlue,
//                   border: Border.all(
//                     width: 0.5,
//                     color: secondaryBlue,
//                   ),
//                   borderRadius: BorderRadius.circular(10.sm)),
//             ),
//           ],
//         ),