import 'package:dalili_app/features/transactions/data/model/office_model.dart';

class OfficeDetailsMockData {
  static List<OfficeModel> getOffices() {
    return [
      OfficeModel(
        id: 'office-1',
        name: 'مكتب الاستقبال',
        institutionName: 'مديرية الأحوال المدنية',
        departmentName: 'شؤون المواطنين',
        locationInsideInstitution: 'الطابق الأرضي - الجناح الشرقي',
        notes: 'يوجد ممر مخصص للمتقدمين ويُفضَّل الحضور صباحاً.',
      ),
      OfficeModel(
        id: 'office-2',
        name: 'مكتب التحقق',
        institutionName: 'مديرية الأحوال المدنية',
        departmentName: 'الشؤون الإدارية',
        locationInsideInstitution: 'الطابق الأول - الجناح الغربي',
        notes: 'يمكن الاستفسار من البواب أو شاشة التوجيه.',
      ),
    ];
  }
}
