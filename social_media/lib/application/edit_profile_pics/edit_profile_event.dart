part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => [];
}

class ChangeCoverPic extends EditProfileEvent {
  final String? newPic;
  ChangeCoverPic(this.newPic);
}

class ChangeProfilePic extends EditProfileEvent {
  final String? newPic;
  ChangeProfilePic(this.newPic);
}
