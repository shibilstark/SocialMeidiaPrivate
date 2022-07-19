import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media/core/collections/firebase_collections.dart';
import 'package:social_media/core/functions/fb.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/domain/models/post_model/post_model.dart';
import 'package:social_media/domain/models/profile_model/profile_model.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';
import 'package:social_media/infrastructure/profile/profile_repo.dart';

@LazySingleton(as: ProfileRepo)
class ProfileServices implements ProfileRepo {
  @override
  Future<Either<ProfileModel, MainFailures>> getCurrentUser() async {
    try {
      final userData = await FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(Global.USER_DATA.id)
          .get();

      UserModel userModel = UserModel.fromMap(userData.data()!);

      final postsData =
          await FirebaseFirestore.instance.collection(Collections.post).get();

      List<PostModel> posts = [];

      postsData.docs.map((post) {
        if (post.data()["userId"] == Global.USER_DATA.id) {
          PostModel postModel = PostModel.fromMap(post.data());

          posts.add(postModel);
        }
      });

      return Left(ProfileModel(posts: posts, user: userModel));
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

  @override
  Future<Either<String?, MainFailures>> changeCoverPic(
      {required String? newPic}) async {
    try {
      final userData = await FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(Global.USER_DATA.id);

      if (newPic == null) {
        await userData.update({'coverImage': null});

        return Left(null);
      } else {
        UploadTask? task;
        UploadTask? thumbTask;
        final imageDestination =
            "${Global.USER_DATA.id}/coverImage/${DateTime.now().toString()}";

        final ref = FirebaseStorage.instance.ref(imageDestination);
        task = ref.putFile(File(newPic));
        final snapShot = await task.whenComplete(() {});

        final imageUrl = await snapShot.ref.getDownloadURL();

        await userData.update({'coverImage': imageUrl});

        return Left(imageUrl);
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
  }

  @override
  Future<Either<String?, MainFailures>> changeProfilePic(
      {required String? newPic}) async {
    try {
      final userData = await FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(Global.USER_DATA.id);

      if (newPic == null) {
        userData.update({'profileImage': null});

        return Left(null);
      } else {
        UploadTask? task;
        UploadTask? thumbTask;
        final imageDestination =
            "${Global.USER_DATA.id}/profile/${DateTime.now().toString()}";

        final ref = FirebaseStorage.instance.ref(imageDestination);
        task = ref.putFile(File(newPic));
        final snapShot = await task.whenComplete(() {});

        final imageUrl = await snapShot.ref.getDownloadURL();

        userData.update({'profileImage': imageUrl});

        return Left(imageUrl);
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
  }
}
