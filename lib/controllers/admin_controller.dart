import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_quiz/models/quiztest.dart';
import 'package:pizza_quiz/models/rating.dart';
import 'package:pizza_quiz/repository/preferences_repository.dart';
import 'package:pizza_quiz/services/rating/rating_service.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AdminController extends GetxController {
  PreferenceRepository _preferenceRepository = PreferenceRepository();
  String quizname;
  var loading = false;
  var seriesList = List<charts.Series<QuizTest, String>>();
  var seriesListFeeling = List<charts.Series<QuizTest, String>>();
  var data;
  var datafeeling;

  //SERVICES
  RatingService _ratingService = RatingService();

  void pieData() async{
  print('piedata');
  print(seriesList);

    int sumFeelingsBad = 0;
    int sumFeelingsOk = 0;
    int sumFeelingsGood = 0;
  data = await _ratingService.readData();
     print('data2 post : $data');
  data.forEach((element) {
      if (element.feelings == "Ok") {
        sumFeelingsOk++;
      } else if (element.feelings == "Bad") {
        sumFeelingsBad++;
      } else if (element.feelings == "Good") {
        sumFeelingsGood++;
      } else {
        return null;
      }
    });

    List<QuizTest> listfeeling = [
      QuizTest(
          color: charts.ColorUtil.fromDartColor(Colors.orange),
          legend: 'Ok',
          values: sumFeelingsOk),
      QuizTest(
          color: charts.ColorUtil.fromDartColor(Colors.redAccent),
          legend: 'Bad',
          values: sumFeelingsBad),
      QuizTest(
          color: charts.ColorUtil.fromDartColor(Colors.green),
          legend: 'Good',
          values: sumFeelingsGood),
    ];

    seriesListFeeling.addAll([
      charts.Series(
        data: listfeeling,
        id: 'Quiz of Feeling',
        measureFn: (QuizTest data, index) => data.values,
        domainFn: (QuizTest data, index) => data.legend,
        colorFn: (datum, index) => datum.color,
      ),
    ]);
    update();
  }

  void barData() async{

    print('barData');

    int sumAttentionDetails = 0;
    int sumInnovation = 0;
    int sumConfidence = 0;
    int sumClientService = 0;
    int sumTeamWork = 0;


    datafeeling = await _ratingService.readData();


    datafeeling.forEach((element) {
      sumAttentionDetails += element.attentionDetails.toInt();
      sumInnovation += element.innovation.toInt();
      sumConfidence += element.confidence.toInt();
      sumClientService += element.clienteService.toInt();
      sumTeamWork += element.teamWork.toInt();
    });
    List<QuizTest> list = [
      QuizTest(
          color: charts.ColorUtil.fromDartColor(Colors.green),
          legend: 'Attention',
          values: sumAttentionDetails),
      QuizTest(
          color: charts.ColorUtil.fromDartColor(Colors.blue),
          legend: 'Innovation',
          values: sumInnovation),
      QuizTest(
          color: charts.ColorUtil.fromDartColor(Colors.yellow),
          legend: 'TeamWork',
          values: sumTeamWork),
      QuizTest(
          color: charts.ColorUtil.fromDartColor(Colors.red),
          legend: 'Confidence',
          values: sumConfidence),
      QuizTest(
          color: charts.ColorUtil.fromDartColor(Colors.orange),
          legend: 'Service',
          values: sumClientService),
    ];

    seriesList.addAll([
      charts.Series(
        data: list,
        id: 'Quiz of Feeling',
        measureFn: (QuizTest data, index) => data.values,
        domainFn: (QuizTest data, index) => data.legend,
        colorFn: (datum, index) => datum.color,
      ),
    ]);

    update();
  }

  @override
  void onInit() {
    super.onInit();
    print('on init admin');
    barData();
    pieData();




  }


}
