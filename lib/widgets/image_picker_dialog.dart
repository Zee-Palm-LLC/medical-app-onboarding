import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../services/image_picker_services.dart';

class ImagePickDialog extends StatelessWidget {
  final VoidCallback cameraCallback;
  final VoidCallback galleryCallback;
  const ImagePickDialog({
    Key? key,
    required this.cameraCallback,
    required this.galleryCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select Image",
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: cameraCallback,
              child: Row(
                children: [
                  const Icon(Icons.camera_alt),
                  const SizedBox(width: 5),
                  Text(
                    "Select from Camera",
                    style: GoogleFonts.poppins(),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: galleryCallback,
              child: Row(
                children: [
                  const Icon(Icons.photo),
                  const SizedBox(width: 5),
                  Text(
                    "Select from Gallery",
                     style: GoogleFonts.poppins(),
                  )
                ],
              ),
            )
          ]),
    );
  }
}

class ImagePickerDialogBox {
  static Future<File?> pickSingleImage(Function(File) callBack) async {
    File? pickedFile;
    Get.dialog(ImagePickDialog(
      cameraCallback: () async {
        Get.back();
        0.5.seconds.delay().then((value) async {
          pickedFile = await ImagePickerServices().getImageFromCamera();
          if (pickedFile != null) {
            callBack(pickedFile!);
            return pickedFile;
          }
        });
      },
      galleryCallback: () async {
        Get.back();
        0.5.seconds.delay().then((value) async {
          pickedFile = await ImagePickerServices().getImageFromGallery();
          if (pickedFile != null) {
            callBack(pickedFile!);

            return pickedFile;
          }
        });
      },
    ));
    return pickedFile;
  }
}
