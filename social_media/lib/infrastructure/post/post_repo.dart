import 'package:dartz/dartz.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/models/local_models/like_model.dart';

import '../../application/post_actions/post_actions_bloc.dart';

abstract class PostRepo {
  Future<Either<PostActionsState, MainFailures>> like(LikeModel likeObj);
}
