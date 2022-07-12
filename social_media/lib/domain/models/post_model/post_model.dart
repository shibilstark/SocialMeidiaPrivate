// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:social_media/domain/models/comment/comment_model.dart';
import 'package:social_media/domain/models/post_report_model/reports_model.dart';

class PostModel {
  final String postId;
  final String userId;
  final String post;
  final DateTime createdAt;
  final DateTime laseEdit;
  final List<PostComment> comments;
  final List<String> lights;
  final String type;
  final String? videoThumbnail;
  final String? discription;
  final String? tag;
  final List<ReportsModel> reports;

  PostModel({
    required this.postId,
    required this.userId,
    required this.post,
    required this.createdAt,
    required this.laseEdit,
    required this.comments,
    required this.lights,
    required this.type,
    required this.videoThumbnail,
    required this.discription,
    required this.tag,
    required this.reports,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'postId': postId,
      'userId': userId,
      'post': post,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'laseEdit': laseEdit.millisecondsSinceEpoch,
      'comments': comments.map((x) => x.toMap()).toList(),
      'lights': lights,
      'type': type,
      'videoThumbnail': videoThumbnail,
      'discription': discription,
      'tag': tag,
      'reports': reports.map((x) => x.toMap()).toList(),
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      postId: map['postId'] as String,
      userId: map['userId'] as String,
      post: map['post'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      laseEdit: DateTime.fromMillisecondsSinceEpoch(map['laseEdit'] as int),
      comments: List<PostComment>.from(
        (map['comments'] as List<dynamic>).map<PostComment>(
          (x) => PostComment.fromMap(x as Map<String, dynamic>),
        ),
      ),
      lights: List<String>.from((map['lights']) as List<dynamic>),
      type: map['type'] as String,
      videoThumbnail: map['videoThumbnail'] != null
          ? map['videoThumbnail'] as String
          : null,
      discription:
          map['discription'] != null ? map['discription'] as String : null,
      tag: map['tag'] != null ? map['tag'] as String : null,
      reports: List<ReportsModel>.from(
        (map['reports'] as List<dynamic>).map<ReportsModel>(
          (x) => ReportsModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  PostModel copyWith({
    String? postId,
    String? userId,
    String? post,
    DateTime? createdAt,
    DateTime? laseEdit,
    List<PostComment>? comments,
    List<String>? lights,
    String? type,
    String? videoThumbnail,
    String? discription,
    String? tag,
    List<ReportsModel>? reports,
  }) {
    return PostModel(
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      post: post ?? this.post,
      createdAt: createdAt ?? this.createdAt,
      laseEdit: laseEdit ?? this.laseEdit,
      comments: comments ?? this.comments,
      lights: lights ?? this.lights,
      type: type ?? this.type,
      videoThumbnail: videoThumbnail ?? this.videoThumbnail,
      discription: discription ?? this.discription,
      tag: tag ?? this.tag,
      reports: reports ?? this.reports,
    );
  }
}

class PostType {
  static const String image = "image";
  static const String video = "video";
}
