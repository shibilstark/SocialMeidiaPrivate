import 'dart:collection';
import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media/domain/models/local_models/like_model.dart';

part 'post_actions_event.dart';
part 'post_actions_state.dart';

class PostActionsBloc extends Bloc<PostActionsEvent, PostActionsState> {
  PostActionsBloc() : super(PostActionsInitial()) {
    on<PostActionsEvent>((event, emit) {});
  }
}
