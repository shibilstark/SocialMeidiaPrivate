// ignore_for_file: must_be_immutable

part of 'auth_bloc.dart';

class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthStateInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthStateLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthStateAccountCreateSuccess extends AuthState {
  final UserModel _userModel;
  AuthStateAccountCreateSuccess(this._userModel);
  UserModel get user => _userModel;

  @override
  List<Object?> get props => [_userModel];
}

class AuthStateAccountCreateError extends AuthState {
  final MainFailures _error;

  AuthStateAccountCreateError(this._error);

  MainFailures get err => _error;

  @override
  List<Object?> get props => [_error];
}

class AuthStateLogginSuccess extends AuthState {
  final UserModel userModel;
  AuthStateLogginSuccess(this.userModel);
  UserModel get user => userModel;

  @override
  List<Object?> get props => [userModel];
}

class AuthStateLogginError extends AuthState {
  final MainFailures error;

  AuthStateLogginError(this.error);

  MainFailures get failure => error;

  @override
  List<Object?> get props => [error];
}
