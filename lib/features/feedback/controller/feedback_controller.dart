import 'package:dalili_app/features/feedback/data/feedback_repository.dart';
import 'package:dalili_app/features/feedback/data/model/feedback_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedbackController extends GetxController {
  late final FeedbackRepository _repository;

  final RxInt rating = 0.obs;
  final RxBool isSubmitting = false.obs;
  final RxString stageId = ''.obs;
  final RxString institutionId = ''.obs;
  final RxString officeId = ''.obs;
  final RxString stageName = ''.obs;
  final RxString institutionName = ''.obs;
  final RxString officeName = ''.obs;
  final complaintController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    _repository = Get.find<FeedbackRepository>();
    _loadArguments();
  }

  void _loadArguments() {
    final args = Get.arguments;
    if (args is Map) {
      stageId.value = '${args['stageId'] ?? ''}';
      institutionId.value = '${args['institutionId'] ?? ''}';
      officeId.value = '${args['officeId'] ?? ''}';
      stageName.value = '${args['stageName'] ?? ''}';
      institutionName.value = '${args['institutionName'] ?? ''}';
      officeName.value = '${args['officeName'] ?? ''}';
    }
  }

  Future<void> submitFeedback() async {
    if (rating.value < 1) {
      Get.snackbar(
        'خطأ',
        'يرجى اختيار تقييم قبل الإرسال',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isSubmitting.value = true;

    final feedback = FeedbackModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      stageId: stageId.value,
      institutionId: institutionId.value,
      officeId: officeId.value,
      stageName: stageName.value,
      institutionName: institutionName.value,
      officeName: officeName.value,
      rating: rating.value,
      complaintText: complaintController.text.trim().isEmpty
          ? null
          : complaintController.text.trim(),
      submittedAt: DateTime.now(),
    );

    await _repository.saveFeedback(feedback);
    isSubmitting.value = false;
    Get.snackbar(
      'نجاح',
      'تم إرسال تقييمك بنجاح',
      snackPosition: SnackPosition.BOTTOM,
    );
    Get.back();
  }

  @override
  void onClose() {
    complaintController.dispose();
    super.onClose();
  }
}
