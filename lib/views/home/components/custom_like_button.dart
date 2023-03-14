import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class CustomHeartIcon extends StatelessWidget {
  final double? iconSize;
  final Future<bool?> Function(bool)? onTap;
  final bool isFavorite;
  const CustomHeartIcon(
      {super.key, this.iconSize, this.onTap, required this.isFavorite});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: 35,
      child: LikeButton(
        size: 30,
        onTap: onTap,
        circleColor: const CircleColor(start: Colors.white, end: Colors.red),
        bubblesColor: const BubblesColor(
          dotPrimaryColor: Colors.red,
          dotSecondaryColor: Colors.red,
        ),
        isLiked: isFavorite,
        likeBuilder: (bool isLiked) {
          return Icon(
            Icons.favorite,
            color: isLiked ? Colors.red : Colors.grey.withOpacity(0.4),
            size: iconSize ?? 30,
          );
        },
      ),
    );
  }
}
