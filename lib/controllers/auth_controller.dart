import 'dart:async';

import 'package:animation_app/data/enums/user_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';
import '../services/database_services.dart';
import '../views/profile/new_password_view.dart';
import '../widgets/loading_dialog.dart';
import 'user_controller.dart';

class AuthController extends GetxController {
  final Rx<User?> _firebaseUser = Rx<User?>(null);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get user => _firebaseUser.value;
  DatabaseService db = DatabaseService();
  @override
  void onInit() {
    _firebaseUser.bindStream(_auth.authStateChanges());
    update();
    super.onInit();
  }

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      showLoadingDialog();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      hideLoadingDialog();
      Get.back();
    } on Exception catch (err) {
      hideLoadingDialog();
      Get.snackbar('Error', err.toString());
    }
  }

  Future<void> createUserWithEmailAndPassword(
      {required String email,
      required String password,
      required String fullName,
      required UserType userType}) async {
    try {
      showLoadingDialog();
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        hideLoadingDialog();
        createFirebaseUser(
            user: UserModel(
                id: value.user!.uid,
                fullName: fullName,
                email: value.user!.email,
                profilePic: '',
                userType: userType));
      });
      Get.close(1);
    } on Exception catch (err) {
      hideLoadingDialog();
      Get.snackbar("Error", err.toString());
    }
  }

  Future<void> createFirebaseUser({required UserModel user}) async {
    try {
      await db.userCollection.doc(user.id).set(user);
    } on FirebaseException catch (err) {
      Get.snackbar('Erro', err.toString());
    }
  }

  Future<void> checkCurrentPassword(String currentPassword) async {
    try {
      showLoadingDialog();
      User user = _auth.currentUser!;
      AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!, password: currentPassword);
      await user.reauthenticateWithCredential(credential);
      hideLoadingDialog();
      Get.to(() => NewPasswordView());
    } on FirebaseAuthException catch (e) {
      hideLoadingDialog();
      if (e.code == 'wrong-password') {
        Get.snackbar('Error', 'The Password is invalid');
      } else {
        Get.snackbar('Error', 'Failed to check password');
      }
    }
  }

  Future<void> changePassword(String newPassword) async {
    try {
      showLoadingDialog();
      User user = _auth.currentUser!;
      await user.updatePassword(newPassword);
      hideLoadingDialog();
      Get.snackbar('Success', 'Password updated successfully');
      Get.close(2);
    } catch (e) {
      hideLoadingDialog();
      Get.snackbar('Error', 'Failed to update password');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    if (Get.isRegistered<UserController>()) {
      Get.delete<UserController>();
    }
  }
}
