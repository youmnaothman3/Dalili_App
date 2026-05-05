import 'package:dalili_app/features/sign_up/contrller/sign_up_controller.dart';
import 'package:get/get.dart';

class SignUpData {
  final String fullName;
  final String birthDate;
  final String phone;
  final String password;

  SignUpData({
    required this.fullName,
    required this.birthDate,
    required this.phone,
    required this.password,
  });
}

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController());
  }
}
