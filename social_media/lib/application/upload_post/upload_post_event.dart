part of 'upload_post_bloc.dart';

abstract class UploadPostEvent extends Equatable {
  const UploadPostEvent();

  @override
  List<Object> get props => [];
}

class UplaodNewMediaPost extends UploadPostEvent {
  PostModel postModel;
  UplaodNewMediaPost({required this.postModel});
}

class UplaodNewTextPost extends UploadPostEvent {
  PostModel postModel;
  UplaodNewTextPost({required this.postModel});
}
