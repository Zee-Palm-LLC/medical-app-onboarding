import 'package:animation_app/models/course_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'dart:async';
import '../../../services/database_services.dart';
import '../models/cart_model.dart';
import '../models/favorite_model.dart';
import '../models/user_model.dart';
import '../widgets/flutter_toast.dart';
import '../widgets/loading_dialog.dart';
import 'auth_controller.dart';

class UserController extends GetxController {
  Rx<UserModel?> _userModel = UserModel().obs;
  UserModel get user => currentUser.value;
  String get currentUid => user.id!;
  set user(UserModel user) => _userModel.value = user;
  Rx<UserModel> currentUser = Rx<UserModel>(UserModel());
  AuthController ac = Get.find<AuthController>();
  DatabaseService db = DatabaseService();

  Rx<List<CourseModel>?> _courses = Rx<List<CourseModel>?>([]);
  List<CourseModel>? get courses => _courses.value;
  RxList<FavoriteItem> favorites = <FavoriteItem>[].obs;

  Stream<UserModel?> get currentUserStream {
    return db.userCollection
        .doc(ac.user!.uid)
        .snapshots()
        .map((event) => event.data());
  }

  DocumentReference get currentUserRef {
    return db.userCollection.doc(ac.user!.uid);
  }

  Stream<List<CourseModel>> allCourses() {
    return db.courseCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return CourseModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<void> updateUserInfo({required UserModel userModel}) async {
    showLoadingDialog();
    try {
      await db.userCollection.doc(currentUid).update(userModel.toMap());
      hideLoadingDialog();
      Get.back();
    } on Exception catch (e) {
      hideLoadingDialog();
      Get.snackbar('Error', e.toString());
    }
  }

  @override
  void onInit() {
    currentUser.bindStream(currentUserStream.map((event) {
      if (event == null) {
        var fbuser = ac.user;
        update();
        return UserModel(
          email: fbuser!.email ?? "",
          id: fbuser.uid,
        );
      } else {
        UserModel _currentUser = event;
        update();
        return _currentUser;
      }
    }));
    _courses.bindStream(allCourses());
    super.onInit();
  }

  @override
  void onClose() {
    currentUser.close();
    super.onClose();
  }

  Future<void> addFavorite(CourseModel course) async {
    User? user = ac.user;
    if (user != null) {
      String userId = user.uid;
      FavoriteItem favorite =
          FavoriteItem(id: course.id, userId: userId, course: course);
      await db.favoriteCollection.add(favorite.toMap());
    }
  }

  Future<void> removeFavorite(CourseModel course) async {
    User? user = ac.user;
    if (user != null) {
      String userId = user.uid;
      QuerySnapshot snapshot = await db.favoriteCollection
          .where('id', isEqualTo: course.id)
          .where('userId', isEqualTo: userId)
          .get();
      snapshot.docs.forEach((doc) => doc.reference.delete());
    }
  }

  Stream<List<FavoriteItem>> favoritesStream(String userId) {
    return db.favoriteCollection
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) =>
                FavoriteItem.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }

  Future<void> addToCart(CourseModel course) async {
    final cartDoc = await db.cartCollection
        .where('userId', isEqualTo: ac.user!.uid)
        .limit(1)
        .get();
    final cart = cartDoc.docs.isNotEmpty
        ? Cart.fromMap(cartDoc.docs.first.data() as Map<String, dynamic>)
        : Cart(userId: ac.user!.uid, items: []);
    bool isItemExists = false;
    for (var item in cart.items) {
      if (item.id == course.id) {
        isItemExists = true;
        break;
      }
    }
    if (isItemExists) {
      showToast('Item already added to cart');
    } else {
      cart.items.add(course);
      await db.cartCollection
          .doc(cartDoc.docs.isEmpty ? null : cartDoc.docs.first.id)
          .set(cart.toMap());
      showToast('Course Added to Cart');
    }
  }

  Future<void> removeFromCart(CourseModel course) async {
    final cartDoc = await db.cartCollection
        .where('userId', isEqualTo: ac.user!.uid)
        .limit(1)
        .get();
    if (cartDoc.docs.isNotEmpty) {
      final cart =
          Cart.fromMap(cartDoc.docs.first.data() as Map<String, dynamic>);
      cart.items.removeWhere((item) => item.id == course.id);
      await db.cartCollection.doc(cartDoc.docs.first.id).set(cart.toMap());
      showToast('Course Removed from Cart');
    }
  }

  Stream<Cart> userCartStream(String userId) {
    return db.cartCollection.where('userId', isEqualTo: userId).snapshots().map(
        (snapshot) => snapshot.docs.isNotEmpty
            ? Cart.fromMap(snapshot.docs.first.data() as Map<String, dynamic>)
            : Cart(userId: userId, items: []));
  }
}
