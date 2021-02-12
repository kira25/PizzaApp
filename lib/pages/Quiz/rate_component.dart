import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_quiz/controllers/quiz_controller.dart';
import 'package:pizza_quiz/utils/colors_fonts.dart';

class RateComponent extends StatelessWidget {
  final Function hp;
  final Function wp;
  final PageController controller;
  final String id;

  RateComponent({Key key, this.hp, this.wp, this.controller, this.id});

  goToPrevious() {
    //controller_minus1To0.reverse(from: 0.0);
    controller.animateToPage(
      0,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInSine,
    );
  }

  double clientService;
  double teamWork;
  double confidence;
  double innovation;
  double attentionDetail;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizController>(
      builder: (controller) {
        return Container(
          constraints: BoxConstraints(
              maxHeight: double.infinity, maxWidth: double.infinity),
          color: kwhitecolor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: IconButton(
                    padding: EdgeInsets.only(left: wp(6),top: hp(3)),
                    iconSize: wp(7),
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () => goToPrevious()),
              ),

              valores('Client Service', hp, wp),
              SizedBox(height: hp(3),),
              valores('Teamwork', hp, wp),
              SizedBox(height: hp(3),),
              valores('Confidence', hp, wp),
              SizedBox(height: hp(3),),
              valores('Innovation', hp, wp),
              SizedBox(height: hp(3),),
              valores('Attention Details', hp, wp),
              SizedBox(
                height: hp(4),
              ),
              new Container(
                width: wp(80),
                height: hp(8),
                margin: EdgeInsets.only(left: wp(7), right: wp(7), top: hp(2)),
                child: new RaisedButton(
                  elevation: 10,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  color: kdarklogincolor,
                  onPressed: () => controller.sendQuiz(id),
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
        );
      },
    );
  }

  Widget valores(String valor, Function hp, Function wp) {
    return GetBuilder<QuizController>(
      builder: (controller) {
        return Container(
            child: Column(
          children: <Widget>[
            Text(
              valor,
              style: GoogleFonts.lato(fontSize: wp(4),fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: hp(3),
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
          ],
        ));
      },
    );
  }
}
