import 'package:dalili_app/features/institutions/data/institution_details_repository.dart';
import 'package:dalili_app/features/institutions/model/institution_branch_model.dart';
import 'package:dalili_app/features/institutions/model/institution_model.dart';
import 'package:dalili_app/features/institutions/model/institution_transaction_model.dart';
import 'package:get/get.dart';

class InstitutionDetailsController extends GetxController {
  final InstitutionDetailsRepository _repository = InstitutionDetailsRepository();

  late final Institution institution;

  final branches = RxList<InstitutionBranch>([]);
  final transactions = RxList<InstitutionTransaction>([]);
  
  final isLoading = RxBool(false);
  final hasError = RxBool(false);
  final errorMessage = RxString('');

  @override
  void onInit() {
    super.onInit();
    // Get the institution from navigation arguments
    if (Get.arguments is Institution) {
      institution = Get.arguments as Institution;
      loadInitialData();
    } else {
      hasError.value = true;
      errorMessage.value = 'Failed to load institution data.';
    }
  }

  Future<void> loadInitialData() async {
    try {
      isLoading.value = true;
      hasError.value = false;

      final results = await Future.wait([
        _repository.getInstitutionBranches(institution.id),
        _repository.getInstitutionTransactions(institution.id),
      ]);

      branches.value = results[0] as List<InstitutionBranch>;
      transactions.value = results[1] as List<InstitutionTransaction>;

    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'حدث خطأ في تحميل البيانات: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  void retry() {
    loadInitialData();
  }
}
