import 'package:dalili_app/features/transactions/data/model/office_model.dart';
import 'package:dalili_app/features/offices/data/office_repository.dart';
import 'package:get/get.dart';

class OfficeController extends GetxController {
  final OfficeRepository _repository = OfficeRepository();

  final office = Rx<OfficeModel?>(null);
  final isLoading = RxBool(false);
  final hasError = RxBool(false);
  final errorMessage = RxString('');

  @override
  void onInit() {
    super.onInit();
    _loadOfficeById();
  }

  Future<void> _loadOfficeById() async {
    try {
      isLoading.value = true;
      hasError.value = false;

      final args = Get.arguments;
      String? officeId;
      if (args is Map && args['officeId'] != null) {
        officeId = args['officeId'] as String;
      }

      if (officeId == null || officeId.isEmpty) {
        hasError.value = true;
        errorMessage.value = 'معرف المكتب غير صالح.';
        return;
      }

      final result = await _repository.getOfficeById(officeId);
      if (result != null) {
        office.value = result;
      } else {
        hasError.value = true;
        errorMessage.value = 'تعذر العثور على المكتب.';
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'حدث خطأ: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  void retry() => _loadOfficeById();
}
