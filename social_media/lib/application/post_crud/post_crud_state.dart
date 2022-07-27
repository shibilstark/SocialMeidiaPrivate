part of 'post_crud_bloc.dart';

abstract class PostCrudState extends Equatable {
  const PostCrudState();

  @override
  List<Object> get props => [];
}

class PostCrudInitial extends PostCrudState {}

// Delete Post
class DeletePostProcessing extends PostCrudState {}

class DeletePostSuccess extends PostCrudState {
  String id;

  DeletePostSuccess(this.id);
  @override
  List<Object> get props => [id];
}

class DeletePostError extends PostCrudState {
  MainFailures filures;
  DeletePostError(this.filures);
  @override
  List<Object> get props => [filures];
}

// Edit Post Discription

class EditPostDiscProcessing extends PostCrudState {}

class EditPostDiscSuccess extends PostCrudState {
  String? newDisc;
  String? postId;
  EditPostDiscSuccess(this.newDisc, this.postId);
}

class EditPostDiscError extends PostCrudState {
  MainFailures filures;
  EditPostDiscError(this.filures);
  @override
  List<Object> get props => [filures];
}
