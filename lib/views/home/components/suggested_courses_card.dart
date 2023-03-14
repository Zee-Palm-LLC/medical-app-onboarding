import 'package:animate_do/animate_do.dart';
import 'package:animation_app/models/course_model.dart';
import 'package:animation_app/views/home/components/custom_like_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SuggestedCourseCard extends StatelessWidget {
  final CourseModel courses;
  final int index;
  final VoidCallback onTap;
  final Future<bool?> Function(bool)? favoriteCallback;
  final bool isFavorite;
  const SuggestedCourseCard(
      {super.key,
      required this.courses,
      required this.index,
      required this.onTap, this.favoriteCallback, required this.isFavorite});

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      delay: Duration(milliseconds: index * 50),
      duration: Duration(milliseconds: (index * 50) + 800),
      child: InkWell(
        onTap: onTap,
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            height: 170,
            width: 270,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 170,
                  width: double.maxFinite,
                  alignment: Alignment.topRight,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(courses.thumbnail),
                          fit: BoxFit.cover)),
                  child: CustomHeartIcon(
                    isFavorite: isFavorite,
                    onTap: favoriteCallback,
                  ),
                ),
                const SizedBox(height: 5),
                Text(courses.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage(courses.uploaderPic),
                    ),
                    const SizedBox(width: 10),
                    Text(courses.uploadedBy,
                        style: GoogleFonts.poppins(fontSize: 14))
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Text("\$${courses.price}",
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.orange,
                            fontWeight: FontWeight.w600)),
                    const Spacer(),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.orange)),
                        child: Row(
                          children: [
                            const Icon(Icons.star,
                                color: Colors.orange, size: 15),
                            const SizedBox(width: 2),
                            Text('${courses.rating}',
                                style: GoogleFonts.poppins(
                                    fontSize: 12, color: Colors.orange)),
                          ],
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
