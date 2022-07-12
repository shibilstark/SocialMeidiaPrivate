// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PostComment {
  final String reacterId;
  final String commentText;
  PostComment({required this.reacterId, required this.commentText});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'reacterId': reacterId,
      'commentText': commentText,
    };
  }

  factory PostComment.fromMap(Map<String, dynamic> map) {
    return PostComment(
      reacterId: map['reacterId'] as String,
      commentText: map['commentText'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostComment.fromJson(String source) =>
      PostComment.fromMap(json.decode(source) as Map<String, dynamic>);
}
