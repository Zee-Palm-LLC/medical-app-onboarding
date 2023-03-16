import 'package:animation_app/models/course_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../services/database_services.dart';
import '../models/cart_model.dart';
import '../models/favorite_model.dart';
import '../models/purchased_model.dart';
import '../models/user_model.dart';
import '../widgets/flutter_toast.dart';
import '../widgets/loading_dialog.dart';
import 'auth_controller.dart';

class UserController extends GetxController {
  UserModel? get user => currentUser.value;
  String get currentUid => user?.id ?? '';
  Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  AuthController ac = Get.find<AuthController>();
  DatabaseService db = DatabaseService();

  Rx<List<CourseModel>?> _courses = Rx<List<CourseModel>?>([]);
  List<CourseModel>? get courses => _courses.value;
  final favorites = RxList<FavoriteItem>([]);
  Rx<List<PurchasedCourses>?> _purchased = Rx<List<PurchasedCourses>?>([]);
  List<PurchasedCourses>? get purchased => _purchased.value;

  Stream<UserModel?> get currentUserStream {
    return db.userCollection
        .doc(ac.user!.uid)
        .snapshots()
        .map((event) => event.data());
  }

  DocumentReference get currentUserRef {
    return db.userCollection.doc(ac.user!.uid);
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
        return UserModel(email: fbuser!.email ?? "", id: fbuser.uid);
      } else {
        UserModel _currentUser = event;
        update();
        return _currentUser;
      }
    }));
    _courses.bindStream(allCourses());
    print(_courses);
    favorites.bindStream(favoritesStream(ac.user!.uid));
    _purchased.bindStream(getBoughtCourses());
    super.onInit();
  }

  @override
  void onClose() {
    currentUser.close();
    super.onClose();
  }

  Stream<List<CourseModel>?> allCourses() {
    return db.courseCollection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => CourseModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList());
  }

  Stream<List<CourseModel>> getCoursesByCategory(String categoryId) {
    return db.courseCollection
        .where('category.id', isEqualTo: categoryId)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) =>
                CourseModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }

  Future<void> addFavorite(CourseModel course) async {
    User? user = ac.user;
    if (user != null) {
      String userId = user.uid;
      FavoriteItem favorite =
          FavoriteItem(id: course.id, userId: userId, course: course);
      await db.favoriteCollection.add(favorite.toMap());
      favorites.addAll([favorite]);
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
      favorites.removeWhere((favorite) => favorite.id == course.id);
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
    try {
      showLoadingDialog();
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
      hideLoadingDialog();
      if (isItemExists) {
        showToast('Item already added to cart');
      } else {
        cart.items.add(course);
        await db.cartCollection
            .doc(cartDoc.docs.isEmpty ? null : cartDoc.docs.first.id)
            .set(cart.toMap());
        showToast('Course Added to Cart');
      }
    } catch (e) {
      hideLoadingDialog();
      print('Error adding course to cart: $e');
      showToast('Error adding course to cart');
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

  Future<void> addToBoughtCollection(PurchasedCourses purchased) async {
    try {
      final DocumentReference docRef = db.userCollection
          .doc(ac.user!.uid)
          .collection('bought')
          .doc(purchased.course.id);
      purchased.id = docRef.id;
      await docRef.set(purchased.toMap());
      await removeFromCart(purchased.course);
      showToast('Course Bought');
    } catch (e) {
      print('Error adding cart to "bought" sub-collection: $e');
    }
  }

  Future<void> updateCompletedValue(String courseId) async {
    try {
      final DocumentReference docRef = db.userCollection
          .doc(ac.user!.uid)
          .collection('bought')
          .doc(courseId);
      final DocumentSnapshot snapshot = await docRef.get();
      final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      final double totalValue = data['totalValue'] ?? 0.0;
      double completedValue = data['completedValue'] ?? 0.0;
      if (completedValue <= totalValue) {
        final double newCompletedValue =
            completedValue += totalValue / totalValue;
        await docRef.update({
          'completedValue': newCompletedValue,
        });
      } else {
        Get.snackbar('Congratulations', 'You have completed this course');
      }
    } catch (e) {
      print('Error updating "bought" sub-collection: $e');
    }
  }

  Stream<List<PurchasedCourses>> getBoughtCourses() {
    return db.userCollection
        .doc(ac.user!.uid)
        .collection('bought')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return PurchasedCourses.fromMap(data);
      }).toList();
    });
  }
}
