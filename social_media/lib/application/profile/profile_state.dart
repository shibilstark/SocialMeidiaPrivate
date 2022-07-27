// ignore_for_file: must_be_immutable

part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

// Get Current User
class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  ProfileModel profileModel;

  ProfileSuccess(this.profileModel);
  @override
  List<Object> get props => [profileModel];
}

class ProfileError extends ProfileState {
  MainFailures filures;
  ProfileError(this.filures);
  @override
  List<Object> get props => [filures];
}
