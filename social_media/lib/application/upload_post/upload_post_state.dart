part of 'upload_post_bloc.dart';

abstract class UploadPostState extends Equatable {
  const UploadPostState();

  @override
  List<Object> get props => [];
}

class UploadPostInitial extends UploadPostState {}

class UploadPostLoading extends UploadPostState {}

class UploadingPost extends UploadPostState {
  Stream<TaskSnapshot> uploadStream;
  UploadingPost(this.uploadStream);
}

class UploadPostSuccess extends UploadPostState {
  PostModel postModel;
  UploadPostSuccess(this.postModel);
}

class UploadPostError extends UploadPostState {
  MainFailures failure;

  UploadPostError(this.failure);
}
