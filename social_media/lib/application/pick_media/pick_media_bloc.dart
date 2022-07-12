import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/models/local_models/post_type_model.dart';
import 'package:social_media/infrastructure/post/post_repo.dart';

part 'pick_media_event.dart';
part 'pick_media_state.dart';

@injectable
class PickMediaBloc extends Bloc<PickMediaEvent, PickMediaState> {
  final PostRepo _postRepo;
  PickMediaBloc(this._postRepo) : super(PickMediaInitial()) {
    on<PickMedia>((event, emit) async {
      emit(PickMediaLoading());
      final result = await _postRepo.pickPost(type: event.type);

      final newState = result.fold(
        (post) {
          return PickMediaSuccess(postTypeModel: post!);
        },
        (failure) {
          return PickMediaError(failure: failure);
        },
      );

      emit(newState);
    });
  }
}
