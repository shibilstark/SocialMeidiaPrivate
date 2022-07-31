part of 'follow_bloc.dart';

abstract class FollowEvent extends Equatable {
  const FollowEvent();

  @override
  List<Object> get props => [];
}

class Follow extends FollowEvent {
  final String profileId;
  const Follow({required this.profileId});
}

class UnFollow extends FollowEvent {
  final String profileId;
  const UnFollow({required this.profileId});
}
