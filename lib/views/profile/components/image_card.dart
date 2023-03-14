import 'dart:io';

import 'package:animation_app/data/constants.dart';
import 'package:flutter/material.dart';

class ProfileImageCard extends StatelessWidget {
  final bool isEdit;
  final String? image;
  final VoidCallback? onEditCallback;
  final File? fileImage;
  const ProfileImageCard(
      {super.key,
      this.isEdit = false,
      this.fileImage,
      required this.image,
      this.onEditCallback});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          fileImage == null
              ? image == ''
                  ? Container(
                      height: 150,
                      width: 150,
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage('assets/profileIcon.png'),
                              fit: BoxFit.cover)),
                    )
                  : Container(
                      height: 150,
                      width: 150,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(image!), fit: BoxFit.cover)),
                    )
              : Container(
                  height: 150,
                  width: 150,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: FileImage(fileImage!), fit: BoxFit.cover)),
                ),
          isEdit
              ? Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  color: MyColors.kPrimaryColor,
                  child: IconButton(
                      onPressed: onEditCallback,
                      icon: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      )),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
