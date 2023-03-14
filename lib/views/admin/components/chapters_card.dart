// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animation_app/views/admin/components/video_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:animation_app/models/chapter_model.dart';

import '../../../data/constants.dart';

class ChaptersCard extends StatelessWidget {
  final Chapter chapter;
  final VoidCallback removeCallback;
  final bool isDetailPage;
  const ChaptersCard(
      {Key? key,
      required this.chapter,
      required this.removeCallback,
      this.isDetailPage = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 70,
          width: 70,
          child: SmallVideoPlayerCard(
            videoFile: chapter.videoUrl,
            isDetailPage: isDetailPage,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  chapter.title,
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                isDetailPage
                    ? SizedBox()
                    : IconButton(
                        constraints: BoxConstraints(),
                        padding: EdgeInsets.zero,
                        onPressed: removeCallback,
                        icon: Icon(Icons.cancel, color: MyColors.kPrimaryColor))
              ],
            ),
            Text(
              chapter.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                  fontSize: 14, fontWeight: FontWeight.w300),
            )
          ],
        ))
      ],
    );
  }
}
