import 'package:dalili_app/core/services/progress_service.dart';
import 'package:dalili_app/features/stages/data/stage_repository.dart';
import 'package:dalili_app/features/transactions/data/model/stage_model.dart';
import 'package:get/get.dart';

class StageController extends GetxController {
  final StageRepository _repository = StageRepository();
  final ProgressService _progressService = Get.find<ProgressService>();

  final stage = Rx<StageModel?>(null);
  final isLoading = RxBool(false);
  final hasError = RxBool(false);
  final errorMessage = RxString('');
  final transactionId = RxString('');
  final stageId = RxString('');
  final isStageCompleted = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    _loadStageById();
  }

  Future<void> _loadStageById() async {
    try {
      isLoading.value = true;
      hasError.value = false;

      final args = Get.arguments;
      if (args is Map) {
        stageId.value = '${args['stageId'] ?? ''}';
        transactionId.value = '${args['transactionId'] ?? ''}';
      }

      if (stageId.value.isEmpty) {
        hasError.value = true;
        errorMessage.value = 'معرف المرحلة غير صالح.';
        return;
      }

      final result = await _repository.getStageById(stageId.value);
      if (result != null) {
        stage.value = result;
        isStageCompleted.value = transactionId.value.isEmpty
            ? false
            : _progressService.isStageCompleted(
                transactionId.value,
                stageId.value,
              );
      } else {
        hasError.value = true;
        errorMessage.value = 'تعذر العثور على المرحلة.';
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'حدث خطأ: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleStageCompletion() async {
    if (transactionId.value.isEmpty || stageId.value.isEmpty) {
      return;
    }

    await _progressService.toggleStageCompleted(
      transactionId.value,
      stageId.value,
    );
    isStageCompleted.value = _progressService.isStageCompleted(
      transactionId.value,
      stageId.value,
    );
  }

  void retry() => _loadStageById();
}
