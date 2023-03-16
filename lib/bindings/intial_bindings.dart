import 'package:animation_app/controllers/user_controller.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<UserController>(() => UserController());    
  }
}
