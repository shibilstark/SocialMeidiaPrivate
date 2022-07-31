import 'package:dartz/dartz.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';

abstract class SearchRepo {
  Future<Either<List<UserModel>, MainFailures>> searchUser(
      {required String query});
}
