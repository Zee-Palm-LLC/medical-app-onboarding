import 'dart:io';

import 'package:animation_app/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:animation_app/models/user_model.dart';
import 'package:animation_app/views/auth/components/custom_textfield.dart';
import 'package:animation_app/views/intro/components/custom_buttons.dart';

import '../../services/firestorage_services.dart';
import '../../widgets/image_picker_dialog.dart';
import 'components/image_card.dart';

class EditProfileScreen extends StatefulWidget {
  UserModel user;
  EditProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _emailController = TextEditingController();
  final _fullNameController = TextEditingController();
  File? image;
  UserController uc = Get.find<UserController>();

  @override
  void initState() {
    _emailController.text = widget.user.email!;
    _fullNameController.text = widget.user.fullName!;
    print(widget.user.fullName);
    super.initState();
  }

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
          'Edit Profile',
          style: GoogleFonts.poppins(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
                child: ProfileImageCard(
              isEdit: true,
              image: widget.user.profilePic,
              fileImage: image,
              onEditCallback: () {
                ImagePickerDialogBox.pickSingleImage((file) {
                  setState(() {
                    image = file;
                  });
                });
              },
            )),
            const SizedBox(height: 30),
            Text(
              "Email",
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            CustomTextField(
              isPassword: false,
              controller: _emailController,
              hintText: 'Email Address',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Text(
              "Full Name",
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            CustomTextField(
              isPassword: false,
              controller: _fullNameController,
              hintText: 'Full Name',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your full name';
                }
                return null;
              },
            ),
            const Spacer(),
            PrimaryButton(
              onTap: () async {
                uc.updateUserInfo(
                    userModel: UserModel(
                        id: widget.user.id,
                        email: _emailController.text.trim(),
                        fullName: _fullNameController.text.trim(),
                        userType: widget.user.userType,
                        profilePic: image != null
                            ? await FirebaseStorageServices.uploadToStorage(
                                file: image!, folderName: 'Users')
                            : widget.user.profilePic != ''
                                ? widget.user.profilePic
                                : ''));
              },
              text: 'Update',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
