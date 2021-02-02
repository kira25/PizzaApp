import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_quiz/utils/colors_fonts.dart';

final state = ['Hideous', "OK", "Good"];

chooseTitle(double wp, int numberText) {
  var currText = [
    Text(state[0],
        key: Key(state[0]),
        style: GoogleFonts.lato(fontSize: wp,color: kdarklogincolor) ) ,
    Text(state[1],
        key: Key(state[1]),
        style:  GoogleFonts.lato(fontSize: wp,color: kdarklogincolor) ),
    Text(state[2],
        key: Key(state[2]),
        style:  GoogleFonts.lato(fontSize: wp,color: kdarklogincolor) ),
  ];

  return currText[numberText];
}
