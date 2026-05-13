import 'package:dalili_app/features/institutions/controller/institution_details_controller.dart';
import 'package:get/get.dart';

class InstitutionDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InstitutionDetailsController>(() => InstitutionDetailsController());
  }
}
