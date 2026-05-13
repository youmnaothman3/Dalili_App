import 'package:dalili_app/features/institutions/model/institution_model.dart';

class InstitutionsMockData {
  static const List<Map<String, dynamic>> mockInstitutions = [
    {
      'id': '1',
      'name': 'مديرية المالية',
      'ministry': 'وزارة المالية',
      'location': 'دمشق',
      'description': 'وزارة المالية - فرع دمشق',
      'icon': 'building',
      'address': 'دمشق، المهاجرين، مقابل سوق الهال، بناء المالية.',
      'workingHours': 'من الأحد إلى الخميس: 8:00 صباحاً - 2:30 ظهراً',
      'phone': '011 4422 334',
      'email': 'info@mf.gov.sy',
      'shortDescription': 'مديرية المالية هي الجهة المختصة بتنفيذ السياسات المالية وإدارة الموارد العامة للدولة، بما يضمن تحقيق الاستدامة المالية والكفاءة في استخدام الموارد وفقاً للتشريعات النافذة.',
      'latitude': 33.5138,
      'longitude': 36.2765,
      'isOpen': true,
    },
    {
      'id': '2',
      'name': 'مديرية النقل',
      'ministry': 'وزارة النقل',
      'location': 'دمشق',
      'description': 'وزارة النقل - فرع دمشق',
      'icon': 'building',
      'address': 'دمشق، نهر عيشة',
      'workingHours': 'من الأحد إلى الخميس: 8:00 صباحاً - 2:30 ظهراً',
      'phone': '011 2233 445',
      'email': 'info@mot.gov.sy',
      'shortDescription': 'مديرية النقل هي الجهة المسؤولة عن تنظيم قطاع النقل وتسجيل المركبات وإصدار الرخص.',
      'latitude': 33.5138,
      'longitude': 36.2765,
      'isOpen': true,
    },
    {
      'id': '3',
      'name': 'مديرية المالية',
      'ministry': 'وزارة المالية',
      'location': 'حلب',
      'description': 'وزارة المالية - فرع حلب',
      'icon': 'building',
      'address': 'حلب، مركز المدينة',
      'workingHours': 'من الأحد إلى الخميس: 8:00 صباحاً - 2:30 ظهراً',
      'phone': '021 1122 334',
      'email': 'aleppo@mf.gov.sy',
      'shortDescription': 'مديرية المالية هي الجهة المختصة بتنفيذ السياسات المالية.',
      'latitude': 36.2012,
      'longitude': 37.1612,
      'isOpen': true,
    },
    {
      'id': '4',
      'name': 'مديرية الأحوال المدنية',
      'ministry': 'وزارة الداخلية',
      'location': 'حمص',
      'description': 'وزارة الداخلية - فرع حمص',
      'icon': 'building',
      'address': 'حمص، المحطة',
      'workingHours': 'من الأحد إلى الخميس: 8:00 صباحاً - 2:30 ظهراً',
      'phone': '031 2233 445',
      'email': 'homs@moi.gov.sy',
      'shortDescription': 'إصدار الهويات وجوازات السفر والوثائق الشخصية.',
      'latitude': 34.7324,
      'longitude': 36.7137,
      'isOpen': false,
    },
    {
      'id': '5',
      'name': 'مديرية التربية',
      'ministry': 'وزارة التربية',
      'location': 'طرطوس',
      'description': 'وزارة التربية - فرع طرطوس',
      'icon': 'building',
      'address': 'طرطوس، الكورنيش',
      'workingHours': 'من الأحد إلى الخميس: 8:00 صباحاً - 2:30 ظهراً',
      'phone': '043 3344 556',
      'email': 'tartous@moed.gov.sy',
      'shortDescription': 'الإشراف على العملية التعليمية والمدارس.',
      'latitude': 34.8890,
      'longitude': 35.8866,
      'isOpen': true,
    },
    {
      'id': '6',
      'name': 'مديرية الصحة',
      'ministry': 'وزارة الصحة',
      'location': 'اللاذقية',
      'description': 'وزارة الصحة - فرع اللاذقية',
      'icon': 'building',
      'address': 'اللاذقية، المشروع السابع',
      'workingHours': 'من الأحد إلى الخميس: 8:00 صباحاً - 2:30 ظهراً',
      'phone': '041 4455 667',
      'email': 'lattakia@moh.gov.sy',
      'shortDescription': 'تنظيم الخدمات الصحية والمستشفيات العامة.',
      'latitude': 35.5200,
      'longitude': 35.7749,
      'isOpen': true,
    },
  ];

  static List<Institution> getInstitutions() {
    return mockInstitutions.map((json) => Institution.fromJson(json)).toList();
  }

  static List<String> getLocations() {
    return mockInstitutions
        .map((e) => e['location'] as String)
        .toSet()
        .toList();
  }
}
