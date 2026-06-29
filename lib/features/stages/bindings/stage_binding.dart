import 'package:dalili_app/features/stages/controller/stage_controller.dart';
import 'package:get/get.dart';

class StageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StageController>(() => StageController());
  }
}
