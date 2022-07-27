import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/application/upload_post/upload_post_bloc.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/core/constants/constants.dart';
import 'package:social_media/core/controllers/text_controllers.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/domain/models/local_models/post_type_model.dart';
import 'package:social_media/domain/models/post_model/post_model.dart';
import 'package:social_media/presentation/router/router.dart';
import 'package:social_media/presentation/screens/new_post/dialog.dart';
import 'package:social_media/presentation/util/functions/pickers.dart';
import 'package:social_media/presentation/widgets/common_appbar.dart';
import 'package:social_media/presentation/widgets/gap.dart';
import 'package:uuid/uuid.dart';

ValueNotifier<PostTypeModel?> post = ValueNotifier(null);

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
          child: CommonAppBar(title: "Add New Post"),
          preferredSize: appBarHeight),
      body: NewPostBody(),
    );
  }
}

class NewPostBody extends StatelessWidget {
  const NewPostBody({super.key});

  @override
  Widget build(BuildContext context) {
    var underlineInputBorder = UnderlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).splashColor));
    return Padding(
      padding: constPadding,
      child: BlocConsumer<UploadPostBloc, UploadPostState>(
        listener: (context, state) {
          if (state is UploadPostLoading) {
            showUploadPostLoadingDialog(context);
          }
        },
        builder: (context, state) {
          return Container(
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: NewPostTextEditControllers.discription,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 16.sm),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .color!
                                    .withOpacity(0.4)),
                            hintText: "Write Something here",
                            enabledBorder: underlineInputBorder,
                            focusedBorder: underlineInputBorder,
                            disabledBorder: underlineInputBorder,
                            errorBorder: underlineInputBorder,
                            border: underlineInputBorder,
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            showNewPostSheet(context);
                          },
                          icon: IconTheme(
                              data: Theme.of(context).iconTheme,
                              child: Icon(Icons.add_photo_alternate)))
                    ],
                  ),
                  Gap(H: 20.sm),
                  TextField(
                    controller: NewPostTextEditControllers.tag,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 16.sm),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                          color: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .color!
                              .withOpacity(0.4)),
                      hintText: "Add a tag",
                      enabledBorder: underlineInputBorder,
                      focusedBorder: underlineInputBorder,
                      disabledBorder: underlineInputBorder,
                      errorBorder: underlineInputBorder,
                      border: underlineInputBorder,
                    ),
                  ),
                  Gap(H: 40.sm),
                  ValueListenableBuilder(
                      valueListenable: post,
                      builder: (context, PostTypeModel? val, _) {
                        if (val == null) {
                          return SizedBox();
                        } else {
                          if (val.type == PostType.image) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      '/seeimageoffline',
                                      arguments:
                                          ScreenArgs(args: {'path': val.file}));
                                },
                                child: Image.file(File(val.file)));
                          } else {
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: 250.sm,
                                  width: double.infinity,
                                  color: darkBg,
                                  child: Opacity(
                                    opacity: 0.7,
                                    child: Image.file(
                                      File(val.thumbnail!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        '/offlinevideoplayer',
                                        arguments: ScreenArgs(
                                            args: {'path': val.file}));
                                  },
                                  child: CircleAvatar(
                                    radius: 25.sm,
                                    backgroundColor: darkBg.withOpacity(0.5),
                                    child: Icon(
                                      Icons.play_arrow_rounded,
                                      color: smoothWhite,
                                      size: 25.sm,
                                    ),
                                  ),
                                )
                              ],
                            );
                          }
                        }
                      }),
                  Gap(H: 40.sm),
                  PostUploadButtonWidget()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PostUploadButtonWidget extends StatelessWidget {
  const PostUploadButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadPostBloc, UploadPostState>(
      builder: (context, state) {
        return MaterialButton(
          color: Theme.of(context).appBarTheme.backgroundColor,
          child: SizedBox(
            width: 130.sm,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "UPLOAD",
                  style: TextStyle(color: pureWhite, fontSize: 16.sm),
                ),
                Gap(W: 10.sm),
                IconTheme(
                    data: Theme.of(context).primaryIconTheme,
                    child: Icon(Icons.upload_rounded))
              ],
            ),
          ),
          onPressed: () {
            if (PostTextFieldControllers.discription.text.trim().isEmpty &&
                post.value == null) {
              Navigator.of(context).pushReplacementNamed('/home');
            } else {
              final date = DateTime.now();
              final postModel = PostModel(
                  postId: Uuid().v4(),
                  userId: Global.USER_DATA.id,
                  post: post.value == null ? null : post.value!.file,
                  createdAt: date,
                  laseEdit: date,
                  comments: const [],
                  lights: const [],
                  type: post.value == null ? PostType.text : post.value!.type,
                  videoThumbnail:
                      post.value == null || post.value!.type != PostType.video
                          ? null
                          : post.value!.thumbnail,
                  discription:
                      NewPostTextEditControllers.discription.text.trim().isEmpty
                          ? null
                          : NewPostTextEditControllers.discription.text.trim(),
                  tag: NewPostTextEditControllers.tag.text.trim().isEmpty
                      ? null
                      : NewPostTextEditControllers.tag.text.trim(),
                  reports: const []);

              if (postModel.type != PostType.text) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  context
                      .read<UploadPostBloc>()
                      .add(UplaodNewMediaPost(postModel: postModel));
                });
              } else {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  context
                      .read<UploadPostBloc>()
                      .add(UplaodNewTextPost(postModel: postModel));
                });
              }
            }
          },
        );
      },
    );
  }
}

showNewPostSheet(context) {
  showModalBottomSheet(
      context: context,
      builder: (ctx) => ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.sm),
                topRight: Radius.circular(30.sm)),
            child: Padding(
              padding: EdgeInsets.all(10.sm),
              child: Container(
                height: 120.sm,
                color: Theme.of(context).bottomSheetTheme.backgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      onTap: () async {
                        final file = await Utility.pickImage();
                        if (file == null) {
                          Navigator.of(context).pop();
                        } else {
                          final image = await Utility.cropImage(file: file);
                          if (image == null) {
                            Navigator.of(context).pop();
                            return;
                          } else {
                            final postTypeModel = PostTypeModel(
                                file: image,
                                type: PostType.image,
                                thumbnail: null);

                            post.value = postTypeModel;
                            post.notifyListeners();
                            Navigator.of(context).pop();
                          }
                        }
                      },
                      leading: IconTheme(
                          data: Theme.of(context).iconTheme,
                          child: Icon(
                            Icons.add_photo_alternate,
                            size: 30.sm,
                          )),
                      title: Text(
                        "Image",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 18.sm),
                      ),
                    ),
                    ListTile(
                      onTap: () async {
                        final video = await Utility.pickVideo();
                        if (video == null) {
                          Navigator.of(context).pop();
                        } else {
                          final thumbnail =
                              await Utility.generateVideoThumbnail(
                                  videoPath: video);

                          final postTypeModel = PostTypeModel(
                              file: video,
                              type: PostType.video,
                              thumbnail: thumbnail);
                          post.value = postTypeModel;
                          post.notifyListeners();
                          Navigator.of(context).pop();
                        }
                      },
                      leading: IconTheme(
                          data: Theme.of(context).iconTheme,
                          child: Icon(
                            Icons.video_call,
                            size: 30.sm,
                          )),
                      title: Text(
                        "Video",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 18.sm),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
}
