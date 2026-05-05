import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/sign_up_data.dart';

class SignUpController extends GetxController {
  /// Controllers
  final fullNameController = TextEditingController();
  final birthDateController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  /// Loading
  var isLoading = false.obs;

  /// Validation
  String? validate() {
    if (fullNameController.text.isEmpty) {
      return "الاسم مطلوب";
    }
    if (phoneController.text.isEmpty) {
      return "رقم الهاتف مطلوب";
    }
    if (passwordController.text.length < 6) {
      return "كلمة السر ضعيفة";
    }
    if (passwordController.text != confirmPasswordController.text) {
      return "كلمات السر غير متطابقة";
    }
    return null;
  }

  /// Submit
  void register() async {
    final error = validate();

    if (error != null) {
      Get.snackbar("خطأ", error);
      return;
    }

    isLoading.value = true;

    /// simulate API
    await Future.delayed(const Duration(seconds: 2));

    final data = SignUpData(
      fullName: fullNameController.text,
      birthDate: birthDateController.text,
      phone: phoneController.text,
      password: passwordController.text,
    );

    print(data.fullName);

    isLoading.value = false;

    Get.snackbar("نجاح", "تم إنشاء الحساب");
  }

  @override
  void onClose() {
    fullNameController.dispose();
    birthDateController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
