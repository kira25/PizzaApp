import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_quiz/controllers/login_controller.dart';
import 'package:pizza_quiz/controllers/quiz_controller.dart';
import 'package:pizza_quiz/pages/Login/login_page.dart';
import 'package:pizza_quiz/utils/SliderPainter.dart';
import 'package:pizza_quiz/utils/backgroundColorTween.dart';
import 'package:pizza_quiz/utils/colors_fonts.dart';
import 'package:pizza_quiz/utils/flareController.dart';
import 'package:pizza_quiz/utils/titleFeel.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart' as vector;

enum SlideState { Bad, Ok, Good }

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
  FlareRateController _flareRateController;
  AnimationController _animationController;
  double _dragPercent = 0.0;
  SlideState slideState = SlideState.Bad;
  IconData _selectedIcon;
  String emotion;
  double clientService;
  double teamWork;
  double confidence;
  double innovation;
  double attentionDetail;
  PageController _controller =
      new PageController(initialPage: 0, viewportFraction: 1.0);

  void updateDragPosition(Offset offset) {
    setState(() {
      _dragPercent = (offset.dx / 340).clamp(0.0, 1.0);
      _flareRateController.updatePercent(_dragPercent);
    });

    if (_dragPercent >= 0 && _dragPercent < .3) {
      slideState = SlideState.Bad;
      _animationController.forward(from: 0.0);
    } else if (_dragPercent >= .3 && _dragPercent < .7) {
      slideState = SlideState.Ok;
      _animationController.stop();
    } else if (_dragPercent > .7) {
      slideState = SlideState.Good;
    }
  }

  Widget dispTitle(double wp) {
    switch (slideState) {
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

  void _onDragStart(BuildContext context, DragStartDetails details) {
    RenderBox box = context.findRenderObject();
    Offset localOffset = box.localToGlobal(details.globalPosition);
    updateDragPosition(localOffset);
  }

  void _onDragUpdate(BuildContext context, DragUpdateDetails details) {
    RenderBox box = context.findRenderObject();
    Offset localOffset = box.localToGlobal(details.globalPosition);
    updateDragPosition(localOffset);
  }

  @override
  void initState() {
    super.initState();
    print('id : ${widget.id}');
    print('QuizPage');
    _flareRateController = FlareRateController();
    SystemChrome.setEnabledSystemUIOverlays([]);
    _animationController =
        AnimationController(duration: Duration(microseconds: 750), vsync: this)
          ..addListener(() {
            setState(() {});
          });
  }

  _shake() {
    double offset = math.sin(_animationController.value * math.pi * 60.0);
    return vector.Vector3(offset * 2, offset * 2, 0.0);
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;

    return AnimatedContainer(
      duration: Duration(seconds: 1),
      color: backgroundTween.evaluate(AlwaysStoppedAnimation(_dragPercent)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: PageView(
          allowImplicitScrolling: false,
          controller: _controller,
          physics: new NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: [
            //HOW DO YOU FEEL
            GetBuilder<QuizController>(
              builder: (controller) {
                return SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(
                          wp(3)),
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _appBar(wp, hp),
                        SizedBox(
                          height: hp(2),
                        ),
                        _headerText(wp),
                        SizedBox(
                          height: hp(3),
                        ),
                        _title(wp(6)),
                        SizedBox(
                          height: hp(4),
                        ),
                        _flareActor(wp(80), hp(60)),
                        SizedBox(
                          height: hp(4),
                        ),
                        _slider(50, 340),
                        SizedBox(
                          height: hp(7),
                        ),
                        Container(
                          width: wp(80),
                          height: hp(8),
                          margin: EdgeInsets.only(
                              left: wp(7), right: wp(7), top: hp(2)),
                          child: RaisedButton(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: kdarklogincolor,
                            onPressed: () {
                              if (slideState == SlideState.Bad) {
                                emotion = 'Bad';
                                print(emotion);
                                controller.setEmotion(emotion);
                                //controller_0To1.forward(from: 0.0);
                                goToRating();
                              } else if (slideState == SlideState.Ok) {
                                emotion = 'Ok';
                                controller.setEmotion(emotion);
                                print(emotion);
                                goToRating();
                              } else if (slideState == SlideState.Good) {
                                emotion = 'Good';
                                controller.setEmotion(emotion);
                                print(emotion);
                                goToRating();
                              } else {
                                return null;
                              }
                            },
                            child: Text(
                              "Next",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: wp(5),
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            //RATING
            GetBuilder<QuizController>(
              builder: (controller) {
                return SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(
                        wp(3)),
                   width: double.infinity,
                    height: hp(100),
                    color: kwhitecolor,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: [
                            IconButton(
                                iconSize: wp(7),
                                icon: Icon(Icons.arrow_back_ios),
                                onPressed: () => goToPrevious())
                          ],
                        ),
                        valores('Client Service', hp(3), clientService),
                        valores('Teamwork', hp(3), teamWork),
                        valores('Confidence', hp(3), confidence),
                        valores('Innovation', hp(3), innovation),
                        valores('Attention Details', hp(3), attentionDetail),
                        SizedBox(
                          height: hp(6),
                        ),
                        new Container(
                          width: wp(80),
                          height: hp(8),
                          margin: EdgeInsets.only(
                              left: wp(7), right: wp(7), top: hp(2)),
                          child: new RaisedButton(
                            elevation: 10,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            color: kdarklogincolor,
                            onPressed: () => controller.sendQuiz(widget.id),
                            child: Text(
                              "Send",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: wp(4),
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  goToPrevious() {
    //controller_minus1To0.reverse(from: 0.0);
    _controller.animateToPage(
      0,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInSine,
    );
  }

  Widget valores(String valor, double hp, double value) {
    return GetBuilder<QuizController>(
      builder: (controller) {
        return Container(
            child: Column(
          children: <Widget>[
            Text(
              valor,
              style: GoogleFonts.lato(fontSize: hp),
            ),
            SizedBox(
              height: hp,
            ),
            RatingBar.builder(
              initialRating: 3,
              unratedColor: Colors.grey[200],
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 10.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                switch (valor) {
                  case 'Client Service':
                    controller.setClientService(rating);
                    break;
                  case 'Teamwork':
                    controller.setTeamWork(rating);
                    break;
                  case 'Confidence':
                    controller.setConfidence(rating);
                    break;
                  case 'Innovation':
                    controller.setInnovation(rating);
                    break;
                  case 'Attention Details':
                    controller.setAttentiondetails(rating);
                    break;
                  default:
                }
              },
            ),
            SizedBox(
              height: hp * 0.6,
            )
          ],
        ));
      },
    );
  }

  goToRating() {
    _controller.animateToPage(
      1,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInSine,
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
                style: GoogleFonts.lato(fontSize: wp(8)),
              ),
            ),
          ],
        ),
      );

  _headerText(Function wp) => Text(
        'How do you feel today ?',
        style: GoogleFonts.lato(fontSize: wp(6)),
      );

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
            controller: _flareRateController,
          ),
        ),
      );

  _slider(double hp, double wp) => GestureDetector(
        onHorizontalDragStart: (details) => _onDragStart(context, details),
        onHorizontalDragUpdate: (details) => _onDragUpdate(context, details),
        child: Container(
          width: wp,
          height: hp,
          child: CustomPaint(
            painter: SliderPainter(progress: _dragPercent),
          ),
        ),
      );
}
