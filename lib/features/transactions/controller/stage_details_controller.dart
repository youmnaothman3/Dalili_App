import 'package:dalili_app/features/transactions/data/model/stage_model.dart';
import 'package:dalili_app/features/transactions/data/stage_details_repository.dart';
import 'package:get/get.dart';

class StageDetailsController extends GetxController {
  final StageDetailsRepository _repository = StageDetailsRepository();

  final stage = Rx<StageModel?>(null);
  final isLoading = RxBool(false);
  final hasError = RxBool(false);
  final errorMessage = RxString('');

  @override
  void onInit() {
    super.onInit();
    _loadStage();
  }

  Future<void> _loadStage() async {
    try {
      isLoading.value = true;
      hasError.value = false;

      if (Get.arguments is StageModel) {
        stage.value = Get.arguments as StageModel;
      } else {
        final data = await _repository.getStages();
        if (data.isNotEmpty) {
          stage.value = data.first;
        } else {
          hasError.value = true;
          errorMessage.value = 'تعذر تحميل تفاصيل المرحلة.';
        }
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'حدث خطأ في تحميل المرحلة: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  void retry() => _loadStage();
}
