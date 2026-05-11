import 'package:dalili_app/widgets/wait_dialod.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AppHelper {
  static showWaitdialog(context) {
    showDialog(context: context, builder: (context) => WaitDialog());
  }

  static showSnackbar(String title, String subTitle) {
    Get.snackbar(
      title,
      subTitle,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: Colors.black87,
      margin: const EdgeInsets.all(16),
      borderRadius: 16,
    );
  }
}
