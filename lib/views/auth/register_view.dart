import 'package:animation_app/controllers/auth_controller.dart';
import 'package:animation_app/data/constants.dart';
import 'package:animation_app/data/enums/user_type.dart';
import 'package:animation_app/views/intro/components/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/bezier_card.dart';
import 'components/custom_textfield.dart';
import 'login_view.dart';

class SignUpView extends StatefulWidget {
  SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _emailController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthController ac = Get.find<AuthController>();
  UserType userType = UserType.student;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back, color: Colors.black)),
      ),
      body: SizedBox(
        height: Get.height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -Get.height * .15,
              right: -Get.width * .4,
              child: const BezierContainer(),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: Get.height * .2),
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
                                style: TextStyle(
                                    color: Colors.black, fontSize: 30),
                              ),
                              TextSpan(
                                text: 'rnz',
                                style: TextStyle(
                                    color: Color(0xffe46b10), fontSize: 30),
                              ),
                            ]),
                      ),
                    ),
                    const SizedBox(height: 50),
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
                        if (!value!.isEmail) {
                          return 'Please enter valid email address';
                        } else if (value.isEmpty) {
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
                    const SizedBox(height: 20),
                    Text(
                      "Password",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    CustomTextField(
                      isPassword: true,
                      controller: _passwordController,
                      hintText: 'Password',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 6) {
                          return 'Your Password length must be greater than 6';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "User Type",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<UserType>(
                            title: const Text('Student'),
                            value: UserType.student,
                            groupValue: userType,
                            onChanged: (UserType? value) {
                              setState(() {
                                userType = value!;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<UserType>(
                            title: const Text('Teacher'),
                            value: UserType.teacher,
                            groupValue: userType,
                            onChanged: (UserType? value) {
                              setState(() {
                                userType = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    PrimaryButton(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          await ac.createUserWithEmailAndPassword(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                              fullName: _fullNameController.text.trim(),
                              userType: userType);
                        }
                      },
                      text: "Register",
                    ),
                    SizedBox(height: Get.height * .10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        TextButton(
                            onPressed: () {
                              Get.to(() => LoginPageView());
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  color: MyColors.kPrimaryColor, fontSize: 14),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
