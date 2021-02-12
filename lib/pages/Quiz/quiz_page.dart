import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_quiz/controllers/login_controller.dart';
import 'package:pizza_quiz/controllers/quiz_controller.dart';
import 'package:pizza_quiz/pages/Login/login_page.dart';
import 'package:pizza_quiz/pages/Quiz/feel_component.dart';
import 'package:pizza_quiz/pages/Quiz/rate_component.dart';
import 'package:pizza_quiz/utils/SliderPainter.dart';
import 'package:pizza_quiz/utils/backgroundColorTween.dart';
import 'package:pizza_quiz/utils/colors_fonts.dart';
import 'package:pizza_quiz/utils/flareController.dart';
import 'package:pizza_quiz/utils/titleFeel.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart' as vector;

class QuizPage extends StatefulWidget {
  final String id;

  const QuizPage({Key key, this.id}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage>
    with SingleTickerProviderStateMixin {
  final loginctrl = Get.put(LoginController());
  final quizctrl = Get.put(QuizController());
  double _dragPercent = 0.0;
  FlareRateController _flareRateController;
  SlideState slideState = SlideState.Bad;
  AnimationController _animationController;

  IconData _selectedIcon;
  double clientService;
  double teamWork;
  double confidence;
  double innovation;
  double attentionDetail;
  PageController _controller =
      new PageController(initialPage: 0, viewportFraction: 1.0);

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;

    return GetBuilder<QuizController>(builder: (controller) {
      return AnimatedContainer(
        duration: Duration(seconds: 1),
        color: backgroundTween
            .evaluate(AlwaysStoppedAnimation(controller.dragPercent)),
        child: Scaffold(
          backgroundColor: Colors.transparent,

          body: PageView(

            allowImplicitScrolling: false,
            controller: _controller,
            physics: new NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: [
              //HOW DO YOU FEEL
              FeelComponent(
                controller: _controller,
                hp: hp,
                wp: wp,
                quizctrl: quizctrl,
              ),
              //RATING
              RateComponent(
                wp: wp,
                hp: hp,
                controller: _controller,
                id: widget.id,
              )
            ],
          ),
        ),
      );
    });
  }
}
