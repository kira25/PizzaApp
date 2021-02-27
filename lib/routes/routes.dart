import 'package:get/get.dart';
import 'package:pizza_quiz/bindings/admin_binding.dart';
import 'package:pizza_quiz/bindings/login_binding.dart';
import 'package:pizza_quiz/bindings/quiz_binding.dart';
import 'package:pizza_quiz/bindings/splash_bindings.dart';
import 'package:pizza_quiz/pages/Admin/admin_page.dart';
import 'package:pizza_quiz/pages/Intro/intro_page.dart';
import 'package:pizza_quiz/pages/Login/login_page.dart';
import 'package:pizza_quiz/pages/Quiz/quiz_page.dart';
import 'package:pizza_quiz/pages/SplashPage/splash_page.dart';

const SPLASH_PAGE = 'SPLASH_PAGE';
const INTRO_PAGE = 'INTRO_PAGE';
const LOGIN_PAGE = 'LOGIN_PAGE';
const ADMIN_PAGE = 'ADMIN_PAGE';
const QUIZ_PAGE = 'QUIZ_PAGE';

final List<GetPage> pages = [
  GetPage(
      name: SPLASH_PAGE, page: () => SplashPage(), binding: SplashBinding()),
  GetPage(
    name: INTRO_PAGE,
    page: () => IntroPage(),
  ),
  GetPage(name: LOGIN_PAGE, page: () => LoginPage(), binding: LoginBinding()),
  GetPage(name: ADMIN_PAGE, page: () => AdminPage(), binding: AdminBinding()),
  GetPage(name: QUIZ_PAGE, page: () => QuizPage(), binding: QuizBinding()),
];
