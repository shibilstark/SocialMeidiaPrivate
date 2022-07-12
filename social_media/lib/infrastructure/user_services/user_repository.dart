import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/models/profile_feed/profile_feed_model.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';

abstract class UserRepo {
  Future<Either<ProfileFeedModel, MainFailures>> fetchUser(
      {required String id});
  Future<Either<UserModel, MainFailures>> removeProfilePic();
  Future<Either<UserModel, MainFailures>> removeCoverImage();
  Future<Either<UserModel, MainFailures>> changeProfileImage();
  Future<Either<UserModel, MainFailures>>          changeCoverImage();
  Future<Either<UserModel, MainFailures>> editNameAndDisc(
      {required String name, required String discription});
}
