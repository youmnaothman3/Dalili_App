import 'package:dalili_app/features/my_transactions/controller/my_transactions_controller.dart';
import 'package:get/get.dart';

class MyTransactionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyTransactionsController>(() => MyTransactionsController());
  }
}
