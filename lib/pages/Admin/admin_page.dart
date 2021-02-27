import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_quiz/controllers/admin_controller.dart';
import 'package:pizza_quiz/controllers/login_controller.dart';
import 'package:pizza_quiz/controllers/quiz_controller.dart';
import 'package:pizza_quiz/pages/Login/login_page.dart';
import 'package:pizza_quiz/utils/colors_fonts.dart';
import 'package:responsive_screen/responsive_screen.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> with TickerProviderStateMixin {
  final loginctrl = Get.put(LoginController());
  final admin = Get.put(AdminController());
  final quizctrl = Get.put(QuizController());

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;

    TabController _tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 4,
        leading: GetBuilder<LoginController>(builder: (loginctrl) {
          return IconButton(
              iconSize: wp(7),
              color: kdarklogincolor,
              icon: Icon(Icons.close),
              onPressed: () {
                loginctrl.signOut();
                Get.off(LoginPage());
              });
        }),
        bottom: TabBar(controller: _tabController, tabs: [
          Tab(
            icon: Icon(
              FontAwesomeIcons.solidChartBar,
              color: kdarkprimarycolor,
            ),
          ),
          Tab(
            icon: Icon(
              FontAwesomeIcons.chartPie,
              color: kdarkprimarycolor,
            ),
          ),
        ]),
        title: Text(
          'Welcome Admin',
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(color: kdarkprimarycolor, fontSize: wp(5)),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          GetBuilder<AdminController>(builder: (controller) {
            return controller.seriesList.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    child: charts.BarChart(
                      controller.seriesList,
                      animate: true,
                      behaviors: [
                        charts.DatumLegend(
                          position: charts.BehaviorPosition.bottom,
                          horizontalFirst: false,
                          showMeasures: true,
                          legendDefaultMeasure:
                              charts.LegendDefaultMeasure.firstValue,
                          measureFormatter: (measure) {
                            return measure == null ? '-' : '$measure';
                          },
                        )
                      ],
                    ),
                  );
          }),
          GetBuilder<AdminController>(builder: (controller) {
            return controller.seriesListFeeling.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    child: charts.PieChart(
                      controller.seriesListFeeling,
                      animate: true,
                      behaviors: [
                        charts.DatumLegend(
                          position: charts.BehaviorPosition.bottom,
                          horizontalFirst: false,
                          showMeasures: true,
                          legendDefaultMeasure:
                              charts.LegendDefaultMeasure.firstValue,
                          measureFormatter: (measure) {
                            return measure == null ? '-' : '$measure';
                          },
                        )
                      ],
                    ),
                  );
          }),
        ],
      ),
    );
  }
}
