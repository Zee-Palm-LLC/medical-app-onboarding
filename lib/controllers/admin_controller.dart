import 'package:animation_app/controllers/user_controller.dart';
import 'package:animation_app/models/course_model.dart';
import 'package:animation_app/services/database_services.dart';
import 'package:animation_app/widgets/loading_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../services/aloglia.dart';

class AdminController extends GetxController {
  DatabaseService db = DatabaseService();
  UserController uc = Get.find<UserController>();
  var algolia = AlgoliaApplication.algolia;

  Future<void> addCourse(CourseModel course) async {
    try {
      showLoadingDialog();
      var doc = db.courseCollection.doc();
      course.id = doc.id;
      course.uploadedBy = uc.user.fullName!;
      course.uploaderPic = uc.user.profilePic ?? '';
      course.chapters.forEach((subObject) {
        subObject.id = const Uuid().v4();
      });
      course.ownerId = FirebaseAuth.instance.currentUser!.uid;
      await doc.set(course.toMap());
      await algolia.instance
          .index('dev-futurelearning')
          .addObject(course.toMap());
      hideLoadingDialog();
      Get.back();
    } catch (e) {
      hideLoadingDialog();
      Get.snackbar(
        "error",
        e.toString(),
        borderRadius: 15,
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
