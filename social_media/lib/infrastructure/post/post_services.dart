import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media/core/collections/firebase_collections.dart';
import 'package:social_media/core/functions/fb.dart';
import 'package:social_media/domain/models/local_models/like_model.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/models/post_model/post_model.dart';
import 'package:social_media/infrastructure/post/post_repo.dart';
import 'package:social_media/presentation/screens/new_post/new_post_screen.dart';

@LazySingleton(as: PostRepo)
class PostServices implements PostRepo {
  @override
  Future<Either<LikeModel, MainFailures>> likePost(
      {required LikeModel likeObj}) async {
    try {
      final postsData = await FirebaseFirestore.instance
          .collection(Collections.post)
          .doc(likeObj.postId)
          .get();

      PostModel model = PostModel.fromMap(postsData.data()!);

      List<String> lights = model.lights;

      lights.add(likeObj.likerId);

      model.copyWith(lights: lights).toMap();
      await FirebaseFirestore.instance
          .collection(Collections.post)
          .doc(likeObj.postId)
          .set(model.toMap());

      return Left(LikeModel(likerId: likeObj.likerId, postId: likeObj.postId));
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
  }
}
