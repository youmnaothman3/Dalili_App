import 'package:dalili_app/features/institutions/controller/institutions_controller.dart';
import 'package:get/get.dart';

class InstitutionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InstitutionsController());
  }
}
