import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../widgets/loading_dialog.dart';

class FirebaseStorageServices {
  static Future<String> uploadToStorage(
      {required File file,
      required String folderName,
      bool showDialog = true}) async {
    showDialog ? showLoadingDialog() : null;
    try {
      final Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(
            '$folderName/file${DateTime.now().millisecondsSinceEpoch}',
          );

      final UploadTask uploadTask = firebaseStorageRef.putFile(file);

      final TaskSnapshot downloadUrl = await uploadTask;

      String url = await downloadUrl.ref.getDownloadURL();
      showDialog ? hideLoadingDialog() : null;
      return url;
    } on Exception catch (e) {
      showDialog ? hideLoadingDialog() : null;
      Get.snackbar('Error', e.toString());
      return "";
    }
  }

  static Future<String?> uploadVideo(File videoFile) async {
    try {
      showLoadingDialog();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final path = 'courses/$timestamp/${videoFile.path.split('/').last}';
      final ref = FirebaseStorage.instance.ref().child(path);
      final uploadTask = ref.putFile(videoFile);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      hideLoadingDialog();
      return downloadUrl;
    } catch (e) {
      hideLoadingDialog();
      print('Error uploading video: $e');
      throw e;
    }
  }
}
