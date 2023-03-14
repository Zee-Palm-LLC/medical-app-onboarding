import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: Lottie.asset('assets/loading.json',width: 100));
  }
}

void showLoadingDialog() {
  Get.dialog(
    const LoadingDialog(),
    barrierDismissible: false,
  );
}

void hideLoadingDialog() {
  Get.back();
  return;
}
