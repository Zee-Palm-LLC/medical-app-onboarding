import 'package:animation_app/controllers/user_controller.dart';
import 'package:animation_app/data/enums/category_enum.dart';
import 'package:animation_app/models/course_model.dart';
import 'package:animation_app/services/database_services.dart';
import 'package:animation_app/widgets/loading_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../models/category_model.dart';
import '../services/aloglia.dart';

class AdminController extends GetxController {
  DatabaseService db = DatabaseService();
  UserController uc = Get.find<UserController>();
  var algolia = AlgoliaApplication.algolia;
  Rx<List<CategoryModel>?> _categories = Rx<List<CategoryModel>?>([]);
  List<CategoryModel>? get categories => _categories.value;

  Future<void> addCategory(CategoryModel category) async {
    try {
      showLoadingDialog();
      var doc = db.categoryCollection.doc();
      category.id = doc.id;
      doc.set(category);
      hideLoadingDialog();
      Get.back();
      print('Category added successfully');
    } catch (e) {
      hideLoadingDialog();
      print('Error adding category: $e');
    }
  }

  Stream<List<CategoryModel>?> streamCategories() {
    return db.categoryCollection.snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  @override
  void onInit() {
    _categories.bindStream(streamCategories());
    print(_categories);
    super.onInit();
  }

  Future<void> addCourse(CourseModel course, String categoryId) async {
    try {
      showLoadingDialog();
      DocumentReference doc = await db.courseCollection
          .add(course.toMap());
      course.id = doc.id;
      course.uploadedBy = uc.user!.fullName ?? '';
      course.uploaderPic = uc.user!.profilePic ?? '';
      course.chapters.forEach((subObject) {
        subObject.id = const Uuid().v4();
      });
      course.ownerId = FirebaseAuth.instance.currentUser!.uid;
      await doc.set(course.toMap());
      await algolia.instance
          .index('dev-futurelearning')
          .addObject(course.toMap());
      await db.categoryCollection
          .doc(categoryId)
          .update({'totalCourses': FieldValue.increment(1)});
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
