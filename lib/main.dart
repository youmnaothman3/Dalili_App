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
      // locale: const Locale('ar'),
      // textDirection: TextDirection.rtl,
      debugShowCheckedModeBanner: false,
      //initialRoute: Routes.patientSignin,
      getPages: AppPages.pages,
    );
  }
}
