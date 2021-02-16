import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_quiz/controllers/login_controller.dart';
import 'package:pizza_quiz/controllers/quiz_controller.dart';
import 'package:pizza_quiz/pages/Login/login_page.dart';
import 'package:pizza_quiz/utils/SliderPainter.dart';
import 'package:pizza_quiz/utils/colors_fonts.dart';
import 'package:pizza_quiz/utils/flareController.dart';
import 'package:pizza_quiz/utils/titleFeel.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart' as vector;

class FeelComponent extends StatefulWidget {
  final Function hp;
  final Function wp;
  final PageController controller;
  final QuizController quizctrl;

  FeelComponent({Key key, this.hp, this.wp, this.controller, this.quizctrl});

  @override
  _FeelComponentState createState() => _FeelComponentState();
}

class _FeelComponentState extends State<FeelComponent>
    with SingleTickerProviderStateMixin {
  String emotion;
  final loginctrl = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    print('QuizPage');

    widget.quizctrl.animationController =
        AnimationController(duration: Duration(microseconds: 750), vsync: this)
          ..addListener(() {
            setState(() {});
          });
  }

  goToRating() {
    widget.controller.animateToPage(
      1,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInSine,
    );
  }

  Widget dispTitle(double wp) {
    switch (widget.quizctrl.slideState) {
      case SlideState.Bad:
        return chooseTitle(wp, 0);
        break;
      case SlideState.Ok:
        return chooseTitle(wp, 1);
        break;
      case SlideState.Good:
        return chooseTitle(wp, 2);
        break;
      default:
        return null;
    }
  }

  Widget build(BuildContext context) {
    return GetBuilder<QuizController>(
      builder: (controller) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: widget.wp(3)),
          constraints: BoxConstraints(
              maxHeight: double.infinity, maxWidth: double.infinity),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _appBar(widget.wp, widget.hp),
              SizedBox(
                height: widget.hp(6),
              ),
              _headerText(widget.wp),
              SizedBox(
                height: widget.hp(3),
              ),
              _title(widget.wp(6)),
              SizedBox(
                height: widget.hp(2),
              ),
              _flareActor(widget.wp(60), widget.hp(60)),
              SizedBox(
                height: widget.hp(4),
              ),
              _slider(widget.hp(5), widget.wp(80)),
              SizedBox(
                height: widget.hp(6),
              ),
              Container(
                width: widget.wp(80),
                height: widget.hp(8),
                margin: EdgeInsets.only(
                    left: widget.wp(7), right: widget.wp(7), top: widget.hp(2)),
                child: RaisedButton(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: kdarklogincolor,
                  onPressed: () {
                    if (widget.quizctrl.slideState == SlideState.Bad) {
                      emotion = 'Bad';
                      controller.setEmotion(emotion);
                      //controller_0To1.forward(from: 0.0);
                      goToRating();
                    } else if (widget.quizctrl.slideState == SlideState.Ok) {
                      emotion = 'Ok';
                      controller.setEmotion(emotion);
                      goToRating();
                    } else if (widget.quizctrl.slideState == SlideState.Good) {
                      emotion = 'Good';
                      controller.setEmotion(emotion);
                      goToRating();
                    } else {
                      return null;
                    }
                  },
                  child: Text(
                    "Next",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: widget.wp(5),
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _appBar(Function wp, Function hp) => Container(
        height: hp(6),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                  icon: Icon(
                    Icons.close,
                    size: wp(7),
                  ),
                  onPressed: () {
                    loginctrl.signOut();
                    Get.off(LoginPage());
                  }),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Good day',
                style: GoogleFonts.lato(
                    fontSize: wp(8), fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );

  _headerText(Function wp) => Text(
        'How do you feel today ?',
        style: GoogleFonts.lato(fontSize: wp(6)),
      );

  _shake() {
    double offset =
        math.sin(widget.quizctrl.animationController.value * math.pi * 60.0);
    return vector.Vector3(offset * 2, offset * 2, 0.0);
  }

  _title(double wp) => AnimatedSwitcher(
      duration: Duration(milliseconds: 200),
      transitionBuilder: (child, animation) {
        var slideAnim = Tween<Offset>(begin: Offset(-2, 0), end: Offset(0, 0))
            .animate(animation);
        return SlideTransition(
          position: slideAnim,
          child: child,
        );
      },
      child: dispTitle(wp));

  _flareActor(double hp, double wp) => Transform(
        transform: Matrix4.translation(_shake()),
        child: SizedBox(
          height: hp,
          width: wp,
          child: FlareActor(
            'assets/face.flr',
            artboard: 'Artboard',
            controller: widget.quizctrl.flareRateController,
          ),
        ),
      );

  _slider(double hp, double wp) => GestureDetector(
        onHorizontalDragStart: (details) =>
            widget.quizctrl.onDragStart(context, details),
        onHorizontalDragUpdate: (details) =>
            widget.quizctrl.onDragUpdate(context, details),
        child: Container(
          width: wp,
          height: hp,
          child: CustomPaint(
            painter: SliderPainter(progress: widget.quizctrl.dragPercent),
          ),
        ),
      );
}
