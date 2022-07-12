part of 'current_user_bloc.dart';

abstract class CurrentUserState extends Equatable {
  const CurrentUserState();

  @override
  List<Object> get props => [];
}

//  Initial
class CurrentUserInitial extends CurrentUserState {}

//  Fetching Current User
class FetchCurrentUserLoading extends CurrentUserState {}

class FetchCurrentUserSuccess extends CurrentUserState {
  ProfileFeedModel _data;

  FetchCurrentUserSuccess(this._data);

  ProfileFeedModel get data => _data;
  @override
  List<Object> get props => [_data];
}

class FetchCurrentUserError extends CurrentUserState {
  MainFailures _failure;
  FetchCurrentUserError(this._failure);

  MainFailures get error => _failure;

  @override
  List<Object> get props => [_failure];
}

//
//
//
//
//
//
//
//

