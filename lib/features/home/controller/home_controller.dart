import 'package:dalili_app/core/constant/app_strings.dart';
import 'package:dalili_app/features/home/data/home_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final title = AppStrings.appTitle;
  final subtitle = AppStrings.subtitle;
  final menuItems = RxList<HomeItem>(HomeData.items);

  void onItemTap(int index) {
    final item = menuItems[index];

    Get.snackbar(
      item.title,
      'فتح ${item.title}',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: Colors.black87,
      margin: const EdgeInsets.all(16),
      borderRadius: 16,
    );
  }
}
