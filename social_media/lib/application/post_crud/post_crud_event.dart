part of 'post_crud_bloc.dart';

abstract class PostCrudEvent extends Equatable {
  const PostCrudEvent();

  @override
  List<Object> get props => [];
}

class DeletePost extends PostCrudEvent {
  String id;
  DeletePost({required this.id});
}

class EditPostDisc extends PostCrudEvent {
  String postId;
  String? newDisc;

  EditPostDisc({required this.postId, required this.newDisc});
}
