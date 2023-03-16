import 'dart:io';

import 'package:animation_app/controllers/admin_controller.dart';
import 'package:animation_app/data/constants.dart';
import 'package:animation_app/models/category_model.dart';
import 'package:animation_app/services/firestorage_services.dart';
import 'package:animation_app/views/intro/components/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/image_picker_dialog.dart';
import '../auth/components/custom_textfield.dart';

class AddCategoryView extends StatefulWidget {
  const AddCategoryView({Key? key}) : super(key: key);

  @override
  State<AddCategoryView> createState() => _AddCategoryViewState();
}

class _AddCategoryViewState extends State<AddCategoryView> {
  File? categoryIcon;
  final _categoryName = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AdminController ac = Get.put(AdminController());
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
            icon: Icon(Icons.arrow_back, color: Colors.black)),
        centerTitle: true,
        title: Text(
          'Add Category',
          style: GoogleFonts.poppins(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  ImagePickerDialogBox.pickSingleImage((file) {
                    setState(() {
                      categoryIcon = file;
                    });
                  });
                },
                child: Center(
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: MyColors.kPrimaryColor),
                    ),
                    child: categoryIcon == null
                        ? Icon(
                            Icons.add,
                            color: MyColors.kPrimaryColor,
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.file(
                              categoryIcon!,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text("Category Name",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              CustomTextField(
                isPassword: false,
                controller: _categoryName,
                maxLines: 1,
                hintText: 'Course Objectives',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Objective is Required';
                  }
                },
              ),
              const Spacer(),
              PrimaryButton(
                  text: 'Add Category',
                  onTap: () async {
                    if (_formKey.currentState!.validate() ||
                        categoryIcon != null) {
                      ac.addCategory(CategoryModel(
                          image: await FirebaseStorageServices.uploadToStorage(
                              file: categoryIcon!, folderName: 'category'),
                          id: '',
                          totalCourses: 0,
                          category: _categoryName.text.trim()));
                    }
                  }),
              SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
