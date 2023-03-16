import 'package:animation_app/controllers/user_controller.dart';
import 'package:animation_app/data/constants.dart';
import 'package:animation_app/data/enums/user_type.dart';
import 'package:animation_app/views/admin/admin_home_page.dart';
import 'package:animation_app/views/landingPage/components/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

import '../home/home_view.dart';

class LandingPage extends StatelessWidget {
  LandingPage({Key? key}) : super(key: key);

  final _drawerController = ZoomDrawerController();
  @override
  Widget build(BuildContext context) {
    return GetX<UserController>(
      init: UserController(),
      initState: (_) {},
      builder: (uc) {
        if (uc.user == null) {
         print(uc.user);
          return Material(
              color: Colors.white,
              child: Center(child: CircularProgressIndicator()));
        }
        return ZoomDrawer(
          controller: _drawerController,
          style: DrawerStyle.defaultStyle,
          menuScreen: const SideBar(),
          mainScreen: uc.user!.userType == UserType.student
              ? HomeView()
              : AdminHomePage(),
          borderRadius: 24,
          showShadow: true,
          angle: 0,
          menuScreenWidth: Get.width,
          isRtl: false,
          menuBackgroundColor: Colors.white,
          slideWidth: Get.width * 0.70,
          openCurve: Curves.linear,
          closeCurve: Curves.linear,
          shadowLayer1Color: Colors.transparent,
          shadowLayer2Color: MyColors.kPrimaryColor,
        );
      },
    );
  }
}
