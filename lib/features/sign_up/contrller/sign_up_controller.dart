// import 'package:dalili_app/core/routes/route_class.dart';
// import 'package:dalili_app/helper/app_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as Api;

// import '../data/sign_up_data.dart';

// class SignUpController extends GetxController {
//   /// Controllers
//   final fullNameController = TextEditingController();
//   final birthDateController = TextEditingController();
//   final phoneController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();

//   /// Loading
//    final isLoading = false.obs;
//   final showPassword = false.obs;
//   final showConfirmPassword = false.obs;
//   /// Toggle Password
//   void changeShowPassword() {
//     showPassword.value = !showPassword.value;
//   }

//   /// Toggle Confirm Password
//   void changeShowConfirmPassword() {
//     showConfirmPassword.value = !showConfirmPassword.value;
//   }
//   /// Validation
//   String? validate() {
//     if (fullNameController.text.isEmpty) {
//       return "الاسم مطلوب";
//     }
//     if (phoneController.text.isEmpty) {
//       return "رقم الهاتف مطلوب";
//     }
//     if (passwordController.text.length < 6) {
//       return "كلمة السر ضعيفة";
//     }
//     if (passwordController.text != confirmPasswordController.text) {
//       return "كلمات السر غير متطابقة";
//     }
//     return null;
//   }

//   /// Submit
//   // void register() async {
//   //   final error = validate();

//   //   if (error != null) {
//   //     Get.snackbar("خطأ", error);
//   //     return;
//   //   }

//   //   isLoading.value = true;
//   Future<void> register(BuildContext context) async {

//     AppHelper.showWaitdialog(context);

//     try {

//       final validation = validate();

//       if (validation!.isNotEmpty) {

//         Get.back();

//         switch (validation) {

//           case 'fullName':
//             AppHelper.showSnackbar(
//               'الاسم الكامل',
//               'يرجى إدخال الاسم الكامل',
//             );
//             break;

//           case 'birthDate':
//             AppHelper.showSnackbar(
//               'تاريخ الميلاد',
//               'يرجى إدخال تاريخ الميلاد',
//             );
//             break;

//           case 'phone':
//             AppHelper.showSnackbar(
//               'رقم الهاتف',
//               'يرجى إدخال رقم الهاتف',
//             );
//             break;

//           case 'password':
//             AppHelper.showSnackbar(
//               'كلمة السر',
//               'يرجى إدخال كلمة السر',
//             );
//             break;

//           case 'confirmPassword':
//             AppHelper.showSnackbar(
//               'تأكيد كلمة السر',
//               'يرجى تأكيد كلمة السر',
//             );
//             break;

//           case 'weakPassword':
//             AppHelper.showSnackbar(
//               'كلمة السر',
//               'كلمة السر ضعيفة',
//             );
//             break;

//           case 'notMatch':
//             AppHelper.showSnackbar(
//               'كلمة السر',
//               'كلمات السر غير متطابقة',
//             );
//             break;
//         }

//         return;
//       }

//       isLoading.value = true;

// //     /// simulate API
// //     await Future.delayed(const Duration(seconds: 2));

// //     final data = SignUpData(
// //       fullName: fullNameController.text,
// //       birthDate: birthDateController.text,
// //       phone: phoneController.text,
// //       password: passwordController.text,
// //     );

// //     print(data.fullName);

// //     isLoading.value = false;

// //     Get.snackbar("نجاح", "تم إنشاء الحساب");
// //   }

// //   @override
// //   void onClose() {
// //     fullNameController.dispose();
// //     birthDateController.dispose();
// //     phoneController.dispose();
// //     passwordController.dispose();
// //     confirmPasswordController.dispose();
// //     super.onClose();
// //   }
// // }
//       /// API Request
//       var response = await Api.post(
//         url: 'user/register',
//         body: {
//           'full_name': fullNameController.text,
//           'birth_date': birthDateController.text,
//           'phone': phoneController.text,
//           'password': passwordController.text,
//         },
//       );

//       if (response['message'] != null) {
//         AppHelper.showSnackbar('نجاح', response['message']);

//         final data = SignUpData(
//           fullName: fullNameController.text,
//           birthDate: birthDateController.text,
//           phone: phoneController.text,
//           password: passwordController.text,
//         );

//         print(data.fullName);

//         Get.offAllNamed(Routes.home);
//       } else {
//         AppHelper.showSnackbar('خطأ', 'حدث خطأ أثناء إنشاء الحساب');
//       }
//     } catch (e) {
//       AppHelper.showSnackbar('خطأ', e.toString());
//     } finally {
//       isLoading.value = false;

