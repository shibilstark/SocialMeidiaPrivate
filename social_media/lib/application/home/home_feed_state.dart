part of 'home_feed_bloc.dart';

abstract class HomeFeedState extends Equatable {
  const HomeFeedState();

  @override
  List<Object> get props => [];
}

class HomeFeedInitial extends HomeFeedState {}

class HomeFeedLoding extends HomeFeedState {}

class HomeFeedSuccess extends HomeFeedState {
  List<HomeFeedModel> homeFeed;

  HomeFeedSuccess(this.homeFeed);
  @override
  List<Object> get props => [homeFeed];
}

class HomeFeedError extends HomeFeedState {
  MainFailures failure;
  HomeFeedError(this.failure);
  @override
  List<Object> get props => [failure];
}
