import 'package:dalili_app/features/institutions/data/institutions_mock_data.dart';
import 'package:dalili_app/features/transactions/data/model/stage_model.dart';
import 'office_details_mock_data.dart';

class StageDetailsMockData {
  static List<StageModel> getStages() {
    final institutions = InstitutionsMockData.getInstitutions();
    final offices = OfficeDetailsMockData.getOffices();

    return [
      StageModel(
        id: 'stage-1',
        name: 'استلام الطلب الأولي',
        description: 'يتم استلام الطلب والوثائق الأساسية وتسجيلها في النظام.',
        responsibleInstitution: institutions[3].name,
        shortDescription: 'المرحلة الأولى لتسجيل الطلب وتثبيت بيانات المتقدم.',
        requiredDocuments: ['هوية شخصية سارية', 'طلب رسمي مملوء'],
        requiredFees: ['رسوم التسجيل: 500 ل.س'],
        requiredStamps: ['ختم الإدارة المختصة'],
        notes: ['يفضل مراجعة الوثائق قبل الحضور', 'يتم التسجيل خلال نفس اليوم'],
        institution: institutions[3],
        office: offices.first,
      ),
      StageModel(
        id: 'stage-2',
        name: 'المراجعة والتدقيق',
        description:
            'تتم مراجعة البيانات والتأكد من اكتمال المستندات قبل المتابعة.',
        responsibleInstitution: institutions[3].name,
        shortDescription: 'تدقيق المستندات والبيانات قبل إصدار القرار.',
        requiredDocuments: ['نسخة عن الهوية', 'أصل الطلب المعبأ'],
        requiredFees: ['لا توجد رسوم إضافية'],
        requiredStamps: ['ختم شؤون الموظفين'],
        notes: ['قد يتم طلب مستندات إضافية حسب الحالة'],
        institution: institutions[3],
        office: offices[1],
      ),
    ];
  }
}
