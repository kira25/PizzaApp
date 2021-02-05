import 'package:get/get.dart';
import 'package:pizza_quiz/controllers/splash_controller.dart';

class SplashBinding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => SplashController());

  }




}