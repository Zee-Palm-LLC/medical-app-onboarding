import 'package:animation_app/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/user_model.dart';
import '../home/components/custom_animated_text.dart';
import 'add_category.dart';
import 'upload_course.dart';

class AdminHomePage extends StatelessWidget {
  UserController uc = Get.find<UserController>();

  AdminHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            ZoomDrawer.of(context)!.open();
          },
          icon: const Icon(Icons.menu, color: Colors.black),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back!',
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            Obx(() {
              UserModel user = uc.user!;
              return CustomAnimatedText(
                name: user.fullName ?? '',
              );
            })
          ],
        ),
        actions: [
          Obx(() {
            UserModel user = uc.user!;
            return user.profilePic != ''
                ? CircleAvatar(backgroundImage: NetworkImage(user.profilePic!))
                : CircleAvatar(
                    backgroundColor: Colors.grey.withOpacity(0.4),
                    child: const Icon(Icons.person),
                  );
          }),
          const SizedBox(width: 10)
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    Get.to(() => AdminCourseUploadView());
                  },
                  child: Container(
                    height: 150,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red.withOpacity(0.5)),
                    child: Text(
                      "Add Course",
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 18),
                    ),
                  ),
                )),
                SizedBox(width: 20),
                Expanded(
                    child: Container(
                  height: 150,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue.withOpacity(0.5)),
                  child: Text(
                    "Your Course",
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 18),
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    Get.to(() => AddCategoryView());
                  },
                  child: Container(
                    height: 150,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green.withOpacity(0.5)),
                    child: Text(
                      "Add Category",
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 18),
                    ),
                  ),
                )),
                SizedBox(width: 20),
                Expanded(child: Container()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
