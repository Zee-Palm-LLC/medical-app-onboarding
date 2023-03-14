import 'package:animation_app/data/constants.dart';
import 'package:flutter/material.dart';

class VideoPickerCard extends StatelessWidget {
  final VoidCallback onTap;
  const VideoPickerCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: MyColors.kPrimaryColor,
            )),
        child: Icon(
          Icons.add,
          color: MyColors.kPrimaryColor,
        ),
      ),
    );
  }
}
