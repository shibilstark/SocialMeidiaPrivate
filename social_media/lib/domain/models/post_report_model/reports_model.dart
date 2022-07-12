import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ReportsModel {
  final String postOwner;
  final String post;
  final String reporter;
  final String reportType;

  ReportsModel({
    required this.postOwner,
    required this.post,
    required this.reporter,
    required this.reportType,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'postOwner': postOwner,
      'post': post,
      'reporter': reporter,
      'reportType': reportType,
    };
  }

  factory ReportsModel.fromMap(Map<String, dynamic> map) {
    return ReportsModel(
      postOwner: map['postOwner'] as String,
      post: map['post'] as String,
      reporter: map['reporter'] as String,
      reportType: map['reportType'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportsModel.fromJson(String source) =>
      ReportsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
