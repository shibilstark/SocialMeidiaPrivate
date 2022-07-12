import 'package:file_picker/file_picker.dart';
import 'package:social_media/domain/models/post_model/post_model.dart';

class PostTypeModel {
  final String file;
  final String type;
  final String? thumbnail;

  PostTypeModel(
      {required this.file, required this.type, required this.thumbnail});
}
