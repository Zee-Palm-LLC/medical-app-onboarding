import 'package:animation_app/controllers/auth_controller.dart';
import 'package:animation_app/data/constants.dart';
import 'package:animation_app/views/intro/components/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/bezier_card.dart';
import 'components/custom_textfield.dart';
import 'components/social_button.dart';
import 'register_view.dart';

class LoginPageView extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthController ac = Get.find<AuthController>();
  LoginPageView({super.key});

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
                  child: const BezierContainer()),
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
                      PrimaryButton(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            await ac.signInWithEmailAndPassword(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim());
                          }
                        },
                        text: 'Login',
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: const Text('Forgot Password ?',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500)),
                          )),
                      Row(
                        children: const [
                          SizedBox(width: 20),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Divider(
                                thickness: 1,
                              ),
                            ),
                          ),
                          Text('or'),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Divider(
                                thickness: 1,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const CustomSocialButton(),
                      SizedBox(height: Get.height * .055),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account !",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          TextButton(
                              onPressed: () {
                                Get.to(() => SignUpView());
                              },
                              child: const Text(
                                "Register",
                                style: TextStyle(
                                    color: MyColors.kPrimaryColor,
                                    fontSize: 14),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
