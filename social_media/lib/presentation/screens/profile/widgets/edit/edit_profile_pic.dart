// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:social_media/application/user/current_user/current_user_bloc.dart';
// import 'package:social_media/application/user/edit_profile/change_profile/profile_image_bloc.dart';
// import 'package:social_media/core/colors/colors.dart';
// import 'package:social_media/presentation/routes/app_router.dart';
// import 'package:social_media/presentation/screens/profile/widgets/profile_part/user_profile_part.dart';
// import 'package:social_media/presentation/widgets/gap.dart';

// showProfileActionSheet({required BuildContext context}) {
//   showModalBottomSheet(
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(40.sm),
//               topRight: Radius.circular(40.sm))),
//       context: context,
//       builder: (ctx) => const ProfileActionSheet());
// }

// class ProfileActionSheet extends StatelessWidget {
//   const ProfileActionSheet({Key? key}) : super(key: key);

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
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   if (model.profileImage == "" || model.profileImage.isEmpty) {
//                     Navigator.of(context).popAndPushNamed("/seeimageoffline",
//                         arguments:
//                             ScreenArgs(args: {'path': dummyProfilePicture}));
//                   } else {
//                     Navigator.of(context).popAndPushNamed("/seeimageonline",
//                         arguments:
//                             ScreenArgs(args: {'path': model.profileImage}));
//                   }
//                 },
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     CircleAvatar(
//                       radius: 25.sm,
//                       backgroundColor: primaryBlue,
//                       child: Icon(
//                         Icons.visibility,
//                         color: pureWhite,
//                         size: 25.sm,
//                       ),
//                     ),
//                     Gap(
//                       H: 5.sm,
//                     ),
//                     Text("See Profile")
//                   ],
//                 ),
//               ),
//               //
//               //
//               //
//               //
//               //
//               //
//               //
//               //
//               //
//               //
//               //
//               GestureDetector(
//                 onTap: () {
//                   Navigator.of(context).pop();
//                   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//                     context
//                         .read<RemoveProfileImageBloc>()
//                         .add(RemoveProfileImage());
//                   });
//                 },
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     CircleAvatar(
//                       radius: 25.sm,
//                       backgroundColor: primaryBlue,
//                       backgroundImage: AssetImage(dummyProfilePicture),
//                     ),
//                     Gap(
//                       H: 5.sm,
//                     ),
//                     Text("Remove Profile")
//                   ],
//                 ),
//               ),
//               //
//               //
//               //
//               //
//               //
//               //
//               //
//               //
//               //
//               //
//               //
//               GestureDetector(
//                 onTap: () {
//                   Navigator.of(context).pop();
//                   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//                     context
//                         .read<RemoveProfileImageBloc>()
//                         .add(ChangeProfileImage());
//                   });
//                 },
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     CircleAvatar(
//                       radius: 25.sm,
//                       backgroundColor: primaryBlue,
//                       child: Icon(
//                         Icons.add_photo_alternate,
//                         color: pureWhite,
//                         size: 25.sm,
//                       ),
//                     ),
//                     Gap(
//                       H: 5.sm,
//                     ),
//                     Text("Change Profile")
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
