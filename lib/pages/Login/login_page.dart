import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_quiz/controllers/login_controller.dart';
import 'package:pizza_quiz/controllers/quiz_controller.dart';
import 'package:pizza_quiz/pages/ForgotPassword/forgotpassword_page.dart';
import 'package:pizza_quiz/pages/Intro/intro_page.dart';
import 'package:pizza_quiz/pages/Login/components/body.dart';
import 'package:pizza_quiz/pages/Register/register_page.dart';
import 'package:pizza_quiz/utils/colors_fonts.dart';
import 'package:pizza_quiz/utils/innerShadow.dart';
import 'package:pizza_quiz/utils/login_background.dart';
import 'package:pizza_quiz/widgets/TextFieldWidget.dart';
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
