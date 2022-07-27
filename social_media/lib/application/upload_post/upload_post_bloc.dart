import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_media/core/collections/firebase_collections.dart';
import 'package:social_media/core/functions/fb.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/domain/models/post_model/post_model.dart';

part 'upload_post_event.dart';
part 'upload_post_state.dart';

class UploadPostBloc extends Bloc<UploadPostEvent, UploadPostState> {
  UploadPostBloc() : super(UploadPostInitial()) {
    on<UplaodNewMediaPost>((event, emit) async {
      try {
        emit(UploadPostLoading());
        final destination =
            "posts/${Global.USER_DATA.id}/${Global.USER_DATA.id + DateTime.now().toString()}";
        final thumbDestination =
            "posts/thumbs/${Global.USER_DATA.id}/${Global.USER_DATA.id + DateTime.now().toString()}";
        if (event.postModel.type == PostType.image) {
          UploadTask? task;
          final postCollection =
              FirebaseFirestore.instance.collection(Collections.post);
          final ref = FirebaseStorage.instance.ref(destination);
          task = ref.putFile(File(event.postModel.post!));

          emit(UploadingPost(task.snapshotEvents));

          final snapShot = await task.whenComplete(() {});

          final imageUrl = await snapShot.ref.getDownloadURL();
          final newPostModel = event.postModel.copyWith(post: imageUrl);

          await postCollection
              .doc(newPostModel.postId)
              .set(newPostModel.toMap());
          emit(UploadPostSuccess(newPostModel));
        }
        if (event.postModel.type == PostType.video) {
          UploadTask? task;
          UploadTask? thumbTask;
          final postCollection =
              FirebaseFirestore.instance.collection(Collections.post);
          final ref = FirebaseStorage.instance.ref(destination);
          final thumbRef = FirebaseStorage.instance.ref(thumbDestination);
          thumbTask = thumbRef.putFile(File(event.postModel.videoThumbnail!));
          task = ref.putFile(File(event.postModel.post!));

          emit(UploadingPost(task.snapshotEvents));

          final snapShot = await task.whenComplete(() {});
          final thumbSnapShot = await thumbTask.whenComplete(() {});

          final videoUrl = await snapShot.ref.getDownloadURL();
          final thumbUrl = await thumbSnapShot.ref.getDownloadURL();
          final newPostModel = event.postModel
              .copyWith(post: videoUrl, videoThumbnail: thumbUrl);

          await postCollection
              .doc(newPostModel.postId)
              .set(newPostModel.toMap());
          emit(UploadPostSuccess(newPostModel));
        }
      } on FirebaseException catch (e) {
        emit(UploadPostError(MainFailures(
            error: firebaseCodeFix(e.code),
            failureType: MyAppFilures.firebaseFailure)));
      } catch (e) {
        emit(UploadPostError(MainFailures(
            error: e.toString(), failureType: MyAppFilures.firebaseFailure)));
      }
    });

    on<UplaodNewTextPost>((event, emit) async {
      try {
        emit(UploadPostLoading());
        final postCollection =
            FirebaseFirestore.instance.collection(Collections.post);
        await postCollection
            .doc(event.postModel.postId)
            .set(event.postModel.toMap());

        emit(UploadPostSuccess(event.postModel));
      } on FirebaseException catch (e) {
        emit(UploadPostError(MainFailures(
            error: firebaseCodeFix(e.code),
            failureType: MyAppFilures.firebaseFailure)));
      } catch (e) {
        emit(UploadPostError(MainFailures(
            error: e.toString(), failureType: MyAppFilures.firebaseFailure)));
      }
    });
  }
}
