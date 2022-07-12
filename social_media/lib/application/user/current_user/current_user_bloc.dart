import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/domain/models/profile_feed/profile_feed_model.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';
import 'package:social_media/infrastructure/user_services/user_repository.dart';

part 'current_user_event.dart';
part 'current_user_state.dart';

@injectable
class CurrentUserBloc extends Bloc<CurrentUserEvent, CurrentUserState> {
  final UserRepo _userRepo;
  CurrentUserBloc(this._userRepo) : super(CurrentUserInitial()) {
    on<FetchCurrentuser>((event, emit) async {
      emit(FetchCurrentUserLoading());

      final result = await _userRepo.fetchUser(id: Global.USER_DATA.id);

      final newState = result.fold(
        (data) {
          return FetchCurrentUserSuccess(data);
        },
        (error) {
          return FetchCurrentUserError(error);
        },
      );

      emit(newState);
    });
  }
}
