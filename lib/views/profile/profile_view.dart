import 'package:animation_app/controllers/auth_controller.dart';
import 'package:animation_app/controllers/user_controller.dart';
import 'package:animation_app/models/user_model.dart';
import 'package:animation_app/views/profile/change_password_view.dart';
import 'package:animation_app/views/profile/edit_profile_screen.dart';
import 'package:animation_app/widgets/logout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/custom_profile_tile.dart';
import 'components/image_card.dart';

class ProfileView extends StatelessWidget {
  AuthController ac = Get.find<AuthController>();
  UserController uc = Get.find<UserController>();
  ProfileView({super.key});

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
          'Profile',
          style: GoogleFonts.poppins(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: Obx(() {
        UserModel? user = uc.user;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Center(
                  child: ProfileImageCard(
                image: user.profilePic,
              )),
              const SizedBox(height: 30),
              CustomProfileTile(
                onTap: () {
                  Get.to(() => EditProfileScreen(
                        user: user,
                      ));
                },
                text: 'Edit Profile',
                icon: Icons.person,
              ),
              const SizedBox(height: 10),
              CustomProfileTile(
                onTap: () {
                  Get.to(() => ChangePasswordView());
                },
                text: 'Change Password',
                icon: Icons.lock,
              ),
              const SizedBox(height: 10),
              CustomProfileTile(
                onTap: () {
                  Get.dialog(LogoutDialog(
                    onLogoutCallback: () async {
                      Get.back();
                      await ac.signOut();
                      Get.back();
                    },
                  ));
                },
                text: 'Logout',
                icon: Icons.logout,
              ),
            ],
          ),
        );
      }),
    );
  }
}
