import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/models/profile_model/profile_model.dart';
import 'package:social_media/infrastructure/profile/profile_repo.dart';

part 'others_profile_event.dart';
part 'others_profile_state.dart';

// OthersProfileState _newState = OthersProfileLoading();

@injectable
class OthersProfileBloc extends Bloc<OthersProfileEvent, OthersProfileState> {
  final ProfileRepo _profile_repo;
  OthersProfileBloc(this._profile_repo) : super(OthersProfileInitial()) {
    on<GetUserWithId>((event, emit) async {
      // if (_newState is OthersProfileLoading) {

      // }
      emit(OthersProfileLoading());
      // if(_newState is OthersProfileSuccess ){

      //   if((_newState as OthersProfileSuccess).profileModel.user.userId == event.userId){

      //   }
      // }

      final response = await _profile_repo.getUserWithId(userId: event.userId);

      final _newState = response.fold(
        (success) {
          return OthersProfileSuccess(success);
        },
        (failure) {
          return OthersProfileError(failure);
        },
      );

      emit(_newState);
    });
  }
}
