import 'dart:io';

import 'package:animation_app/controllers/admin_controller.dart';
import 'package:animation_app/data/constants.dart';
import 'package:animation_app/data/enums/category_enum.dart';
import 'package:animation_app/models/chapter_model.dart';
import 'package:animation_app/models/course_model.dart';
import 'package:animation_app/services/firestorage_services.dart';
import 'package:animation_app/services/image_picker_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/category_model.dart';
import '../../widgets/image_picker_dialog.dart';
import '../auth/components/custom_textfield.dart';
import '../intro/components/custom_buttons.dart';
import 'components/chapters_card.dart';
import 'components/drop_down.dart';
import 'components/video_card.dart';

class AdminCourseUploadView extends StatefulWidget {
  AdminCourseUploadView({super.key});

  @override
  State<AdminCourseUploadView> createState() => _AdminCourseUploadViewState();
}

class _AdminCourseUploadViewState extends State<AdminCourseUploadView> {
  final _titleController = TextEditingController();
  final _description = TextEditingController();
  final _objectives = TextEditingController();
  final _price = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CategoryModel? selectedCategory = null;
  File? thumbnail;
  List<Chapter> chapters = [];
  final _chapterTitleController = TextEditingController();
  final _chapterDescription = TextEditingController();
  File? chapterVideo;

  AdminController ac = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        centerTitle: true,
        title: Text(
          'Add Course',
          style: GoogleFonts.poppins(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text("Title",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              CustomTextField(
                isPassword: false,
                controller: _titleController,
                hintText: 'Course title',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Title is Required';
                  }
                },
              ),
              SizedBox(height: 20),
              Text("Description",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              CustomTextField(
                isPassword: false,
                controller: _description,
                maxLines: 6,
                hintText: 'Course Description',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Description is Required';
                  }
                },
              ),
              SizedBox(height: 20),
              Text("Objectives",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              CustomTextField(
                isPassword: false,
                controller: _objectives,
                maxLines: 6,
                hintText: 'Course Objectives',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Objective is Required';
                  }
                },
              ),
              SizedBox(height: 20),
              Text("Category",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              MyDropdown(
                    categories: ac.categories,
                    selectedCategory: selectedCategory??selectedCategory,
                    onCategoryChanged: (category) {
                      selectedCategory = category;
                      setState(() {});
                    },
                  ),
              SizedBox(height: 20),
              Text("Thumbnail",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              GestureDetector(
                onTap: () {
                  ImagePickerDialogBox.pickSingleImage((file) {
                    setState(() {
                      thumbnail = file;
                    });
                  });
                },
                child: Container(
                  height: 120,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: MyColors.kPrimaryColor),
                  ),
                  child: thumbnail == null
                      ? Icon(
                          Icons.add,
                          color: MyColors.kPrimaryColor,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.file(
                            thumbnail!,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
              SizedBox(height: 20),
              Text("Price",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              CustomTextField(
                isPassword: false,
                controller: _price,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLines: 1,
                keyboardType: TextInputType.number,
                hintText: 'Price is USD',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Price is Required';
                  }
                },
              ),
              SizedBox(height: 20),
              ListView.separated(
                  itemCount: chapters.length,
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    return ChaptersCard(
                      isBoughtCourse: false,
                      viewCallback: (){},
                      chapter: chapters[index],
                      removeCallback: () {
                        setState(() {
                          setState(() {
                            chapters
                                .removeWhere((item) => item == chapters[index]);
                          });
                        });
                        print(chapters.length);
                      },
                    );
                  }),
              SizedBox(height: 20),
              Text("ADD CHAPTERS",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, fontSize: 22)),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Chapter Title",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                  CustomTextField(
                    isPassword: false,
                    controller: _chapterTitleController,
                    hintText: 'Chapter title',
                  ),
                  SizedBox(height: 20),
                  Text("Chapter Description",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                  CustomTextField(
                    isPassword: false,
                    controller: _chapterDescription,
                    maxLines: 4,
                    hintText: 'Chapter Description',
                  ),
                  SizedBox(height: 20),
                  Text("Chapter Video",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                  Container(
                    height: 200,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: MyColors.kPrimaryColor)),
                    child: chapterVideo != null
                        ? VideoPlayerCard(
                            videoFile: chapterVideo!,
                          )
                        : IconButton(
                            onPressed: () async {
                              chapterVideo = await VideoPicker.pickVideo();
                              setState(() {});
                            },
                            icon: Icon(Icons.add,
                                color: MyColors.kPrimaryColor, size: 40)),
                  ),
                  SizedBox(height: 20),
                  Center(
                      child: ElevatedButton(
                          onPressed: _addLesson, child: Text("Add Chapters")))
                ],
              ),
              SizedBox(height: 20),
              PrimaryButton(
                onTap: () async {
                    if (_formKey.currentState != null &&
                        ((_formKey.currentState!.validate() &&
                                chapters.isNotEmpty) ||
                            thumbnail != null || selectedCategory!=null)) {
                      ac.addCourse(CourseModel(
                          id: '',
                          title: _titleController.text,
                          description: _description.text,
                          uploadedBy: '',
                          uploaderPic: '',
                          ownerId: '',
                           category: selectedCategory!,
                          thumbnail:
                              await FirebaseStorageServices.uploadToStorage(
                                  file: thumbnail!, folderName: 'Thumbnails'),
                          price: double.parse(_price.text),
                          objectives: _objectives.text,
                          rating: 0.0,
                          chapters: chapters),
                          selectedCategory!.id
                          );
                    } else if (chapters.isEmpty) {
                      Get.snackbar('Error', 'You must add atleat one Chapter');
                    } else if (thumbnail == null) {
                      Get.snackbar('Error', 'Please add a Thumbnail');
                    } else if(selectedCategory == null){
                      Get.snackbar('Error', 'Please Select a Category');
                    }else {
                      return;
                    }
                },
                text: 'Upload Course',
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _addLesson() async {
    String title = _chapterTitleController.text;
    String description = _chapterDescription.text;

    if (chapterVideo == null) {
      Get.snackbar('Error', 'Please insert a video to add course');
      return;
    }

    String? chapterVideoUrl =
        await FirebaseStorageServices.uploadVideo(chapterVideo!);

    if (chapterVideoUrl == null) {
      Get.snackbar('Error', 'Failed to upload video');
      return;
    }

    if (title != '' || description != '') {
      Chapter chapter = Chapter(
        id: '',
        title: title,
        description: description,
        videoUrl: chapterVideoUrl,
      );
      setState(() {
        chapters.add(chapter);
        _chapterTitleController.clear();
        _chapterDescription.clear();
        chapterVideo = null;
      });
    } else {
      Get.snackbar('Error', 'Please enter a title and description');
    }
  }
}
