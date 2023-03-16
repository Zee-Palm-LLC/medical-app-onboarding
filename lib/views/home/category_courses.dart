// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animate_do/animate_do.dart';
import 'package:animation_app/models/course_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/user_controller.dart';
import '../../models/category_model.dart';
import 'course_detail_page.dart';

class CategoryCourseView extends StatelessWidget {
  final CategoryModel category;
  final uc = Get.find<UserController>();
  CategoryCourseView({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text(category.category,
            style: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w600)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text("${category.category} Courses",
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 20),
            StreamBuilder<List<CourseModel>>(
                stream: uc.getCoursesByCategory(category.id),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: Text("No Data"));
                  }
                  final courses = snapshot.data!;
                  print(courses);
                  return GridView.builder(
                    itemCount: courses.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5),
                    itemBuilder: (BuildContext context, int index) {
                      return FadeInUp(
                          delay: Duration(milliseconds: index * 50),
                          duration: Duration(milliseconds: (index * 50) + 800),
                          child: InkWell(
                            onTap: (){
                              Get.to(()=>CourseDetailPage(
                                course: courses[index],
                                isBought: false,
                              ));
                            },
                            child: Card(
                              elevation: 5,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 110,
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  courses[index].thumbnail),
                                                  fit: BoxFit.cover
                                                  )),
                                    ),
                                    const Spacer(),
                                    Text(courses[index].title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300))
                                  ],
                                ),
                              ),
                            ),
                          ));
                    },
                  );
                })
          ],
        ),
      ),
    );
  }
}
