import 'dart:developer';
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media/core/functions/fb.dart';
import 'package:social_media/domain/models/home_feed/home_feed_model.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:social_media/domain/models/post_model/post_model.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';
import 'package:social_media/infrastructure/home/home_repo.dart';

import '../../core/collections/firebase_collections.dart';

@LazySingleton(as: HomeRepo)
class HomeServices implements HomeRepo {
  @override
  Future<Either<List<HomeFeedModel>, MainFailures>> getHomeFeed() async {
    try {
      log("feed called");
      final userCollection =
          FirebaseFirestore.instance.collection(Collections.users);
      final postsCollection =
          await FirebaseFirestore.instance.collection(Collections.post).get();

      List<HomeFeedModel> feeds = [];

      for (QueryDocumentSnapshot<Map<String, dynamic>> e
          in postsCollection.docs) {
        final post = PostModel.fromMap(e.data());
        final user = await userCollection.doc(post.userId).get();
        final usermodal = UserModel.fromMap(user.data()!);
        final homeFeedModel = HomeFeedModel(post: post, user: usermodal);
        feeds.add(homeFeedModel);
      }

      if (feeds.length >= 31) {
        feeds = feeds.take(30).toList();
      }

      log("global Feeds == ${feeds.length}");
      feeds.shuffle(
          // math.Random()
          );

      return Left(feeds);
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
