import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pizza_quiz/utils/colors_fonts.dart';

class RegisterBackGround extends CustomPainter {

  RegisterBackGround({Animation<double>animation})
      :blueAnim = CurvedAnimation(
      parent: animation,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeInCirc),
        greyAnim = CurvedAnimation(
            parent: animation,
            curve: Curves.easeIn,
            reverseCurve: Curves.easeInCirc),
        super(repaint: animation);


  final Animation<double> blueAnim;
  final Animation<double> greyAnim;

  @override
  void paint(Canvas canvas, Size size) {
    var sw = size.width;
    var sh = size.height;
    var paint = Paint();

    Path mainbackground = Path();
    mainbackground.addRect(Rect.fromLTRB(0, 0, sw, sh));
    paint.color = Colors.white;
    canvas.drawPath(mainbackground, paint);

    Path blueWave = Path();
    blueWave.lineTo(sw, 0);
    blueWave.lineTo(sw, sh * 0.6);
    blueWave.cubicTo(sw * 0.85, sh * 0.75, sw * 0.50,
        lerpDouble(sh, sh * 0.75, blueAnim.value), sw * 0.3, sh);
    blueWave.lineTo(0, sh);

    blueWave.close();
    paint.color = kbluelogincolor;
    canvas.drawPath(blueWave, paint);

    Path greyWave = Path();
    greyWave.lineTo(sw, 0);
    greyWave.lineTo(sw, sh * 0.3);
    greyWave.cubicTo(sw * 0.85, sh * 0.45, sw * 0.20,
        lerpDouble(sh * 0.8, sh * 0.35, greyAnim.value), 0, sh * 0.5);
    greyWave.close();
    paint.color = kdarklogincolor;
    canvas.drawPath(greyWave, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
