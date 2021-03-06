import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_quiz/controllers/quiz_controller.dart';
import 'package:pizza_quiz/services/auth/auth_service.dart';

enum registerEnum { UNDEFINED, INVALID, VALID }

class RegisterController extends GetxController {
  var validEmail = registerEnum.UNDEFINED;
  var validPass = registerEnum.UNDEFINED;
  var isVisible = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode emailFocus;
  FocusNode passwordFocus;

  final quizctrl = Get.put(QuizController());

  AuthService _authService = AuthService();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
  }

  handleRegister(String email, String password) async {
    if (quizctrl.quizname.isNotEmpty) {
      Get.defaultDialog(
          title: 'Creando usuario...', content: CircularProgressIndicator());

      try {
        final user = await _authService.createAccount(email, password);
        print(user);
        return user;
      } catch (e) {
        Get.back();
        Get.defaultDialog(
            title: 'Creation fail',
            content: Center(child: Text('Account already exist')));
      }
    } else {
      Get.snackbar('Need to set a Quizname', '',
          snackPosition: SnackPosition.BOTTOM);
    }

    update();
  }

  void changeVisible() {
    isVisible = !isVisible;
    update();
  }

  void isEmail(String input) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(input.trim())) {
      validEmail = registerEnum.INVALID;
    } else {
      validEmail = registerEnum.VALID;
    }
    print(validEmail);
    print(input);
    update();
  }

  void isPassword(String input) {
    if (input.length > 4) {
      validPass = registerEnum.VALID;
    } else {
      validPass = registerEnum.INVALID;
    }
    update();
  }
}
