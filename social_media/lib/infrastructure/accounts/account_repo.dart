import 'package:dartz/dartz.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';

abstract class AccountRepo {
  Future<Either<UserModel, MainFailures>> createAccount(
      {required UserModel model, required String password});
  Future<Either<UserModel, MainFailures>> logOut();
  Future<Either<UserModel, MainFailures>> login(
      {required String email, required String password});
}
