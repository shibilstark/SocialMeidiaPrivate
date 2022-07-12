// import 'package:flutter/cupertino.dart';

// import 'package:cool_alert/cool_alert.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:social_media/application/user/current_user/current_user_bloc.dart';
// import 'package:social_media/application/user/edit_profile/change_cover/remove_cover_image_bloc.dart';
// import 'package:social_media/application/user/edit_profile/change_profile/profile_image_bloc.dart';

// import 'package:social_media/core/colors/colors.dart';
// import 'package:social_media/domain/failures/main_failures.dart';
// import 'package:social_media/domain/models/post_model/post_model.dart';
// import 'package:social_media/presentation/routes/app_router.dart';
// import 'package:social_media/presentation/screens/profile/widgets/profile_part/user_profile_part.dart';
// import 'package:social_media/presentation/widgets/gap.dart';
// import 'package:social_media/utility/util.dart';

// showCoverActionSheet({required BuildContext context}) {
//   showModalBottomSheet(
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(40.sm),
//               topRight: Radius.circular(40.sm))),
//       context: context,
//       builder: (ctx) => const CoverImageActionSheet());
// }

// class CoverImageActionSheet extends StatelessWidget {
//   const CoverImageActionSheet({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<CurrentUserBloc, CurrentUserState>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         final userState = state as FetchCurrentUserSuccess;
//         final model = userState.data.user;
//         return SizedBox(
//           height: 120.sm,
//           // constraints: BoxConstraints(maxHeight: 150.sm),
//           child: model.coverImage == "" || model.coverImage.isEmpty
//               ? GestureDetector(
//                   onTap: () {
//                     Navigator.of(context).pop();
//                     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//                       context
//                           .read<RemoveCoverImageBloc>()
//                           .add(ChangeCoverImage());
//                     });
//                   },
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       CircleAvatar(
//                         radius: 25.sm,
//                         backgroundColor: primaryBlue,
//                         child: Icon(
//                           Icons.add_photo_alternate,
//                           color: pureWhite,
//                           size: 25.sm,
//                         ),
//                       ),
//                       Gap(
//                         H: 5.sm,
//                       ),
//                       Text("Change cover")
//                     ],
//                   ),
//                 )
//               : Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         // if (model.coverImage == "" || model.coverImage.isEmpty) {
//                         // } else {
//                         Navigator.of(context).popAndPushNamed("/seeimageonline",
//                             arguments:
//                                 ScreenArgs(args: {'path': model.coverImage}));
//                         // }
//                       },
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           CircleAvatar(
//                             radius: 25.sm,
//                             backgroundColor: primaryBlue,
//                             child: Icon(
//                               Icons.visibility,
//                               color: pureWhite,
//                               size: 25.sm,
//                             ),
//                           ),
//                           Gap(
//                             H: 5.sm,
//                           ),
//                           Text("See cover")
//                         ],
//                       ),
//                     ),
//                     //
//                     //
//                     //
//                     //
//                     //
//                     //
//                     //
//                     //
//                     //
//                     //
//                     //
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).pop();
//                         WidgetsBinding.instance
//                             .addPostFrameCallback((timeStamp) {
//                           context
//                               .read<RemoveCoverImageBloc>()
//                               .add(RemoveCoverImage());
//                         });
//                       },
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           CircleAvatar(
//                             radius: 25.sm,
//                             backgroundColor: primaryBlue,
//                             backgroundImage: AssetImage(dummyProfilePicture),
//                           ),
//                           Gap(
//                             H: 5.sm,
//                           ),
//                           Text("Remove cover")
//                         ],
//                       ),
//                     ),
//                     //
//                     //
//                     //
//                     //
//                     //
//                     //
//                     //
//                     //
//                     //
//                     //
//                     //
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).pop();
//                         WidgetsBinding.instance
//                             .addPostFrameCallback((timeStamp) {
//                           context
//                               .read<RemoveCoverImageBloc>()
//                               .add(ChangeCoverImage());
//                         });
//                       },
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           CircleAvatar(
//                             radius: 25.sm,
//                             backgroundColor: primaryBlue,
//                             child: Icon(
//                               Icons.add_photo_alternate,
//                               color: pureWhite,
//                               size: 25.sm,
//                             ),
//                           ),
//                           Gap(
//                             H: 5.sm,
//                           ),
//                           Text("Change cover")
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//         );
//       },
//     );
//   }
// }
