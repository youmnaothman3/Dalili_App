import 'package:dalili_app/core/routes/route_class.dart';
import 'package:dalili_app/helper/api.dart';
import 'package:dalili_app/helper/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final Rx<TextEditingController> phoneController = Rx<TextEditingController>(
    TextEditingController(),
  );
  final Rx<TextEditingController> passwordController =
      Rx<TextEditingController>(TextEditingController());
  final RxBool showPassword = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  var isLoading = false.obs;
  var rememberMe = false.obs;

  void changePhoneControllerValue(String value) {
    phoneController.value.text = value;
  }

  void changeShowPassword() {
    showPassword.value = !showPassword.value;
  }

  String validateNameAndPassword() {
    if (phoneController.value.text == '') {
      return 'phone';
    } else if (passwordController.value.text == '') {
      return 'password';
    } else {
      return '';
    }
  }

  Future<void> signIn(context) async {
    // AppHelper.showWaitdialog(context);
    // print(validateNameAndPassword());
    // try {
    //   if (validateNameAndPassword() == '') {
    //     var response = await Api.post(
    //       url: 'user/login',
    //       body: {
    //         'phone': phoneController.value.text,
    //         'password': passwordController.value.text,
    //       },
    //     );

    //     if (response['message'] != null) {
    //       AppHelper.showSnackbar(response['message'], response['message']);
    //     }else{

    //     }
    //   } else {
    //     if (validateNameAndPassword() == 'phone') {
    //       Get.back();
    //       AppHelper.showSnackbar('رقم الهاتف', 'يرجى ادخال رقم الهاتف');
    //     } else {
    //       Get.back();
    //       AppHelper.showSnackbar('كلمة السر', 'يرجى ادخال كلمة السر');
    //     }
    //   }
    // } finally {
    //   // TODO
    // }
  }

  String? validate() {
    if (phoneController.value.text.isEmpty) {
      return "رقم الهاتف مطلوب";
    }
    if (passwordController.value.text.length < 6) {
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
    phoneController.value.dispose();
    passwordController.value.dispose();
    super.onClose();
  }
}
