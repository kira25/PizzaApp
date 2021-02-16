import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_quiz/controllers/splash_controller.dart';
import 'package:pizza_quiz/utils/colors_fonts.dart';

class SplashPage extends StatefulWidget {




  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final c = Get.put(SplashController());

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    precacheImage(AssetImage('./assets/splash.png'), context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: klightlogincolor,
      body: Center(
        child: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Image.asset('./assets/splash.png')

            // child: LottieBuilder.network(
            //     'https://assets2.lottiefiles.com/packages/lf20_m29kLt.json'),
            ),
      ),
    );
  }
}
