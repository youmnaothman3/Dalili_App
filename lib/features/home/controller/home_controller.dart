import 'package:dalili_app/core/constant/app_strings.dart';
import 'package:dalili_app/features/home/data/home_data.dart';
import 'package:dalili_app/features/home/model/home_item_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final title = AppStrings.appTitle;
  final subtitle = AppStrings.subtitle;
  late final menuItems = RxList<HomeItem>()..addAll(HomeData.items);

  void onItemTap(int index) {
    final item = menuItems[index];

    if (item.route != null) {
      Get.toNamed(item.route!);
    } else {
      // Fallback for items without routes
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
}
