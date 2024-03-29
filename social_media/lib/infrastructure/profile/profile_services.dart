import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media/core/collections/firebase_collections.dart';
import 'package:social_media/core/functions/fb.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/domain/models/local_models/name_and_disc.dart';
import 'package:social_media/domain/models/post_model/post_model.dart';
import 'package:social_media/domain/models/profile_model/profile_model.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';
import 'package:social_media/infrastructure/profile/profile_repo.dart';

import 'package:flutter/foundation.dart' as printer;

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

      final postsData = await FirebaseFirestore.instance
          .collection(Collections.post)
          .orderBy('createdAt', descending: true)
          .get();

      List<PostModel> posts = [];

      postsData.docs.map((post) {
        if (post.data()["userId"] == Global.USER_DATA.id) {
          PostModel postModel = PostModel.fromMap(post.data());
          posts.add(postModel);
        }
      }).toList();
      log(posts.length.toString());
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
        await userData.update({'profileImage': null});

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

        await userData.update({'profileImage': imageUrl});

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
  Future<Either<NameAndDisc, MainFailures>> changeNameAndDisc(
      {required NameAndDisc obj}) async {
    try {
      final userData = await FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(Global.USER_DATA.id);

      await userData.update({'name': obj.name, 'discription': obj.disc});

      return Left(obj);
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
  Future<Either<String, MainFailures>> deletePost(String postId) async {
    try {
      final postData = await FirebaseFirestore.instance
          .collection(Collections.post)
          .doc(postId)
          .get();

      // await FirebaseStorage.instance.ref(postData.data()!['postId']).delete();
      await FirebaseStorage.instance
          .refFromURL(postData.data()!['post'])
          .delete();

      await FirebaseFirestore.instance
          .collection(Collections.post)
          .doc(postId)
          .delete();

      return Left(postId);
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
  Future<Either<String?, MainFailures>> editPostDiscrption(
      {required String? newDisc, required String postId}) async {
    try {
      log("${newDisc}");
      final userData = await FirebaseFirestore.instance
          .collection(Collections.post)
          .doc(postId);

      if (newDisc == null) {
        await userData.update({'discription': null});

        printer.debugPrint("${newDisc}");
      } else {
        await userData.update({'discription': newDisc});
        printer.debugPrint("${newDisc}");
      }

      return Left(newDisc);
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
  Future<Either<ProfileModel, MainFailures>> getUserWithId(
      {required String userId}) async {
    try {
      final userData = await FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(userId)
          .get();

      UserModel userModel = UserModel.fromMap(userData.data()!);

      final postsData = await FirebaseFirestore.instance
          .collection(Collections.post)
          .orderBy('createdAt', descending: true)
          .get();

      List<PostModel> posts = [];

      postsData.docs.map((post) {
        if (post.data()["userId"] == userId) {
          PostModel postModel = PostModel.fromMap(post.data());
          posts.add(postModel);
        }
      }).toList();
      log(posts.length.toString());
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
  Future<Either<String, MainFailures>> follow(
      {required String profileId}) async {
    try {
      final user = FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(profileId);
      final selfUser = FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(Global.USER_DATA.id);
      final self = await FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(Global.USER_DATA.id)
          .get();

      final datas = await user.get();
      final followers = await datas.data()!["followers"] as List;
      final following = await self.data()!["following"] as List;

      if (!followers.contains(Global.USER_DATA.id)) {
        await user.update({
          "followers": FieldValue.arrayUnion([Global.USER_DATA.id])
        });

        if (!following.contains(profileId)) {
          await selfUser.update({
            "following": FieldValue.arrayUnion([profileId])
          });
        }
      }

      return Left(Global.USER_DATA.id);
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
  Future<Either<String, MainFailures>> unfollow(
      {required String profileId}) async {
    try {
      final user = FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(profileId);
      final selfUser = FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(Global.USER_DATA.id);
      final self = await FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(Global.USER_DATA.id)
          .get();

      final datas = await user.get();
      final followers = await datas.data()!["followers"] as List;
      final following = await self.data()!["following"] as List;

      if (followers.contains(Global.USER_DATA.id)) {
        await user.update({
          "followers": FieldValue.arrayRemove([Global.USER_DATA.id])
        });

        if (following.contains(profileId)) {
          await selfUser.update({
            "following": FieldValue.arrayRemove([profileId])
          });
        }
      }

      // if (followers.contains(profileId)) {
      //   await post.update({
      //     "followers": FieldValue.arrayRemove([profileId])
      //   });
      //   return Left(PostActionDisLikeSuccess(
      //       LikeModel(postId: likeObj.postId, likerId: profileId)));
      // } else {
      //   await post.update({
      //     "followers": FieldValue.arrayUnion([profileId])
      //   });
      //   return Left(PostActionLikeSuccess(
      //       LikeModel(postId: likeObj.postId, likerId: profileId)));
      // }

      return Left(Global.USER_DATA.id);
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
