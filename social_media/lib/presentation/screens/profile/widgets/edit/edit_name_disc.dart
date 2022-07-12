// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:social_media/application/user/current_user/current_user_bloc.dart';
// import 'package:social_media/application/user/edit_profile/change_cover/remove_cover_image_bloc.dart';
// import 'package:social_media/application/user/edit_profile/edit_name_and_disc/edit_details_bloc.dart';
// import 'package:social_media/core/colors/colors.dart';
// import 'package:social_media/core/controllers/text_controllers.dart';
// import 'package:social_media/presentation/routes/app_router.dart';
// import 'package:social_media/presentation/screens/profile/widgets/profile_part/user_profile_part.dart';
// import 'package:social_media/presentation/widgets/gap.dart';

// final _formKey = GlobalKey<FormState>();

// showEditNameAndDiscSheet(
//     {required BuildContext context,
//     required String name,
//     required String disc}) {
//   showBottomSheet(
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(40.sm),
//               topRight: Radius.circular(40.sm))),
//       context: context,
//       builder: (ctx) => EditNameAndDiscActionSheet(
//             disc: disc,
//             name: name,
//           ));
// }

// class EditNameAndDiscActionSheet extends StatelessWidget {
//   const EditNameAndDiscActionSheet(
//       {Key? key, required this.disc, required this.name})
//       : super(key: key);

//   final String name;
//   final String disc;

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<EditDetailsBloc, EditDetailsState>(
//       listener: (context, state) {
//         if (state is EditDetailsSuccess) {
//           Navigator.of(context).pop();
//           context.read<CurrentUserBloc>().add(FetchCurrentuser());
//           Fluttertoast.showToast(msg: "Updated Successfully");
//           log("success");
//         }
//         if (state is EditDetailsFailed) {
//           Fluttertoast.showToast(msg: "update Failed Try Again later");
//           Navigator.of(context).pop();
//           log("error");
//         }
//       },
//       builder: (context, state) {
//         EditProfileTextEditingControllers.name.text = name;
//         EditProfileTextEditingControllers.discription.text = disc;
//         return SizedBox(
//           height: 250.sm,
//           child: Container(
//             padding: EdgeInsets.all(20.sm),
//             child: SingleChildScrollView(
//                 child: Column(
//               children: [
//                 ProfileNameAndDiscFields(),
//                 Gap(H: 30.sm),
//                 Container(
//                   height: 40.sm,
//                   decoration: BoxDecoration(
//                       border: Border.all(color: softGrey, width: 0.2),
//                       borderRadius: BorderRadius.circular(4.sm)),
//                   child: ElevatedButton(
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           if (EditProfileTextEditingControllers.name.text
//                                       .trim() ==
//                                   name &&
//                               EditProfileTextEditingControllers.discription.text
//                                       .trim() ==
//                                   disc) {
//                             Navigator.of(context).pop();
//                           } else {
//                             WidgetsBinding.instance.addPostFrameCallback((_) {
//                               context.read<EditDetailsBloc>().add(
//                                   EditNameAndDisc(
//                                       disc: EditProfileTextEditingControllers
//                                           .discription.text
//                                           .trim(),
//                                       name: EditProfileTextEditingControllers
//                                           .name.text
//                                           .trim()));
//                             });
//                           }
//                         }
//                       },
//                       child: state is EditDetailsLoading
//                           ? SizedBox(
//                               height: 30.sm,
//                               width: 30.sm,
//                               child: Center(
//                                   child: CircularProgressIndicator(
//                                 color: pureWhite,
//                               )),
//                             )
//                           : Text(
//                               "Update",
//                               style: TextStyle(
//                                   color: pureWhite,
//                                   fontSize: 14.sm,
//                                   fontWeight: FontWeight.w500),
//                             )),
//                 )
//               ],
//             )),
//           ),
//         );
//       },
//     );
//   }
// }

// class ProfileNameAndDiscFields extends StatelessWidget {
//   const ProfileNameAndDiscFields({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             TextFormField(
//               validator: (value) {
//                 if (value!.trim().length < 3) {
//                   return "Atleast 3 charecters ";
//                 }
//               },
//               controller: EditProfileTextEditingControllers.name,
//               cursorColor: primaryBlue,
//               style: Theme.of(context)
//                   .textTheme
//                   .bodyMedium!
//                   .copyWith(fontSize: 16.sm),
//               decoration: InputDecoration(
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10.sm),
//                 hintText: "Name",
//                 hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                     color: Theme.of(context)
//                         .textTheme
//                         .bodyMedium!
//                         .color!
//                         .withOpacity(0.5)),
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(
//                       color: Theme.of(context).textTheme.bodyMedium!.color!,
//                       width: 1.sm),
//                   borderRadius: BorderRadius.circular(5.sm),
//                 ),
//                 border: UnderlineInputBorder(
//                   borderSide: BorderSide(
//                       color: Theme.of(context).textTheme.bodyMedium!.color!,
//                       width: 1.sm),
//                   borderRadius: BorderRadius.circular(5.sm),
//                 ),
//                 enabledBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Theme.of(context).textTheme.bodyMedium!.color!,
//                     width: 1.sm,
//                   ),
//                   borderRadius: BorderRadius.circular(5.sm),
//                 ),
//               ),
//             ),
//             TextFormField(
//               validator: (value) {
//                 if (value!.trim().length < 3) {
//                   return "Atleast 3 charecters ";
//                 }
//               },
//               controller: EditProfileTextEditingControllers.discription,
//               cursorColor: primaryBlue,
//               style: Theme.of(context)
//                   .textTheme
//                   .bodyMedium!
//                   .copyWith(fontSize: 16.sm),
//               decoration: InputDecoration(
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10.sm),
//                 hintText: "About you",
//                 hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                     color: Theme.of(context)
//                         .textTheme
//                         .bodyMedium!
//                         .color!
//                         .withOpacity(0.5)),
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(
//                       color: Theme.of(context).textTheme.bodyMedium!.color!,
//                       width: 1.sm),
//                   borderRadius: BorderRadius.circular(5.sm),
//                 ),
//                 border: UnderlineInputBorder(
//                   borderSide: BorderSide(
//                       color: Theme.of(context).textTheme.bodyMedium!.color!,
//                       width: 1.sm),
//                   borderRadius: BorderRadius.circular(5.sm),
//                 ),
//                 enabledBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Theme.of(context).textTheme.bodyMedium!.color!,
//                     width: 1.sm,
//                   ),
//                   borderRadius: BorderRadius.circular(5.sm),
//                 ),
//               ),
//             ),
//           ],
//         ));
//   }
// }
