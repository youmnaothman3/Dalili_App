import 'package:dalili_app/features/transactions/controller/office_details_controller.dart';
import 'package:get/get.dart';

class OfficeDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OfficeDetailsController>(() => OfficeDetailsController());
  }
}
