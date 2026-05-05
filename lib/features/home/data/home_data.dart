import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dalili_app/features/home/controller/home_controller.dart';

class HomeItem {
  final String title;
  final String subtitle;
  final IconData icon;

  const HomeItem({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

class HomeData {
  static const List<HomeItem> items = [
    HomeItem(
      title: 'المؤسسات',
      subtitle: 'تصفح جميع المؤسسات الحكومية واكتشف خدماتها',
      icon: Icons.account_balance,
    ),
    HomeItem(
      title: 'المعاملات',
      subtitle: 'تصفح جميع المعاملات الحكومية واطلع على تفاصيلها',
      icon: Icons.description,
    ),
    HomeItem(
      title: 'معاملاتي',
      subtitle: 'عرض ومتابعة المعاملات التي قمت بحفظها',
      icon: Icons.folder_special,
    ),
  ];
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
