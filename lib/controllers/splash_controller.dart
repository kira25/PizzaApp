import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_quiz/pages/Admin/admin_page.dart';
import 'package:pizza_quiz/pages/Intro/intro_page.dart';
import 'package:pizza_quiz/pages/Quiz/quiz_page.dart';
import 'package:pizza_quiz/repository/preferences_repository.dart';
import 'package:pizza_quiz/services/auth/auth_service.dart';

class SplashController extends GetxController {
  AuthService _authService = AuthService();
  PreferenceRepository _preferenceRepository = PreferenceRepository();

  void authState() async {
    print('authstate');
    try {
      User currentUser = await _authService.getCurrentuser();
      print("current user : $currentUser");
      final user = await _preferenceRepository.getData("user");

      if (user != null) {
        if (user.contains('@admin.com')) {
          Get.to(AdminPage(), transition: Transition.fadeIn);
        } else {
          Get.to(QuizPage(), transition: Transition.fadeIn);
        }
      } else {
        Get.to(IntroPage(), transition: Transition.cupertino);
      }
    } catch (e) {
      print(e);
    }
  }



  @override
  void onInit() {
    print('on init splash');
    super.onInit();

    authState();
  }
}
