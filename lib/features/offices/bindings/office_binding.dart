import 'package:dalili_app/features/offices/controller/office_controller.dart';
import 'package:get/get.dart';

class OfficeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OfficeController>(() => OfficeController());
  }
}
