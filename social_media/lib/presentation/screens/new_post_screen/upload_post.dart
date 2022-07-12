// import 'dart:io';
// import 'package:cool_alert/cool_alert.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:social_media/core/colors/colors.dart';
// import 'package:social_media/core/constants/constants.dart';
// import 'package:social_media/domain/global/global_variables.dart';
// import 'package:social_media/domain/models/post_model/post_model.dart';
// import 'package:social_media/presentation/routes/app_router.dart';
// import 'package:social_media/presentation/widgets/custom_text_field.dart';
// import 'package:social_media/presentation/widgets/gap.dart';
// import 'package:social_media/utility/util.dart';
// import 'package:uuid/uuid.dart';

// import '../../../core/controllers/text_controllers.dart';
// import '../../widgets/common_text_field.dart';

// class UploadPostScreen extends StatelessWidget {
//   const UploadPostScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       appBar: PreferredSize(
//         child: NewPostAppBar(),
//         preferredSize: appBarHeight,
//       ),
//       body: SafeArea(child: UploadPostBody()),
//       // bottomSheet: UploadPostBottomSheetWidget(),
//     );
//   }
// }

// class UploadPostBody extends StatelessWidget {
//   const UploadPostBody({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//     return SingleChildScrollView(
//       child: Center(
//         child: Padding(
//           padding: EdgeInsets.symmetric(vertical: 5.sm, horizontal: 10.sm),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Gap(H: 20.sm),
//                GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).pushNamed("/seeimageoffline",
//                             arguments:
//                                 ScreenArgs(args: {'path': state.post!.file}));
//                       },
//                       child: Container(
//                         color:
//                             Theme.of(context).bottomSheetTheme.backgroundColor,
//                         constraints: BoxConstraints(maxHeight: 400.sm),
//                         child: Image.file(
//                           File(state.post!.file),
//                         ),
//                       ),
//                     )
//                   : GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).pushNamed("/offlinevideoplayer",
//                             arguments:
//                                 ScreenArgs(args: {'path': state.post!.file}));
//                       },
//                       child: Stack(
//                         alignment: Alignment.center,
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(10.sm),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: darkBg,
//                               ),

//                               // constraints: BoxConstraints(
//                               //     maxHeight: 200.sm,
//                               //     minHeight: 150.sm,
//                               //     minWidth: 300),
//                               width: width,
//                               height: width * 0.7,

//                               child: Opacity(
//                                 opacity: 0.8,
//                                 child: Image.file(
//                                   File(state.post!.thumbnail!),
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           CircleAvatar(
//                             backgroundColor: darkBg.withOpacity(0.5),
//                             radius: 30.sm,
//                             child: Icon(
//                               Icons.play_arrow,
//                               size: 30.sm,
//                               color: pureWhite,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//               Gap(H: 40.sm),
//               Center(
//                 child: Container(
//                   constraints: BoxConstraints(maxWidth: 400.sm),
//                   child: Column(
//                     children: [
//                       CommonTextField(
//                           controller: PostTextFieldControllers.discription,
//                           hint: "discription",
//                           length: 250),
//                       CommonTextField(
//                           controller: PostTextFieldControllers.tag,
//                           hint: "tag",
//                           length: 30),
//                       Gap(H: 30.sm),
//                       SizedBox(
//                         height: 40.sm,
//                         width: 200.sm,
//                         child: ElevatedButton(
//                             onPressed: () {
//                               final model = PostModel(
//                                   postId: Uuid().v4(),
//                                   userId: Global.USER_DATA.id,
//                                   post: state.post!.file,
//                                   createdAt: DateTime.now(),
//                                   laseEdit: DateTime.now(),
//                                   comments: [],
//                                   lights: [],
//                                   type: state.post!.type,
//                                   videoThumbnail: state.post!.thumbnail,
//                                   discription: PostTextFieldControllers
//                                       .discription.text
//                                       .trim(),
//                                   tag: PostTextFieldControllers.tag.text.trim(),
//                                   reports: []);

//                               WidgetsBinding.instance
//                                   .addPostFrameCallback((_) {});
//                             },
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   "Upload",
//                                   style: TextStyle(
//                                       color: smoothWhite,
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 16.sm),
//                                 ),
//                                 Gap(
//                                   W: 5.sm,
//                                 ),
//                                 Icon(
//                                   Icons.upload_sharp,
//                                   size: 20.sm,
//                                 )
//                               ],
//                             )),
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // class UploadPostBottomSheetWidget extends StatelessWidget {
// //   const UploadPostBottomSheetWidget({
// //     Key? key,
// //   }) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return BottomSheet(
// //         enableDrag: false,
// //         onClosing: () {},
// //         builder: (ctx) {
// //           return ClipRRect(
// //             borderRadius: BorderRadius.only(
// //                 topLeft: Radius.circular(40.sm),
// //                 topRight: Radius.circular(40.sm)),
// //             child: GestureDetector(
// //               onTap: () {
// //                 Navigator.of(context).pop();
// //               },
// //               child: Container(
// //                 height: 40.sm,
// //                 child: Row(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   crossAxisAlignment: CrossAxisAlignment.center,
// //                   children: [
// //                     Icon(
// //                       Icons.upload,
// //                       color: pureWhite,
// //                     ),
// //                     Gap(
// //                       W: 10.sm,
// //                     ),
// //                     Text(
// //                       "Send Post",
// //                       style: TextStyle(
// //                           color: pureWhite,
// //                           fontWeight: FontWeight.bold,
// //                           fontSize: 19.sm),
// //                     )
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           );
// //         });
// //   }
// // }

// class NewPostAppBar extends StatelessWidget {
//   const NewPostAppBar({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(40.sm),
//           bottomRight: Radius.circular(40.sm)),
//       child: AppBar(
//         // backgroundColor: Theme.of(context).appBarTheme.color,
//         elevation: 2,
//         // titleSpacing: 45.sm,
//         // centerTitle: true,

//         leading: Padding(
//           padding: EdgeInsets.only(left: 30.sm),
//           child: Builder(builder: (context) {
//             return Center(
//               child: IconButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   icon: IconTheme(
//                     data: Theme.of(context).primaryIconTheme,
//                     child: Icon(
//                       Icons.arrow_back,
//                       size: 25.sm,
//                     ),
//                   )),
//             );
//           }),
//         ),

//         automaticallyImplyLeading: false,
//         title: Text("Add New Post",
//             style: Theme.of(context)
//                 .textTheme
//                 .titleLarge!
//                 .copyWith(fontSize: 23, fontWeight: FontWeight.w500)),
//       ),
//     );
//   }
// }
