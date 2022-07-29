part of 'post_actions_bloc.dart';

abstract class PostActionsState extends Equatable {
  const PostActionsState();

  @override
  List<Object> get props => [];
}

class PostActionsInitial extends PostActionsState {}

// like

class PostActionLikeSuccess extends PostActionsState {
  LikeModel likeObj;
  PostActionLikeSuccess(this.likeObj);

  @override
  List<Object> get props => [likeObj];
}

class PostActionLikeError extends PostActionsState {}

// Dislike
class PostActionDisLikeSuccess extends PostActionsState {
  LikeModel likeObj;
  PostActionDisLikeSuccess(this.likeObj);

  @override
  List<Object> get props => [likeObj];
}

class PostActionDisLikError extends PostActionsState {}
