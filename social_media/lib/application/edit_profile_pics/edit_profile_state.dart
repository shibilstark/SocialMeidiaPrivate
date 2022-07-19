part of 'edit_profile_bloc.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object> get props => [];
}

class EditProfileInitial extends EditProfileState {}

class ProfileShowLoadingDialogue extends EditProfileState {}

// Change Profile Picture
class ProfilePicChangeSuccess extends EditProfileState {
  String? newProfilePic;
  ProfilePicChangeSuccess(this.newProfilePic);
}

class ProfilePicChangeError extends EditProfileState {
  MainFailures failure;
  ProfilePicChangeError(this.failure);
}

// Change Cover Picture
class CoverPicChangeSuccess extends EditProfileState {
  String? newCoverPic;
  CoverPicChangeSuccess(this.newCoverPic);
}

class CoverPicChangeError extends EditProfileState {
  MainFailures failure;
  CoverPicChangeError(this.failure);
}

// Change Name And Disc

class NAmeAndDiscChangeSuccess extends EditProfileState {
  NameAndDisc obj;
  NAmeAndDiscChangeSuccess(this.obj);
}

class NAmeAndDiscChangeError extends EditProfileState {
  MainFailures failure;
  NAmeAndDiscChangeError(this.failure);
}
