import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pizza_quiz/utils/colors_fonts.dart';

class LoginBackGround extends CustomPainter {
  final bool keyboard;

  LoginBackGround(this.keyboard, {Animation<double> animation})
      : liquidAnim = CurvedAnimation(
      curve: Curves.elasticInOut,
      reverseCurve: Curves.easeInBack,
      parent: animation),
        darkAnim = CurvedAnimation(
            parent: animation,
            curve: Curves.easeIn,
            reverseCurve: Curves.easeInCirc),
        yellowAnim = CurvedAnimation(
            parent: animation,
            curve: Curves.easeIn,
            reverseCurve: Curves.easeInCirc),
        blueAnim = CurvedAnimation(
            parent: animation,
            curve: Curves.easeIn,
            reverseCurve: Curves.easeInCirc),
        super(repaint: animation);

  final Animation<double> yellowAnim;
  final Animation<double> blueAnim;
  final Animation<double> darkAnim;
  final Animation<double> liquidAnim;

  @override
  void paint(Canvas canvas, Size size) {
    var sw = size.width;
    var sh = keyboard== true ? size.height*0.7 : size.height;
    var paint = Paint();

    Path mainbackground = Path();

    mainbackground.addRect(Rect.fromLTRB(0, 0, sw, sh));
    paint.color = kwhitecolor;
    canvas.drawPath(mainbackground, paint);




    Path blueWave = Path();
    blueWave.lineTo(sw, 0);
    blueWave.lineTo(sw, sh * 0.35);
    blueWave.quadraticBezierTo(
        sw * 0.5, lerpDouble(sh*0.9, sh * 0.45, blueAnim.value), 0, 0);
    paint.color = kbluelogincolor;
    canvas.drawPath(blueWave, paint);

    Path darkWave = Path();
    darkWave.lineTo(sw, 0);
    darkWave.lineTo(sw, sh * 0.15);
    darkWave.cubicTo(sw * 0.6, sh * 0.25, sw * 0.8,
        lerpDouble(sh*0.7, sh * 0.45, darkAnim.value), 0, sh * 0.35);
    darkWave.lineTo(0, sh);

    darkWave.close();
    paint.color = kdarklogincolor;
    canvas.drawPath(darkWave, paint);

    Path yellowWave = Path();
    yellowWave.lineTo(sw * 0.8, 0);

    yellowWave.cubicTo(sw * 0.08, sh * 0.03, sw * 0.25,
        lerpDouble(sh*0.4, sh * 0.15, yellowAnim.value), 0, sh * 0.20);

    // greyWave.cubicTo(sw * 0.52, sh * 0.52, sw * 0.05, sh * 0.45, 0, sh * 0.6);
    yellowWave.close();
    paint.color = klightlogincolor;
    canvas.drawPath(yellowWave, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}