//       Get.back();
//     }
//   }

//   @override
//   void onClose() {
//     fullNameController.dispose();
//     birthDateController.dispose();
//     phoneController.dispose();
//     passwordController.dispose();
//     confirmPasswordController.dispose();

//     super.onClose();
//   }
// }
import 'package:dalili_app/core/routes/route_class.dart';
import 'package:dalili_app/helper/api.dart';
import 'package:dalili_app/helper/app_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/sign_up_data.dart';

class SignUpController extends GetxController {
  /// =========================
  /// TEXT EDITING CONTROLLERS
  /// =========================

  final fullNameController = TextEditingController();
  final birthDateController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  /// =========================
  /// OBS VARIABLES
  /// =========================

  final isLoading = false.obs;

  final showPassword = false.obs;
  final showConfirmPassword = false.obs;

  /// =========================
  /// TOGGLE PASSWORD
  /// =========================

  void changeShowPassword() {
    showPassword.value = !showPassword.value;
  }

  void changeShowConfirmPassword() {
    showConfirmPassword.value = !showConfirmPassword.value;
  }

  /// =========================
  /// VALIDATION
  /// =========================

  String validateInputs() {
    if (fullNameController.text.trim().isEmpty) {
      return 'fullName';
    }

    if (birthDateController.text.trim().isEmpty) {
      return 'birthDate';
    }

    if (phoneController.text.trim().isEmpty) {
      return 'phone';
    }

    if (passwordController.text.trim().isEmpty) {
      return 'password';
    }

    if (confirmPasswordController.text.trim().isEmpty) {
      return 'confirmPassword';
    }

    if (passwordController.text.length < 6) {
      return 'weakPassword';
    }

    if (passwordController.text != confirmPasswordController.text) {
      return 'notMatch';
    }

    return '';
  }

  /// =========================
  /// REGISTER
  /// =========================

  Future<void> register(BuildContext context) async {
    /// VALIDATE FIRST
    final validation = validateInputs();

    /// IF VALIDATION FAILED
    if (validation.isNotEmpty) {
      switch (validation) {
        case 'fullName':
          AppHelper.showSnackbar('الاسم الكامل', 'يرجى إدخال الاسم الكامل');
          break;

        case 'birthDate':
          AppHelper.showSnackbar('تاريخ الميلاد', 'يرجى إدخال تاريخ الميلاد');
          break;

        case 'phone':
          AppHelper.showSnackbar('رقم الهاتف', 'يرجى إدخال رقم الهاتف');
          break;

        case 'password':
          AppHelper.showSnackbar('كلمة السر', 'يرجى إدخال كلمة السر');
          break;

        case 'confirmPassword':
          AppHelper.showSnackbar('تأكيد كلمة السر', 'يرجى تأكيد كلمة السر');
          break;

        case 'weakPassword':
          AppHelper.showSnackbar(
            'كلمة السر',
            'كلمة السر يجب أن تكون 6 أحرف على الأقل',
          );
          break;

        case 'notMatch':
          AppHelper.showSnackbar('كلمة السر', 'كلمات السر غير متطابقة');
          break;
      }

      return;
    }

    /// SHOW LOADING DIALOG
    AppHelper.showWaitdialog(context);

    try {
      isLoading.value = true;

      /// API REQUEST
      var response = await Api.post(
        url: 'user/register',
        body: {
          'full_name': fullNameController.text.trim(),
          'birth_date': birthDateController.text.trim(),
          'phone': phoneController.text.trim(),
          'password': passwordController.text.trim(),
        },
      );

      /// SUCCESS
      if (response['message'] != null) {
        final data = SignUpData(
          fullName: fullNameController.text.trim(),
          birthDate: birthDateController.text.trim(),
          phone: phoneController.text.trim(),
          password: passwordController.text.trim(),
        );

        print(data.fullName);

        AppHelper.showSnackbar('نجاح', response['message']);

        Get.offAllNamed(Routes.home);
      } else {
        AppHelper.showSnackbar('خطأ', 'حدث خطأ أثناء إنشاء الحساب');
      }
    } catch (e) {
      AppHelper.showSnackbar('خطأ', e.toString());
    } finally {
      isLoading.value = false;

      /// CLOSE DIALOG SAFELY
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
    }
  }

  /// =========================
  /// DISPOSE
  /// =========================

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
