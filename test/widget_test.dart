import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_quiz/controllers/login_controller.dart';
import 'package:pizza_quiz/main.dart';
import 'package:pizza_quiz/pages/Intro/intro_page.dart';
import 'package:pizza_quiz/pages/Login/login_page.dart';
import 'package:test/test.dart';

void main() {
  final loginctrl = Get.put(LoginController());

  Firebase.initializeApp();

  test('Empty Email Test', () {

    print('working');
  });
}
