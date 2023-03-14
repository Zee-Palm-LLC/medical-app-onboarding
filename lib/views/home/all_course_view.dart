import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';



class AllCourseView extends StatelessWidget {
  const AllCourseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text(
          'All Courses',
          style: GoogleFonts.poppins(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
