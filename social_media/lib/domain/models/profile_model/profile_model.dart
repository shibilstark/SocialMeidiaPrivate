// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:social_media/domain/models/post_model/post_model.dart';
import 'package:social_media/domain/models/user_model/user_model.dart';

class ProfileModel extends Equatable {
  UserModel user;
  List<PostModel> posts;

  ProfileModel({required this.posts, required this.user});

  @override
  List<Object?> get props => [user, posts];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toMap(),
      'posts': posts.map((x) => x.toMap()).toList(),
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      user: UserModel.fromMap(map['user'] as Map<String, dynamic>),
      posts: List<PostModel>.from(
        (map['posts'] as List<int>).map<PostModel>(
          (x) => PostModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) =>
      ProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ProfileModel copyWith({
    UserModel? user,
    List<PostModel>? posts,
  }) {
    return ProfileModel(
      user: user ?? this.user,
      posts: posts ?? this.posts,
    );
  }
}
