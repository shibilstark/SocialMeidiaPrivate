part of 'others_profile_bloc.dart';

abstract class OthersProfileEvent extends Equatable {
  const OthersProfileEvent();

  @override
  List<Object> get props => [];
}

class GetUserWithId extends OthersProfileEvent {
  final String userId;
  const GetUserWithId({required this.userId});
}
