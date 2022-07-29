part of 'home_feed_bloc.dart';

abstract class HomeFeedState extends Equatable {
  const HomeFeedState();

  @override
  List<Object> get props => [];
}

class HomeFeedInitial extends HomeFeedState {}

class HomeFeedLoding extends HomeFeedState {}

class HomeFeedSuccess extends HomeFeedState {}

class HomeFeedError extends HomeFeedState {}
