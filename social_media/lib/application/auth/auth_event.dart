part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {}

class LoggedIn extends AuthEvent {
  final String email;
  final String password;
  LoggedIn({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class CreateAccount extends AuthEvent {
  final UserModel model;
  final String password;
  CreateAccount({required this.model, required this.password});
  @override
  List<Object?> get props => [password, model];
}

class LoggedOut extends AuthEvent {
  @override
  List<Object?> get props => [];
}
