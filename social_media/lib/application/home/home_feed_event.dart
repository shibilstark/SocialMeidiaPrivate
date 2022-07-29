part of 'home_feed_bloc.dart';

abstract class HomeFeedEvent extends Equatable {
  const HomeFeedEvent();

  @override
  List<Object> get props => [];
}

class GetHomeFeed extends HomeFeedEvent {
  const GetHomeFeed();
}
