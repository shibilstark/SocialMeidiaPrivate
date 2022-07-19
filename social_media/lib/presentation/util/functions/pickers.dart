import 'package:file_picker/file_picker.dart';

class Utility {
  static Future<String?> pickImage() async {
    final image = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);

    if (image == null) {
      return null;
    } else {
      return image.files.single.path;
    }
  }

  static Future<String?> pickVideo() async {
    final video = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);

    if (video == null) {
      return null;
    } else {
      return video.files.single.path;
    }
  }
}
