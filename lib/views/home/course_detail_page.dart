import 'package:animation_app/controllers/user_controller.dart';
import 'package:animation_app/models/course_model.dart';
import 'package:animation_app/views/admin/components/chapters_card.dart';
import 'package:animation_app/views/home/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/main_video_card.dart';

class CourseDetailPage extends StatefulWidget {
  final CourseModel course;
  final bool isBought;
  const CourseDetailPage(
      {Key? key, required this.course, this.isBought = false})
      : super(key: key);

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  UserController uc = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        centerTitle: true,
        title: Text(widget.course.title,
            style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          VideoPlayerWidget(
            videoUrl: widget.course.chapters[0].videoUrl,
            onTap: () {
              Get.to(() => VideoScreen(
                    videoUrl: widget.course.chapters[0].videoUrl,
                  ));
            },
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(widget.course.title,
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          ListTile(
            leading: widget.course.uploaderPic != ''
                ? CircleAvatar(
                    backgroundImage: NetworkImage(widget.course.uploaderPic),
                  )
                : CircleAvatar(
                    child: Icon(Icons.person),
                  ),
            title: Text(widget.course.uploadedBy,
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w600)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.star, color: Colors.orange, size: 20),
                Text(
                  widget.course.rating.toString(),
                  style: GoogleFonts.poppins(color: Colors.orange),
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            itemCount: widget.course.chapters.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 24),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Get.to(() => VideoScreen(
                      videoUrl: widget.course.chapters[index].videoUrl));
                },
                child: ChaptersCard(
                  chapter: widget.course.chapters[index],
                  isDetailPage: true,
                  isBoughtCourse: widget.isBought,
                  removeCallback: () {},
                  viewCallback: () async {
                    await uc.updateCompletedValue(widget.course.id);
                  },
                ),
              );
            },
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text('What you will learn:',
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(widget.course.objectives,
                maxLines: 6,
                style: GoogleFonts.poppins(fontWeight: FontWeight.w300)),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text('Description:',
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(widget.course.description,
                maxLines: 6,
                style: GoogleFonts.poppins(fontWeight: FontWeight.w300)),
          ),
          SizedBox(height: 20),
          widget.isBought
              ? SizedBox()
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: ElevatedButton(
                      onPressed: () {
                        Get.find<UserController>().addToCart(widget.course);
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(Get.width, 54),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Add to Cart',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(width: 10),
                          Icon(Icons.shopping_cart, color: Colors.white)
                        ],
                      )),
                ),
        ]),
      ),
    );
  }
}
