import 'package:dartz/dartz.dart';
import 'package:social_media/domain/models/home_feed/home_feed_model.dart';

import '../../domain/failures/main_failures.dart';

abstract class HomeRepo {
  Future<Either<List<HomeFeedModel>, MainFailures>> getHomeFeed();
}
