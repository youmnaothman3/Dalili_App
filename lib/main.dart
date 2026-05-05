import 'package:dalili_app/core/constant/app_theme.dart';
import 'package:dalili_app/features/sign_in/view/sign_in_view.dart';
import 'package:dalili_app/features/sign_up/view/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/routes/route_class.dart';

void main() {
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
