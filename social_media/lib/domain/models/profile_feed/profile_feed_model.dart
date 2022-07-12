// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:social_media/domain/models/post_model/post_model.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';

class ProfileFeedModel {
  UserModel user;
  List<PostModel> post;

  ProfileFeedModel({required this.user, required this.post});

  set(UserModel model) => user;

  ProfileFeedModel copyWith({
    UserModel? user,
    List<PostModel>? post,
  }) {
    return ProfileFeedModel(
      user: user ?? this.user,
      post: post ?? this.post,
    );
  }
}
