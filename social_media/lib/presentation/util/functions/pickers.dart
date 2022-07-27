import 'dart:io';
import 'dart:math' as math;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

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
        .pickFiles(type: FileType.video, allowMultiple: false);

    if (video == null) {
      return null;
    } else {
      return video.files.single.path;
    }
  }

  static getFileSize(String filepath, int decimals) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    final i = (math.log(bytes) / math.log(1024)).floor();
    return ((bytes / math.pow(1024, i)).toStringAsFixed(decimals)) +
        ' ' +
        suffixes[i];
  }

  static Future<String?> cropImage({required String file}) async {
    final image = await ImageCropper().cropImage(
      sourcePath: file,
      // aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      aspectRatioPresets: [
        CropAspectRatioPreset.ratio5x4,
        CropAspectRatioPreset.ratio16x9,
        CropAspectRatioPreset.ratio4x3
      ],
      compressFormat: ImageCompressFormat.jpg,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: "Crop Image",
          toolbarColor: darkBg,
          toolbarWidgetColor: pureWhite,
        )
      ],
    );

    if (image == null) {
      return null;
    } else {
      return image.path;
    }
  }

  static Future<String?> generateVideoThumbnail(
      {required String videoPath}) async {
    final thumbnail = await VideoThumbnail.thumbnailFile(
      video: videoPath,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.PNG,
      maxHeight: 100,
      quality: 100,
    );

    if (thumbnail == null) {
      final newThumbnail = await _getImageFileFromAssets("assets/dummy/1.webp");
      return newThumbnail.path;
    } else {
      return thumbnail;
    }
  }
}

Future<File> _getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load('assets/$path');

  final file = File('${(await getTemporaryDirectory()).path}/$path');
  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}
