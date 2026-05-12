import 'package:dalili_app/features/home/model/home_item_model.dart';
import 'package:flutter/material.dart';

class HomeData {
  static const List<HomeItem> items = [
    HomeItem(
      title: 'المؤسسات',
      subtitle: 'تصفح جميع المؤسسات الحكومية واكتشف خدماتها',
      icon: Icons.account_balance,
      route: '/institutions',
    ),
    HomeItem(
      title: 'المعاملات',
      subtitle: 'تصفح جميع المعاملات الحكومية واطلع على تفاصيلها',
      icon: Icons.description,
      route: '/procedures',
    ),
    HomeItem(
      title: 'معاملاتي',
      subtitle: 'عرض ومتابعة المعاملات التي قمت بحفظها',
      icon: Icons.folder_special,
      route: '/my_procedures',
    ),
  ];
}
