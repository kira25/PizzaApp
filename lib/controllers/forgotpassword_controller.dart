import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pizza_quiz/services/auth/auth_service.dart';

enum loginEnum { UNDEFINED, VALID, INVALID }

class ForgotPasswordController extends GetxController {
  var email = loginEnum.UNDEFINED;
  FocusNode emailFocus;
  AuthService _authService = AuthService();

  void isEmail(String input) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(input))
      email = loginEnum.INVALID;
    else
      email = loginEnum.VALID;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    emailFocus = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailFocus.dispose();
  }

  void sendEmail(String email) async{
    try {
      Get.defaultDialog(
          title: 'Enviando...', content: CircularProgressIndicator());
      await _authService.sendPasswordResetEmail(email);
      Get.back();
      Get.defaultDialog(
          title: 'Enviado', content: Icon(FontAwesomeIcons.checkCircle));
    } catch (e) {
      Get.defaultDialog(
          title: 'Something goes wrong...', content: Icon(FontAwesomeIcons.sadCry));
    }
  }
}
