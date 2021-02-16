import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:pizza_quiz/controllers/login_controller.dart';
import 'package:pizza_quiz/controllers/quiz_controller.dart';
import 'package:pizza_quiz/pages/Login/components/body.dart';
import 'package:responsive_screen/responsive_screen.dart';

class LoginPage extends StatelessWidget {
  final qcontroller = Get.put(QuizController());

  final loginctrl = Get.put(LoginController());

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _quiznameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;

    return Scaffold(
      body: KeyboardVisibilityProvider(
          child: SignInForm(
              wp: wp,
              hp: hp,
              quizctrl: qcontroller,
              quiznameController: _quiznameController,
              emailController: _emailController,
              passwordController: _passwordController)),
    );
  }
}
