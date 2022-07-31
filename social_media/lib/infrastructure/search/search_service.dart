import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media/core/collections/firebase_collections.dart';
import 'package:social_media/core/functions/fb.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';
import 'package:social_media/infrastructure/search/search_repo.dart';

@LazySingleton(as: SearchRepo)
class SearchServices implements SearchRepo {
  @override
  Future<Either<List<UserModel>, MainFailures>> searchUser(
      {required String query}) async {
    try {
      List<UserModel> searchResults = [];
      final userData =
          await FirebaseFirestore.instance.collection(Collections.users).get();

      userData.docs.forEach((element) {
        final currentUser = UserModel.fromMap(element.data());

        if (currentUser.name
            .replaceAll(" ", "")
            .trim()
            .toLowerCase()
            .contains(query)) {
          searchResults.add(currentUser);
        }
      });
      searchResults.sort((a, b) {
        return a.name.compareTo(b.name);
      });

      return Left(searchResults);
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
