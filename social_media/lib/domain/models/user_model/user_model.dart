// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  String userId;
  String name;
  String email;
  String? coverImage;
  bool isAgreed;
  bool isPrivate;
  bool isBlocked;
  DateTime creationDate;
  String? profileImage;
  List<String> followers;
  List<String> following;
  String? discription;

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
    required this.discription,
    required this.profileImage,
    required this.coverImage,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        userId,
        coverImage,
        profileImage,
        isAgreed,
        isPrivate,
        isBlocked,
        followers,
        following,
        discription,
        creationDate
      ];

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
      'profileImage': profileImage,
      'followers': followers,
      'following': following,
      'discription': discription,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      coverImage:
          map['coverImage'] != null ? map['coverImage'] as String : null,
      isAgreed: map['isAgreed'] as bool,
      isPrivate: map['isPrivate'] as bool,
      isBlocked: map['isBlocked'] as bool,
      creationDate:
          DateTime.fromMillisecondsSinceEpoch(map['creationDate'] as int),
      profileImage:
          map['profileImage'] != null ? map['profileImage'] as String : null,
      followers: List<String>.from((map['followers']) as List<dynamic>),
      following: List<String>.from((map['following']) as List<dynamic>),
      discription:
          map['discription'] != null ? map['discription'] as String : null,
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
    String? profileImage,
    List<String>? followers,
    List<String>? following,
    String? discription,
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
      profileImage: profileImage ?? this.profileImage,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      discription: discription ?? this.discription,
    );
  }
}
