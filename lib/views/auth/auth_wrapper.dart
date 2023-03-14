import 'package:animation_app/views/auth/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/user_controller.dart';
import '../landingPage/landing_page.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(
        init: AuthController(),
        autoRemove: false,
        builder: (ac) {
          if (ac.user == null) {
            return LoginPageView();
          } else {
            Get.put(UserController());
            return LandingPage();
          }
        });
  }
}
