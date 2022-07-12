import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:social_media/domain/failures/main_failures.dart';
import 'package:social_media/domain/models/local_models/post_type_model.dart';
import 'package:social_media/domain/models/post_model/post_model.dart';

abstract class PostRepo {
  Future<Either<PostTypeModel?, MainFailures>> pickPost({required String type});
  Future<Either<bool, MainFailures>> uploadPost({required PostModel model});
}
