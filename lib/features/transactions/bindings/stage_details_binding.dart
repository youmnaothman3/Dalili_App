import 'package:dalili_app/features/transactions/controller/stage_details_controller.dart';
import 'package:get/get.dart';

class StageDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StageDetailsController>(() => StageDetailsController());
  }
}
