import 'package:get/get.dart';
import 'package:pizza_quiz/controllers/admin_controller.dart';
import 'package:pizza_quiz/controllers/login_controller.dart';

class AdminBinding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut(() => AdminController());
    Get.lazyPut(() => LoginController());
  }


}