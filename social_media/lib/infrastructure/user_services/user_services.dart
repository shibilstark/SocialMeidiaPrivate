import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media/core/collections/firebase_collections.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/domain/models/local_models/post_type_model.dart';
import 'package:social_media/domain/models/post_model/post_model.dart';
import 'package:social_media/domain/models/profile_feed/profile_feed_model.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';
import 'package:social_media/infrastructure/connection_check/connection_check.dart';
import 'package:social_media/infrastructure/user_services/user_repository.dart';

@LazySingleton(as: UserRepo)
class UserServices implements UserRepo {
  @override
  Future<Either<ProfileFeedModel, MainFailures>> fetchUser(
      {required String id}) async {
    try {
      final connection = await ConnectionState.checkConnection();

      if (connection == InternetConnected.notConnected) {
        return const Right(MainFailures(
            error: "Check Connecton again",
            failureType: MyAppFilures.networkFailure));
      }

      final user = await FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(id)
          .get();
      final UserModel userModel = UserModel.fromMap(user.data()!);
      final postsInModel = userModel.posts.toList();
      final postCollection =
          await FirebaseFirestore.instance.collection(Collections.post).get();

      final posts = postCollection.docs.toList();
      final List<PostModel> showPosts = [];
      if (postsInModel.isNotEmpty) {
        for (var post in posts) {
          for (String eachPost in postsInModel) {
            log(post.id);
            if (eachPost == post.data()['postId']) {
              PostModel postModel = PostModel.fromMap(post.data());

              showPosts.add(postModel);
            } else {
              continue;
            }
          }
        }
      }

      final feed = ProfileFeedModel(user: userModel, post: showPosts);

      return Left(feed);
    } on FirebaseException catch (e) {
      log(e.toString());

      return Right(MainFailures(
          error: e.code.toString(), failureType: MyAppFilures.firebaseFailure));
    } catch (e) {
      log(e.toString());
      return Right(MainFailures(
          error: e.toString(), failureType: MyAppFilures.firebaseFailure));
    }
  }

  @override
  Future<Either<UserModel, MainFailures>> removeProfilePic() async {
    try {
      final connection = await ConnectionState.checkConnection();

      if (connection == InternetConnected.notConnected) {
        return const Right(MainFailures(
            error: "Check Connecton again",
            failureType: MyAppFilures.networkFailure));
      }
      final user = await FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(Global.USER_DATA.id)
          .get();
      final UserModel userModel = UserModel.fromMap(user.data()!);

      final newUserModel = userModel.copyWith(profileImage: "");

      await FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(Global.USER_DATA.id)
          .set(newUserModel.toMap());

      final updatedModelUserData = await FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(Global.USER_DATA.id)
          .get();
      final updatedModelUserModel =
          UserModel.fromMap(updatedModelUserData.data()!);

      return Left(updatedModelUserModel);
    } on FirebaseException catch (e) {
      log(e.toString());

      return Right(MainFailures(
          error: e.code.toString(), failureType: MyAppFilures.firebaseFailure));
    } catch (e) {
      log(e.toString());
      return Right(MainFailures(
          error: e.toString(), failureType: MyAppFilures.firebaseFailure));
    }
  }

  @override
  Future<Either<UserModel, MainFailures>> removeCoverImage() async {
    try {
      final connection = await ConnectionState.checkConnection();

      if (connection == InternetConnected.notConnected) {
        return const Right(MainFailures(
            error: "Check Connecton again",
            failureType: MyAppFilures.networkFailure));
      }
      final user = await FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(Global.USER_DATA.id)
          .get();
      final UserModel userModel = UserModel.fromMap(user.data()!);

      final newUserModel = userModel.copyWith(coverImage: "");
      log("remove cover image working");
      await FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(Global.USER_DATA.id)
          .set(newUserModel.toMap());

      final updatedModelUserData = await FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(Global.USER_DATA.id)
          .get();
      final updatedModelUserModel =
          UserModel.fromMap(updatedModelUserData.data()!);

      return Left(updatedModelUserModel);
    } on FirebaseException catch (e) {
      log(e.toString());

      return Right(MainFailures(
          error: e.code.toString(), failureType: MyAppFilures.firebaseFailure));
    } catch (e) {
      log(e.toString());
      return Right(MainFailures(
          error: e.toString(), failureType: MyAppFilures.firebaseFailure));
    }
  }

  @override
  Future<Either<UserModel, MainFailures>> changeProfileImage() async {
    try {
      final result = await FilePicker.platform
          .pickFiles(type: FileType.image, allowMultiple: false);

      if (result == null) {
        return const Right(MainFailures(
            error: "File not selected",
            failureType: MyAppFilures.clientFailure));
      } else {
        // return Left(PostTypeModel(file: result, type: PostType.image));

        final image = await ImageCropper().cropImage(
          sourcePath: result.paths.single!,
          // aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          aspectRatioPresets: [
            CropAspectRatioPreset.ratio5x4,
            CropAspectRatioPreset.ratio16x9,
            CropAspectRatioPreset.ratio4x3
          ],
          compressFormat: ImageCompressFormat.jpg,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: "Crop Image",
              toolbarColor: darkBg,
              toolbarWidgetColor: pureWhite,
            )
          ],
        );

