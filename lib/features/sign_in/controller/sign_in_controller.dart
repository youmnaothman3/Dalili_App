import 'package:dalili_app/core/routes/route_class.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;
  var rememberMe = false.obs;

  String? validate() {
    if (phoneController.text.isEmpty) {
      return "رقم الهاتف مطلوب";
    }
    if (passwordController.text.length < 6) {
      return "كلمة السر ضعيفة";
    }
    return null;
  }

  void register() async {
    final error = validate();

    if (error != null) {
      Get.snackbar("خطأ", error);
      return;
    }

    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 2));

    isLoading.value = false;

    Get.snackbar("نجاح", "تم تسجيل الدخول");
    Get.offAllNamed(Routes.home);
  }

  @override
  void onClose() {
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
