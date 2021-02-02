import 'package:get/get.dart';
import 'package:pizza_quiz/controllers/forgotpassword_controller.dart';

class LoginBinding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => ForgotPasswordController());

  }


}