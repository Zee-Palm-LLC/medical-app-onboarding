import 'package:animation_app/controllers/auth_controller.dart';
import 'package:animation_app/views/auth/components/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../intro/components/custom_buttons.dart';

class NewPasswordView extends StatelessWidget {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  AuthController ac = Get.find<AuthController>();

  NewPasswordView({super.key});

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
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        centerTitle: true,
        title: Text(
          'Change Password',
          style: GoogleFonts.poppins(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                    text: 'd',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Color(0xffe46b10)),
                    children: [
                      TextSpan(
                        text: 'ev',
                        style: TextStyle(color: Colors.black, fontSize: 30),
                      ),
                      TextSpan(
                        text: 'rnz',
                        style:
                            TextStyle(color: Color(0xffe46b10), fontSize: 30),
                      ),
                    ]),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "New Password",
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            CustomTextField(
              isPassword: true,
              controller: _newPasswordController,
              hintText: 'New Password',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Text(
              "Confirm Password",
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            CustomTextField(
              isPassword: true,
              hintText: 'Confirm Password',
              controller: _confirmPasswordController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            const Spacer(),
            PrimaryButton(
              onTap: () {
                if (_newPasswordController.text ==
                    _confirmPasswordController.text) {
                  ac.changePassword(_newPasswordController.text);
                } else {
                  Get.snackbar('Error', 'Passwords do not match');
                }
              },
              text: 'Change Password',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
