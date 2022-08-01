import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class NotificationModel {
  DateTime time;
  String notificationId;
  String userId;
  String type;
  NotificationModel({
    required this.time,
    required this.notificationId,
    required this.userId,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'time': time.millisecondsSinceEpoch,
      'notificationId': notificationId,
      'userId': userId,
      'type': type,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      notificationId: map['notificationId'] as String,
      userId: map['userId'] as String,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  NotificationModel copyWith({
    DateTime? time,
    String? notificationId,
    String? userId,
    String? type,
  }) {
    return NotificationModel(
      time: time ?? this.time,
      notificationId: notificationId ?? this.notificationId,
      userId: userId ?? this.userId,
      type: type ?? this.type,
    );
  }
}

class NotificationTypes {
  static String follow = "follow";
  static String post = "post";
  static String message = "message";
  static String admin = "admin";
}
