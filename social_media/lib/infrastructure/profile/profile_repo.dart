import 'package:dartz/dartz.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/models/local_models/name_and_disc.dart';
import 'package:social_media/domain/models/profile_model/profile_model.dart';

abstract class ProfileRepo {
  Future<Either<ProfileModel, MainFailures>> getCurrentUser();
  Future<Either<ProfileModel, MainFailures>> getUserWithId(
      {required String userId});
  Future<Either<String?, MainFailures>> changeProfilePic(
      {required String? newPic});
  Future<Either<String?, MainFailures>> changeCoverPic(
      {required String? newPic});
  Future<Either<NameAndDisc, MainFailures>> changeNameAndDisc(
      {required NameAndDisc obj});
  Future<Either<String, MainFailures>> deletePost(String postId);
  Future<Either<String?, MainFailures>> editPostDiscrption(
      {required String? newDisc, required String postId});
}
