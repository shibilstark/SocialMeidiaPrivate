import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/infrastructure/profile/profile_repo.dart';

part 'post_crud_event.dart';
part 'post_crud_state.dart';

@injectable
class PostCrudBloc extends Bloc<PostCrudEvent, PostCrudState> {
  final ProfileRepo _profile_repo;
  PostCrudBloc(this._profile_repo) : super(PostCrudInitial()) {
    on<DeletePost>((event, emit) async {
      emit(DeletePostProcessing());

      final response = await _profile_repo.deletePost(event.id);

      final newState = response.fold(
        (success) {
          return DeletePostSuccess(success);
        },
        (failure) {
          return DeletePostError(failure);
        },
      );

      emit(newState);
    });
    on<EditPostDisc>((event, emit) async {
      emit(DeletePostProcessing());

      if (event.newDisc == null) {
        log("null");
      } else {
        log(event.newDisc!);
      }

      final response = await _profile_repo.editPostDiscrption(
          newDisc: event.newDisc, postId: event.postId);

      final newState = response.fold(
        (success) {
          return EditPostDiscSuccess(success, event.postId);
        },
        (failure) {
          return EditPostDiscError(failure);
        },
      );

      emit(newState);
    });
  }
}
