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
    },
    {
      'id': '2',
      'name': 'مديرية النقل',
      'ministry': 'وزارة النقل',
      'location': 'دمشق',
      'description': 'وزارة النقل - فرع دمشق',
      'icon': 'building',
    },
    {
      'id': '3',
      'name': 'مديرية المالية',
      'ministry': 'وزارة المالية',
      'location': 'حلب',
      'description': 'وزارة المالية - فرع حلب',
      'icon': 'building',
    },
    {
      'id': '4',
      'name': 'مديرية الأحوال المدنية',
      'ministry': 'وزارة الداخلية',
      'location': 'حمص',
      'description': 'وزارة الداخلية - فرع حمص',
      'icon': 'building',
    },
    {
      'id': '5',
      'name': 'مديرية التربية',
      'ministry': 'وزارة التربية',
      'location': 'طرطوس',
      'description': 'وزارة التربية - فرع طرطوس',
      'icon': 'building',
    },
    {
      'id': '6',
      'name': 'مديرية الصحة',
      'ministry': 'وزارة الصحة',
      'location': 'اللاذقية',
      'description': 'وزارة الصحة - فرع اللاذقية',
      'icon': 'building',
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
