part of 'post_actions_bloc.dart';

abstract class PostActionsEvent extends Equatable {
  const PostActionsEvent();

  @override
  List<Object> get props => [];
}

class LikeThePost extends PostActionsEvent {
  LikeModel likeObj;
  LikeThePost(this.likeObj);

  @override
  List<Object> get props => [likeObj];
}

class DisLikeThePost extends PostActionsEvent {
  LikeModel likeObj;
  DisLikeThePost(this.likeObj);

  @override
  List<Object> get props => [likeObj];
}
