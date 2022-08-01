// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';
// part 'main_failures.freezed.dart';

// @freezed
// class MainFaulures with _$MainFaulures {
//   const factory MainFaulures.userNotFound() = _UserNotFound;
//   const factory MainFaulures.wrongPassword() = _WrongPassword;
//   const factory MainFaulures.clientFalure() = _ClientFalure;
//   factory MainFaulures.firebaseException({required FirebaseException err}) =
//       _FirebaseExceprion;
// }

import 'package:equatable/equatable.dart';

class MyAppFilures {
  static String clientFailure = clientFailure;
  static String firebaseFailure = firebaseFailure;
  static String userNotFound = userNotFound;
  static String emailOrPasswordFailure = emailOrPasswordFailure;
  static String none = none;
}

class MainFailures extends Equatable {
  final String failureType;
  final String error;

  const MainFailures({required this.failureType, required this.error});

  @override
  List<Object?> get props => [failureType, error];
}

// class MyExceptions implements Exception {
//   final
// }

class ClientFailure extends MainFailures implements Exception {
  final String err;

  ClientFailure({required this.err})
      : super(error: err, failureType: MyAppFilures.clientFailure);

  @override
  List<Object?> get props => [err];
}

class FirebaseFailure extends MainFailures implements Exception {
  final String err;
  FirebaseFailure({required this.err})
      : super(error: err, failureType: MyAppFilures.firebaseFailure);

  @override
  List<Object?> get props => [err];
}

class UserNotFound extends MainFailures implements Exception {
  final String err;
  UserNotFound({required this.err})
      : super(error: err, failureType: MyAppFilures.userNotFound);

  @override
  List<Object?> get props => [err];
}

class WrongEmailOrPassword extends MainFailures implements Exception {
  final String err;
  WrongEmailOrPassword({required this.err})
      : super(error: err, failureType: MyAppFilures.emailOrPasswordFailure);

  @override
  List<Object?> get props => [err];
}

// class UnknownError extends Equatable implements UnimplementedError {
//   @override
//   String? get message => throw ClientFailure(
//         err: "Something went wrong",
//       );

//   @override
//   StackTrace? get stackTrace => throw ClientFailure(
//         err: "Something went wrong",
//       );

//   @override
//   List<Object?> get props => [message, stackTrace];
// }
