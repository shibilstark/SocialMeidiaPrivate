import 'package:dartz/dartz.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/models/profile_model/profile_model.dart';

abstract class ProfileRepo {
  Future<Either<ProfileModel, MainFailures>> getCurrentUser();
  Future<Either<String?, MainFailures>> changeProfilePic(
      {required String? newPic});
  Future<Either<String?, MainFailures>> changeCoverPic(
      {required String? newPic});
}