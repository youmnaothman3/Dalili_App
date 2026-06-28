import 'package:dalili_app/core/constant/app_theme.dart';
import 'package:dalili_app/features/home/controller/home_controller.dart';
import 'package:dalili_app/features/institutions/controller/institutions_controller.dart';
import 'package:dalili_app/features/sign_in/controller/sign_in_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'core/routes/route_class.dart';

void main() {
  Get.put(() => SignInController());
  Get.put(() => HomeController());
  // Get.put(() => InstitutionsController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: const Locale('ar'),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl, // 👈 يخلي كل شي RTL
          child: child!,
        );
      },

      initialRoute: Routes.signIn,
      getPages: AppPages.pages,
    );
  }
}
