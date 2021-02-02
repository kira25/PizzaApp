import 'package:get/get.dart';
import 'package:pizza_quiz/controllers/login_controller.dart';
import 'package:pizza_quiz/controllers/register_controller.dart';

class RegisterBinding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => RegisterController());
    Get.lazyPut(() => LoginController());
  }


}