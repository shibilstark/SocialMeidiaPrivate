part of 'follow_bloc.dart';

abstract class FollowState extends Equatable {
  const FollowState();

  @override
  List<Object> get props => [];
}

class FollowInitial extends FollowState {}

class FollowSuccess extends FollowState {
  String profileId;
  FollowSuccess(this.profileId);
  @override
  List<Object> get props => [profileId];
}

class FollowError extends FollowState {
  MainFailures failure;
  FollowError(this.failure);

  @override
  List<Object> get props => [failure];
}

class UnFollowSuccess extends FollowState {
  String profileId;
  UnFollowSuccess(this.profileId);
  @override
  List<Object> get props => [profileId];
}

class UnFollowError extends FollowState {
  MainFailures failure;
  UnFollowError(this.failure);

  @override
  List<Object> get props => [failure];
}
