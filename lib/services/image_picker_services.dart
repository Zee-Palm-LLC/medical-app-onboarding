import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerServices {
  File? image;
  final _picker = ImagePicker();

  Future<File?> getImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      return image;
    } else {
      Get.snackbar("No Image", "Image not Selected");
      return null;
    }
  }

  Future<File?> getImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      return image;
    } else {
      Get.snackbar("No Image", "Image not Selected");
      return null;
    }
  }
}

class VideoPicker {
  static Future<File?> pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: false,
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      File videoFile = File(file.path!);
      return videoFile;
    } else {
      Get.snackbar('Video not selected!',
          'Please select a video so you can enter a course');
      return null;
    }
  }
}
