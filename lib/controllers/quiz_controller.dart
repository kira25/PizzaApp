import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pizza_quiz/pages/Login/login_page.dart';
import 'package:pizza_quiz/repository/preferences_repository.dart';
import 'package:pizza_quiz/services/auth/auth_service.dart';
import 'package:pizza_quiz/services/rating/rating_service.dart';

class QuizController extends GetxController {
  var quizname = "";

  String emotion;

  double clientService;

  double teamwork;

  double confidence;

  double innovation;

  double attentionDetails;

  FocusNode quizFocus;



  PreferenceRepository _preferenceRepository = PreferenceRepository();
  RatingService _ratingService = RatingService();
  AuthService _authService = AuthService();

  void setQuizname(String quiz) async {
    await _preferenceRepository.setData('data', quiz);
    quizname = quiz;
    update(["quizname"]);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    quizFocus.dispose();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print('on init quiz controller');
    loadQuizname();
    quizFocus = FocusNode();
  }

  void loadQuizname() async {
    String data = await _preferenceRepository.getData("data");

    (data != null) ? quizname = data : quizname = "";
    emotion = "Bad";
    clientService = 3.0;
    teamwork = 3.0;
    confidence = 3.0;
    innovation = 3.0;
    attentionDetails = 3.0;
    update(["quizname"]);
  }

  void setEmotion(String value) {
    emotion = value;
    update();
  }

  void setClientService(double client) {
    clientService = client;
    print(clientService);
    update();
  }

  void setTeamWork(double client) {
    teamwork = client;
    print(teamwork);

    update();
  }

  void setConfidence(double value) {
    confidence = value;
    print(confidence);

    update();
  }

  void setInnovation(double value) {
    innovation = value;
    print(innovation);

    update();
  }

  void setAttentiondetails(double value) {
    attentionDetails = value;
    print(attentionDetails);
    print(quizname);
    update();
  }

  void sendQuiz(String displayname) async {
    String quizname = await _preferenceRepository.getData('data');
    _ratingService.createData(quizname, displayname, emotion, clientService,
        teamwork, confidence, innovation, attentionDetails);

    Get.defaultDialog(title: 'Completed',content: Icon(FontAwesomeIcons.check),);
    _authService.signOut();

    Future.delayed(Duration(milliseconds: 1500), () {
      Get.off(LoginPage(),curve: Curves.bounceIn);
    } );
  }
}