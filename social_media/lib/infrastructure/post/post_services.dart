import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media/application/post_actions/post_actions_bloc.dart';
import 'package:social_media/core/collections/firebase_collections.dart';
import 'package:social_media/core/functions/fb.dart';
import 'package:social_media/domain/models/local_models/like_model.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/infrastructure/post/post_repo.dart';

@LazySingleton(as: PostRepo)
class PostServices implements PostRepo {
  @override
  Future<Either<PostActionsState, MainFailures>> like(LikeModel likeObj) async {
    try {
      final post = FirebaseFirestore.instance
          .collection(Collections.post)
          .doc(likeObj.postId);

      final datas = await post.get();
      final lights = await datas.data()!["lights"] as List;

      if (lights.contains(likeObj.likerId)) {
        await post.update({
          "lights": FieldValue.arrayRemove([likeObj.likerId])
        });
        return Left(PostActionDisLikeSuccess(
            LikeModel(postId: likeObj.postId, likerId: likeObj.likerId)));
      } else {
        await post.update({
          "lights": FieldValue.arrayUnion([likeObj.likerId])
        });
        return Left(PostActionLikeSuccess(
            LikeModel(postId: likeObj.postId, likerId: likeObj.likerId)));
      }
    } on FirebaseException catch (e) {
      log(e.toString());
      return Right(MainFailures(
          error: firebaseCodeFix(e.code),
          failureType: MyAppFilures.firebaseFailure));
    } catch (e) {
      log(e.toString());
      return Right(MainFailures(
          error: e.toString(), failureType: MyAppFilures.clientFailure));
    }
    // throw (e) {
    //   log(e.toString());
    // };
  }
}
