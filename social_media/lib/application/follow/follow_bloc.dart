import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/infrastructure/profile/profile_repo.dart';
part 'follow_event.dart';
part 'follow_state.dart';

@injectable
class FollowBloc extends Bloc<FollowEvent, FollowState> {
  final ProfileRepo _profile_repo;
  FollowBloc(this._profile_repo) : super(FollowInitial()) {
    on<Follow>((event, emit) async {
      final response = await _profile_repo.follow(profileId: event.profileId);

      final newState = response.fold(
        (success) {
          return FollowSuccess(success);
        },
        (failure) {
          return FollowError(failure);
        },
      );

      emit(newState);
    });
    on<UnFollow>((event, emit) async {
      final response = await _profile_repo.unfollow(profileId: event.profileId);

      final newState = response.fold(
        (success) {
          return UnFollowSuccess(success);
        },
        (failure) {
          return UnFollowError(failure);
        },
      );

      emit(newState);
    });
  }
}
