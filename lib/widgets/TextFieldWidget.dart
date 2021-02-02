import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_quiz/controllers/login_controller.dart';
import 'package:pizza_quiz/utils/colors_fonts.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController editingController;
  final controller;
  final bool isPassword;
  final Function onChange;
  final String errorText;
  final String hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool isRegister;
  final FocusNode focus;
  final Function onSubmitted;
  final Key keyTesting;

  const TextFieldWidget({

    this.controller,
    this.isPassword,
    this.onChange,
    this.errorText,
    this.hintText,
    this.keyboardType,
    this.textInputAction,
    this.editingController,
    this.isRegister = false,
    this.focus, this.onSubmitted, this.keyTesting,
  }) ;

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      key:  keyTesting,
      onFieldSubmitted: onSubmitted ,
      focusNode: focus,
      controller: editingController,
      obscureText: isPassword ? controller.isVisible : false,
      onChanged: onChange,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      style: isRegister
          ? GoogleFonts.lato(color: kwhitecolor)
          : GoogleFonts.lato(color: kdarklogincolor),
      decoration: InputDecoration(
        suffix: isPassword
            ? InkWell(
                onTap: () => controller.changeVisible(),
                child: controller.isVisible
                    ? Icon(Icons.visibility_off, color: Colors.grey)
                    : Icon(Icons.visibility, color: Colors.grey))
            : null,
        errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0)),
        errorText: errorText,
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0)),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        labelText: hintText,
        labelStyle: isRegister
            ? GoogleFonts.lato(color: kwhitecolor)
            : GoogleFonts.lato(),
      ),
    );
  }
}