        if (image == null) {
          return const Right(MainFailures(
              error: "File not selected",
              failureType: MyAppFilures.clientFailure));
        } else {
          final connection = await ConnectionState.checkConnection();

          if (connection == InternetConnected.notConnected) {
            return const Right(MainFailures(
                error: "Check Connecton again",
                failureType: MyAppFilures.networkFailure));
          }
          final user = await FirebaseFirestore.instance
              .collection(Collections.users)
              .doc(Global.USER_DATA.id)
              .get();
          final UserModel userModel = UserModel.fromMap(user.data()!);
          final destination =
              "images/profile/${Global.USER_DATA.id + DateTime.now.toString() + "profileImage"}";
          UploadTask? task;
          final ref = FirebaseStorage.instance.ref(destination);
          task = ref.putFile(File(image.path));
          final snapShot = await task.whenComplete(() {});
          final url = await snapShot.ref.getDownloadURL();

          final newUserModel = userModel.copyWith(profileImage: url);
          await FirebaseFirestore.instance
              .collection(Collections.users)
              .doc(Global.USER_DATA.id)
              .set(newUserModel.toMap());

          final updatedModelUserData = await FirebaseFirestore.instance
              .collection(Collections.users)
              .doc(Global.USER_DATA.id)
              .get();
          final updatedModelUserModel =
              UserModel.fromMap(updatedModelUserData.data()!);

          return Left(updatedModelUserModel);
        }
      }
    } on FirebaseException catch (e) {
      log(e.toString());

      return Right(MainFailures(
          error: e.code.toString(), failureType: MyAppFilures.firebaseFailure));
    } catch (e) {
      log(e.toString());
      return Right(MainFailures(
          error: e.toString(), failureType: MyAppFilures.firebaseFailure));
    }
  }

  @override
  Future<Either<UserModel, MainFailures>> changeCoverImage() async {
    try {
      final result = await FilePicker.platform
          .pickFiles(type: FileType.image, allowMultiple: false);

      if (result == null) {
        return const Right(MainFailures(
            error: "File not selected",
            failureType: MyAppFilures.clientFailure));
      } else {
        // return Left(PostTypeModel(file: result, type: PostType.image));

        final image = await ImageCropper().cropImage(
          sourcePath: result.paths.single!,
          // aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          aspectRatioPresets: [
            CropAspectRatioPreset.ratio5x4,
            CropAspectRatioPreset.ratio16x9,
            CropAspectRatioPreset.ratio4x3
          ],
          compressFormat: ImageCompressFormat.jpg,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: "Crop Image",
              toolbarColor: darkBg,
              toolbarWidgetColor: pureWhite,
            )
          ],
        );

        if (image == null) {
          return const Right(MainFailures(
              error: "File not selected",
              failureType: MyAppFilures.clientFailure));
        } else {
          final connection = await ConnectionState.checkConnection();

          if (connection == InternetConnected.notConnected) {
            return const Right(MainFailures(
                error: "Check Connecton again",
                failureType: MyAppFilures.networkFailure));
          }
          final user = await FirebaseFirestore.instance
              .collection(Collections.users)
              .doc(Global.USER_DATA.id)
              .get();
          final UserModel userModel = UserModel.fromMap(user.data()!);
          final destination =
              "images/cover/${Global.USER_DATA.id + DateTime.now.toString() + "profileImage"}";
          UploadTask? task;
          final ref = FirebaseStorage.instance.ref(destination);
          task = ref.putFile(File(image.path));
          final snapShot = await task.whenComplete(() {});
          final url = await snapShot.ref.getDownloadURL();

          final newUserModel = userModel.copyWith(coverImage: url);
          await FirebaseFirestore.instance
              .collection(Collections.users)
              .doc(Global.USER_DATA.id)
              .set(newUserModel.toMap());

          final updatedModelUserData = await FirebaseFirestore.instance
              .collection(Collections.users)
              .doc(Global.USER_DATA.id)
              .get();
          final updatedModelUserModel =
              UserModel.fromMap(updatedModelUserData.data()!);

          return Left(updatedModelUserModel);
        }
      }
    } on FirebaseException catch (e) {
      log(e.toString());

      return Right(MainFailures(
          error: e.code.toString(), failureType: MyAppFilures.firebaseFailure));
    } catch (e) {
      log(e.toString());
      return Right(MainFailures(
          error: e.toString(), failureType: MyAppFilures.firebaseFailure));
    }
  }

  @override
  Future<Either<UserModel, MainFailures>> editNameAndDisc(
      {required String name, required String discription}) async {
    try {
      final connection = await ConnectionState.checkConnection();

      if (connection == InternetConnected.notConnected) {
        return const Right(MainFailures(
            error: "Check Connecton again",
            failureType: MyAppFilures.networkFailure));
      }
      final user = await FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(Global.USER_DATA.id)
          .get();
      final UserModel userModel = UserModel.fromMap(user.data()!);

      final newUserModel =
          userModel.copyWith(name: name, discription: discription);

      await FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(Global.USER_DATA.id)
          .set(newUserModel.toMap());

      final updatedModelUserData = await FirebaseFirestore.instance
          .collection(Collections.users)
          .doc(Global.USER_DATA.id)
          .get();
      final updatedModelUserModel =
          UserModel.fromMap(updatedModelUserData.data()!);

      return Left(updatedModelUserModel);
    } on FirebaseException catch (e) {
      log(e.toString());

      return Right(MainFailures(
          error: e.code.toString(), failureType: MyAppFilures.firebaseFailure));
    } catch (e) {
      log(e.toString());
      return Right(MainFailures(
          error: e.toString(), failureType: MyAppFilures.firebaseFailure));
    }
  }
}
