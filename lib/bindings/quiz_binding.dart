import 'package:get/get.dart';
import 'package:pizza_quiz/controllers/quiz_controller.dart';

class QuizBinding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => QuizController());

  }


}