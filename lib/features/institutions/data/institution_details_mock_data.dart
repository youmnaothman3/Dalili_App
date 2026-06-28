import 'package:dalili_app/features/institutions/data/model/institution_branch_model.dart';
import 'package:dalili_app/features/institutions/data/model/institution_transaction_model.dart';

class InstitutionDetailsMockData {
  static final List<InstitutionBranch> branches = [
    InstitutionBranch(
      id: '1',
      name: 'مديرية المالية',
      location: 'دمشق',
      address: 'دمشق، المهاجرين، مقابل سوق الهال',
      isOpen: true,
      transactionsCount: 8,
    ),
    InstitutionBranch(
      id: '2',
      name: 'مديرية المالية',
      location: 'حلب',
      address: 'حلب، مركز المدينة',
      isOpen: false,
      transactionsCount: 12,
    ),
    InstitutionBranch(
      id: '3',
      name: 'مديرية المالية',
      location: 'حمص',
      address: 'حمص، المحطة',
      isOpen: true,
      transactionsCount: 6,
    ),
    InstitutionBranch(
      id: '4',
      name: 'مديرية المالية',
      location: 'اللاذقية',
      address: 'اللاذقية، المشروع السابع',
      isOpen: true,
      transactionsCount: 5,
    ),
  ];

  static final List<InstitutionTransaction> transactions = [
    InstitutionTransaction(
      id: '1',
      name: 'براءة ذمة مالية',
      description: 'الحصول على وثيقة براءة ذمة من الدوائر المالية.',
      estimatedTimeInDays: 4,
      fees: '2000 ل.س',
    ),
    InstitutionTransaction(
      id: '2',
      name: 'اعتراض ضريبي',
      description: 'تقديم طلب اعتراض على التكليف الضريبي.',
      estimatedTimeInDays: 6,
      fees: 'مجاناً',
    ),
    InstitutionTransaction(
      id: '3',
      name: 'دفع الرسوم',
      description: 'تسديد الرسوم والضرائب المستحقة مالياً.',
      estimatedTimeInDays: 3,
      fees: 'حسب نوع الرسم',
    ),
    InstitutionTransaction(
      id: '4',
      name: 'استخراج بيان مالي',
      description: 'إصدار بيان مالي للتأكد من الوضع المالي للمكلف.',
      estimatedTimeInDays: 5,
      fees: '1000 ل.س',
    ),
  ];
}
