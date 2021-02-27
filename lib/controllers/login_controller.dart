import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_quiz/controllers/quiz_controller.dart';
import 'package:pizza_quiz/pages/Admin/admin_page.dart';
import 'package:pizza_quiz/pages/ForgotPassword/forgotpassword_page.dart';
import 'package:pizza_quiz/pages/Quiz/quiz_page.dart';
import 'package:pizza_quiz/pages/Register/register_page.dart';
import 'package:pizza_quiz/repository/preferences_repository.dart';
import 'package:pizza_quiz/services/auth/auth_service.dart';
import 'package:pizza_quiz/utils/colors_fonts.dart';

enum loginEnum { UNDEFINED, VALID, INVALID }
enum auth { BAD, ADMIN, USER }

class LoginController extends GetxController {
  var email = loginEnum.UNDEFINED;
  var password = loginEnum.UNDEFINED;
  var isVisible = true;
  var loading = false;
  var loadinguser = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final quizctrl = Get.put(QuizController());

  FocusNode emailFocus;
  FocusNode passwordFocus;

  AuthService _authService = AuthService();
  PreferenceRepository _preferenceRepository = PreferenceRepository();

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

  void changeVisible() {
    isVisible = !isVisible;
    update();
  }

  Future<void> signInAnonymously() async {
    if (quizctrl.quizname.isNotEmpty) {
      try {
        emailController.clear();
        passwordController.clear();
        email = loginEnum.UNDEFINED;
        password = loginEnum.UNDEFINED;
        Get.defaultDialog(
            title: 'Accediendo...', content: CircularProgressIndicator());
        User user = await _authService.signInAnonymus();
        print(user);
        Get.back();
        _preferenceRepository.setData("user", user.uid);
        Get.to(QuizPage(
          id: user.uid,
        ));
      } catch (e) {
        Get.back();
        Get.defaultDialog(
            backgroundColor: kaccentcolor,
            titleStyle: GoogleFonts.lato(color: kwhitecolor,fontWeight: FontWeight.bold),
            title: 'Fail access',
            content: Text(
              'Check your connection',
              style: GoogleFonts.lato(color: kwhitecolor),
            ));
      }
    } else {
      Get.snackbar('Need to set a Quizname', '',
          snackPosition: SnackPosition.BOTTOM);
    }

    update();
  }

  void isEmail(String input) {
    print(input);
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(input))
      email = loginEnum.INVALID;
    else
      email = loginEnum.VALID;
    update();
  }

  void isPassword(String input) {
    print(input);
    if (input.length > 4) {
      password = loginEnum.VALID;
    } else {
      password = loginEnum.INVALID;
    }
    update();
  }

  signOut() {
    _authService.signOut();
    _preferenceRepository.clearUser();
  }

  void gotoForgotPassword() {
    emailController.clear();
    passwordController.clear();
    email = loginEnum.UNDEFINED;
    password = loginEnum.UNDEFINED;
    Get.off(ForgotPasswordPage(),
        curve: Curves.easeIn,
        transition: Transition.fadeIn,
        duration: Duration(milliseconds: 500));
    update();
  }

  void goToRegister() {
    emailController.clear();
    passwordController.clear();
    email = loginEnum.UNDEFINED;
    password = loginEnum.UNDEFINED;
    Get.off(RegisterPage(),
        curve: Curves.easeIn,
        transition: Transition.fadeIn,
        duration: Duration(milliseconds: 500));

    update();
  }

  handleLogin(String username, String loginpassword) async {
    if (quizctrl.quizname.isNotEmpty) {
      try {
        Get.defaultDialog(
            radius: 20,
            title: 'Verificando...',
            content: CircularProgressIndicator());
        print('loading : $loading');
        User user = await _authService.signInWithEmailAndPassword(
            username, loginpassword);

        if (user != null) {
          emailController.clear();
          passwordController.clear();
          email = loginEnum.UNDEFINED;
          password = loginEnum.UNDEFINED;
          _preferenceRepository.setData("user", user.email);
          if (user.email.contains("@admin.com")) {
            // push new authentication event

            Get.to(AdminPage());

            print('Login :No data in Admin');
          } else {
            // push new authentication event

            Get.to(QuizPage(
              id: user.uid,
            ));
          }
        } else {
          Get.back();
          Get.snackbar('Bad credentials', '',
              snackPosition: SnackPosition.BOTTOM);
        }
      } catch (e) {
        Get.snackbar(e.toString(), '', snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      Get.snackbar('Need to set a Quizname', '',
          snackPosition: SnackPosition.BOTTOM);
    }

    update();
  }
}
