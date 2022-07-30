part of 'others_profile_bloc.dart';

abstract class OthersProfileState extends Equatable {
  const OthersProfileState();

  @override
  List<Object> get props => [];
}

class OthersProfileInitial extends OthersProfileState {}

class OthersProfileLoading extends OthersProfileState {}

class OthersProfileSuccess extends OthersProfileState {
  ProfileModel profileModel;
  OthersProfileSuccess(this.profileModel);
  @override
  List<Object> get props => [profileModel];
}

class OthersProfileError extends OthersProfileState {
  MainFailures failure;
  OthersProfileError(this.failure);

  @override
  List<Object> get props => [failure];
}
