import 'package:dartz/dartz.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/models/local_models/like_model.dart';

abstract class PostRepo {
  Future<Either<LikeModel, MainFailures>> likePost(
      {required LikeModel likeObj});
}
