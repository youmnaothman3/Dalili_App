import 'package:dalili_app/features/transactions/data/model/office_model.dart';
import 'package:dalili_app/features/transactions/data/office_details_repository.dart';
import 'package:get/get.dart';

class OfficeDetailsController extends GetxController {
  final OfficeDetailsRepository _repository = OfficeDetailsRepository();

  final office = Rx<OfficeModel?>(null);
  final isLoading = RxBool(false);
  final hasError = RxBool(false);
  final errorMessage = RxString('');

  @override
  void onInit() {
    super.onInit();
    _loadOffice();
  }

  Future<void> _loadOffice() async {
    try {
      isLoading.value = true;
      hasError.value = false;

      if (Get.arguments is OfficeModel) {
        office.value = Get.arguments as OfficeModel;
      } else {
        final data = await _repository.getOffices();
        if (data.isNotEmpty) {
          office.value = data.first;
        } else {
          hasError.value = true;
          errorMessage.value = 'تعذر تحميل تفاصيل المكتب.';
        }
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'حدث خطأ في تحميل المكتب: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  void retry() => _loadOffice();
}
