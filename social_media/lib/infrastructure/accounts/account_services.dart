import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media/core/collections/firebase_collections.dart';
import 'package:social_media/core/controllers/text_controllers.dart';
import 'package:social_media/domain/db/user_data/user_data.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:social_media/infrastructure/accounts/account_repo.dart';

@LazySingleton(as: AccountRepo)
class AccountServices implements AccountRepo {
  //
  //
  //
  //
  //
  //
  //
  //
  @override
  Future<Either<UserModel, MainFailures>> createAccount(
      {required String password, required UserModel model}) async {
    try {
      final collection =
          FirebaseFirestore.instance.collection(Collections.users);

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: model.email, password: password);

      await collection.doc(model.userId).set(model.toMap());

      return Left(model);
    } on FirebaseException catch (e) {
      log(e.toString());

      return Right(MainFailures(
          error: e.toString(), failureType: MyAppFilures.firebaseFailure));
    } catch (e) {
      log(e.toString());
      return Right(MainFailures(
          error: e.toString(), failureType: MyAppFilures.clientFailure));
    }
  }

  //
  //
  //
  //
  //
  //
  //
  //
  @override
  Future<Either<UserModel, MainFailures>> login(
      {required String email, required String password}) async {
    try {
      final collection =
          await FirebaseFirestore.instance.collection(Collections.users).get();
      final users = collection.docs;

      for (var user in users) {
        if (user.data()[UmKeys.email] == email) {
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);

          await UserDataStore.saveUserData(
            id: user.data()[UmKeys.userId],
            email: email,
          );
          log("Success");
          return Left(UserModel.fromMap(user.data()));
        } else {
          log("User Not Found");
          return const Right(MainFailures(
              error: "User Not Found",
              failureType: MyAppFilures.emailOrPasswordFailure));
        }
      }
    } on FirebaseException catch (e) {
      log(e.toString());
      e.toString();
      return Right(MainFailures(
          error: e.code.toString(), failureType: MyAppFilures.firebaseFailure));
    } catch (e) {
      log(e.toString());
      return Right(MainFailures(
          error: e.toString(), failureType: MyAppFilures.firebaseFailure));
    }

    return const Right(MainFailures(
        error: "Something went wrong",
        failureType: MyAppFilures.clientFailure));
  }

  //
  //
  //
  //
  //
  //
  //
  //
  @override
  Future<Either<UserModel, MainFailures>> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      await UserDataStore.clearUserData();
    } on FirebaseException catch (e) {
      e.toString();
      return Right(MainFailures(
          error: e.code.toString(), failureType: MyAppFilures.firebaseFailure));
    } catch (e) {
      e.toString();
      return Right(MainFailures(
          error: e.toString(), failureType: MyAppFilures.firebaseFailure));
    }

    return const Right(MainFailures(
        error: "Something went wrong",
        failureType: MyAppFilures.clientFailure));
  }

  //
  //
  //
  //
  //
  //
  //
  //
}
