// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:social_media/domain/models/post_model/post_model.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';

class HomeFeedModel {
  PostModel post;
  UserModel user;

  HomeFeedModel({required this.post, required this.user});

  HomeFeedModel copyWith({
    PostModel? post,
    UserModel? user,
  }) {
    return HomeFeedModel(
      post: post ?? this.post,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'post': post.toMap(),
      'user': user.toMap(),
    };
  }

  factory HomeFeedModel.fromMap(Map<String, dynamic> map) {
    return HomeFeedModel(
      post: PostModel.fromMap(map['post'] as Map<String, dynamic>),
      user: UserModel.fromMap(map['user'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeFeedModel.fromJson(String source) =>
      HomeFeedModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
