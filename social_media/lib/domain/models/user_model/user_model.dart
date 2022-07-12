// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

// part 'user_model.g.dart';

class UserModel {
  String userId;
  String name;
  String email;
  String coverImage;
  bool isAgreed;
  bool isPrivate;
  bool isBlocked;
  DateTime creationDate;
  String profileImage;
  List<String> followers;
  List<String> following;
  List<String> posts;
  String discription;
  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.isAgreed,
    required this.isPrivate,
    required this.isBlocked,
    required this.creationDate,
    required this.followers,
    required this.following,
    required this.posts,
    required this.discription,
    required this.profileImage,
    required this.coverImage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'name': name,
      'email': email,
      'coverImage': coverImage,
      'isAgreed': isAgreed,
      'isPrivate': isPrivate,
      'isBlocked': isBlocked,
      'creationDate': creationDate.millisecondsSinceEpoch,
      'followers': followers,
      'following': following,
      'posts': posts,
      'discription': discription,
      'profileImage': profileImage,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      coverImage: map['coverImage'] as String,
      isAgreed: map['isAgreed'] as bool,
      isPrivate: map['isPrivate'] as bool,
      isBlocked: map['isBlocked'] as bool,
      creationDate:
          DateTime.fromMillisecondsSinceEpoch(map['creationDate'] as int),
      followers: List<String>.from((map['followers']) as List),
      following: List<String>.from((map['following']) as List),
      posts: List<String>.from((map['posts']) as List),
      discription: map['discription'] as String,
      profileImage: map['profileImage'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModel copyWith({
    String? userId,
    String? name,
    String? email,
    String? coverImage,
    bool? isAgreed,
    bool? isPrivate,
    bool? isBlocked,
    DateTime? creationDate,
    List<String>? followers,
    List<String>? following,
    List<String>? posts,
    String? discription,
    String? profileImage,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      coverImage: coverImage ?? this.coverImage,
      isAgreed: isAgreed ?? this.isAgreed,
      isPrivate: isPrivate ?? this.isPrivate,
      isBlocked: isBlocked ?? this.isBlocked,
      creationDate: creationDate ?? this.creationDate,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      posts: posts ?? this.posts,
      discription: discription ?? this.discription,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}

class UmKeys {
  static const String userId = "userId";
  static const String name = "name";
  static const String email = "email";
  static const String coverImage = "coverImage";
  static const String isAgreed = "isAgreed";
  static const String isPrivate = "isPrivate";
  static const String isBlocked = "isBlocked";
  static const String creationDate = "creationDate";
  static const String followers = "followers";
  static const String following = "following";
  static const String posts = "posts";
  static const String discription = "discription";
  static const String profileImage = "profileImage";
}
