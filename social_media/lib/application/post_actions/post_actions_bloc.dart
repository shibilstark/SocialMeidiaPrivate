import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:social_media/domain/models/local_models/like_model.dart';
import 'package:social_media/infrastructure/post/post_repo.dart';
part 'post_actions_event.dart';
part 'post_actions_state.dart';

@injectable
class PostActionsBloc extends Bloc<PostActionsEvent, PostActionsState> {
  final PostRepo _postRepo;
  PostActionsBloc(this._postRepo) : super(PostActionsInitial()) {
    on<LikeThePost>((event, emit) async {
      final respose = await _postRepo.like(event.likeObj);

      respose.fold((success) {
        emit(success);
      }, (err) {
        emit(PostActionLikeError());
      });
    });

    // on<DisLikeThePost>((event, emit) async {
    //   try {
    //     final post = FirebaseFirestore.instance
    //         .collection(Collections.post)
    //         .doc(event.likeObj.postId);

    //     final postInfo = await post.get();

    //     final lights = await postInfo.get('lights') as List<dynamic>;

    //     log(lights.join("\n"));

    //     emit(PostActionLikeSuccess(LikeModel(
    //         postId: event.likeObj.postId, likerId: event.likeObj.likerId)));
    //   } on FirebaseException catch (e) {
    //     log(e.toString());
    //     emit(PostActionLikeError(
    //         // MainFailures(
    //         //   error: firebaseCodeFix(e.code),
    //         //   failureType: MyAppFilures.firebaseFailure)
    //         ));
    //   } catch (e) {
    //     log(e.toString());
    //     emit(PostActionLikeError(
    //         // MainFailures(
    //         //   error: firebaseCodeFix(e.code),
    //         //   failureType: MyAppFilures.firebaseFailure)
    //         ));
    //   }
    // });
  }
}
