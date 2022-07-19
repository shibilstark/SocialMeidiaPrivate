import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/infrastructure/profile/profile_repo.dart';
import 'package:social_media/infrastructure/profile/profile_services.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

@injectable
class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final ProfileRepo _profile_repo;
  EditProfileBloc(this._profile_repo) : super(EditProfileInitial()) {
    on<ChangeCoverPic>((event, emit) async {
      emit(ProfileShowLoadingDialogue());
      final response = await _profile_repo.changeCoverPic(newPic: event.newPic);

      final newState = response.fold(
        (success) {
          return CoverPicChangeSuccess(success);
        },
        (failure) {
          return CoverPicChangeError(failure);
        },
      );

      emit(newState);
    });
    on<ChangeProfilePic>((event, emit) async {
      emit(ProfileShowLoadingDialogue());
      final response =
          await _profile_repo.changeProfilePic(newPic: event.newPic);

      final newState = response.fold(
        (success) {
          return ProfilePicChangeSuccess(success);
        },
        (failure) {
          return ProfilePicChangeError(failure);
        },
      );

      emit(newState);
    });
  }
}
