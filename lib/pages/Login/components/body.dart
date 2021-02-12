import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_quiz/controllers/login_controller.dart';
import 'package:pizza_quiz/controllers/quiz_controller.dart';
import 'package:pizza_quiz/pages/ForgotPassword/forgotpassword_page.dart';
import 'package:pizza_quiz/pages/Intro/intro_page.dart';
import 'package:pizza_quiz/pages/Register/register_page.dart';
import 'package:pizza_quiz/utils/colors_fonts.dart';
import 'package:pizza_quiz/utils/innerShadow.dart';
import 'package:pizza_quiz/utils/login_background.dart';
import 'package:pizza_quiz/widgets/TextFieldWidget.dart';

class SignInForm extends StatefulWidget {
  const SignInForm(
      {Key key,
      @required this.wp,
      @required this.hp,
      @required TextEditingController quiznameController,
      @required this.isKeyboardVisible,
      @required TextEditingController emailController,
      @required TextEditingController passwordController,
      this.quizctrl})
      : _quiznameController = quiznameController,
        _emailController = emailController,
        _passwordController = passwordController,
        super(key: key);

  final Function wp;
  final Function hp;
  final TextEditingController _quiznameController;
  final bool isKeyboardVisible;
  final QuizController quizctrl;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible =
        KeyboardVisibilityProvider.isKeyboardVisible(context);
    print(isKeyboardVisible);
    return GetBuilder<LoginController>(builder: (controller) {
      return Stack(
        children: [
          SizedBox.expand(
            child: CustomPaint(
              painter: LoginBackGround(isKeyboardVisible,
                  animation: _controller.view),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(
                left: widget.wp(4), right: widget.wp(4), top: widget.hp(5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        spacing: widget.wp(2),
                        runSpacing: widget.wp(2),
                        direction: Axis.vertical,
                        children: [
                          CircleAvatar(
                            backgroundColor: kbluelogincolor,
                            child: IconButton(
                                iconSize: widget.wp(4),
                                icon: Icon(
                                  FontAwesomeIcons.info,
                                  color: kwhitecolor,
                                ),
                                onPressed: () => Get.to(IntroPage(),
                                    transition: Transition.fadeIn)),
                          ),
                          CircleAvatar(
                            backgroundColor: kbluelogincolor,
                            child: IconButton(
                                color: kwhitecolor,
                                icon: Icon(
                                  Icons.menu,
                                  color: kwhitecolor,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) {
                                      return GetBuilder<QuizController>(
                                          builder: (controller) {
                                        return SingleChildScrollView(
                                          padding: EdgeInsets.only(
                                              top: widget.hp(10)),
                                          child: AlertDialog(
                                            title: Text(
                                                'Please insert your Quiz name'),
                                            content: TextField(
                                                focusNode: controller.quizFocus,
                                                onSubmitted: (value) {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                },
                                                controller:
                                                    widget._quiznameController,
                                                onEditingComplete: () {
                                                  print(
                                                      '${widget._quiznameController.text}');
                                                  controller.setQuizname(widget
                                                      ._quiznameController
                                                      .text);

                                                  Navigator.pop(context);
                                                }),
                                          ),
                                        );
                                      });
                                    },
                                  );
                                }),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: widget.hp(8), right: widget.wp(8)),
                        child: GetBuilder<QuizController>(
                            init: QuizController(),
                            id: "quizname",
                            builder: (controller) {
                              return Text(
                                'Quiz : ${controller.quizname}',
                                style: GoogleFonts.lato(
                                    color: kwhitecolor,
                                    fontSize: widget.wp(4.5)),
                              );
                            }),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Visibility(
                    visible: !isKeyboardVisible,
                    child: Container(
                      padding: EdgeInsets.only(left: widget.wp(15)),
                      child: Text(
                        'Quiz of\nfeeling',
                        style: GoogleFonts.lato(
                            fontSize: widget.wp(10), color: kwhitecolor),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: widget.hp(6),
                ),
                //FORM LOGIN
                Expanded(
                  flex: isKeyboardVisible ? 6 : 4,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: widget.wp(5)),
                    child: Column(
                      children: [
                        TextFieldWidget(
                          keyTesting: Key("Login Email"),
                          focus: controller.emailFocus,
                          onSubmitted: () {
                            FocusScope.of(context).unfocus();
                          },
                          editingController: controller.emailController,
                          onChange: (value) => controller.isEmail(value),
                          isPassword: false,
                          hintText: 'Email',
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.emailAddress,
                          errorText: controller.email == loginEnum.INVALID
                              ? 'Bad Email'
                              : null,
                          controller: controller,
                        ),
                        SizedBox(
                          height: widget.hp(3),
                        ),
                        TextFieldWidget(
                          keyTesting: Key("Login Password"),
                          focus: controller.passwordFocus,
                          onSubmitted: () => controller.passwordFocus.unfocus(),
                          editingController: controller.passwordController,
                          controller: controller,
                          errorText: controller.password == loginEnum.INVALID
                              ? 'Bad password'
                              : null,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          hintText: 'Password',
                          isPassword: true,
                          onChange: (value) => controller.isPassword(value),
                        ),
                        SizedBox(
                          height: widget.hp(3),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Sign in',
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold,
                                  fontSize: widget.wp(8),
                                  color: kdarkprimarycolor),
                            ),
                            controller.loadinguser == true
                                ? CircularProgressIndicator()
                                : GestureDetector(
                                    onTap: controller.email ==
                                                loginEnum.VALID &&
                                            controller.password ==
                                                loginEnum.VALID
                                        ? () async {
                                            print(widget._emailController.text);
                                            await controller.handleLogin(
                                                controller.emailController.text,
                                                controller
                                                    .passwordController.text);
                                          }
                                        : null,
                                    child: InnerShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      offset: const Offset(5, 5),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: kdarklogincolor,
                                        ),
                                        child: CircleAvatar(
                                          backgroundColor: kdarklogincolor,
                                          radius: 35,
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                          ],
                        ),
                        SizedBox(
                          height: widget.hp(4),
                        ),
                        RaisedButton(
                          onPressed: widget.quizctrl.quizname != ""
                              ? () async => await controller.signInAnonymously()
                              : null,
                          shape: StadiumBorder(),
                          elevation: 3,
                          color: kdarklogincolor,
                          child: Text(
                            'Sign in Anonymously',
                            style: GoogleFonts.lato(color: kwhitecolor),
                          ),
                        ),
                        SizedBox(
                          height: widget.hp(4),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () => controller.goToRegister(),
                              child: Text(
                                'Sign up',
                                style: GoogleFonts.lato(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                    fontSize: widget.wp(5)),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => controller.gotoForgotPassword(),
                              child: Hero(
                                tag: 'ForgotPassword',
                                transitionOnUserGestures: true,
                                child: Text(
                                  "Forgot Password?",
                                  style: GoogleFonts.lato(
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold,
                                      fontSize: widget.wp(5)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
      /*return Stack(
        children: [
          SizedBox.expand(
            child: CustomPaint(
              painter: LoginBackGround(isKeyboardVisible,
                  animation: _controller.view),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.symmetric(
                  horizontal: widget.wp(4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(
                            spacing: widget.wp(2),
                            direction: Axis.vertical,
                            children: [
                              CircleAvatar(
                                backgroundColor: kbluelogincolor,
                                child: IconButton(
                                    iconSize: widget.wp(4),
                                    icon: Icon(
                                      FontAwesomeIcons.info,
                                      color: kwhitecolor,
                                    ),
                                    onPressed: () => Get.to(IntroPage(),
                                        transition: Transition.fadeIn)),
                              ),
                              CircleAvatar(
                                backgroundColor: kbluelogincolor,
                                child: IconButton(
                                    color: kwhitecolor,
                                    icon: Icon(
                                      Icons.menu,
                                      color: kwhitecolor,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) {
                                          return GetBuilder<QuizController>(
                                              builder: (controller) {
                                            return SingleChildScrollView(
                                              padding: EdgeInsets.only(
                                                  top: widget.hp(10)),
                                              child: AlertDialog(
                                                title: Text(
                                                    'Please insert your Quiz name'),
                                                content: TextField(
                                                    focusNode:
                                                        controller.quizFocus,
                                                    onSubmitted: (value) {
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                    },
                                                    controller: widget
                                                        ._quiznameController,
                                                    onEditingComplete: () {
                                                      print(
                                                          '${widget._quiznameController.text}');
                                                      controller.setQuizname(
                                                          widget
                                                              ._quiznameController
                                                              .text);

                                                      Navigator.pop(context);
                                                    }),
                                              ),
                                            );
                                          });
                                        },
                                      );
                                    }),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: widget.hp(8), right: widget.wp(8)),
                            child: GetBuilder<QuizController>(
                                init: QuizController(),
                                id: "quizname",
                                builder: (controller) {
                                  return Text(
                                    'Quiz : ${controller.quizname}',
                                    style: GoogleFonts.lato(
                                        color: kwhitecolor,
                                        fontSize: widget.wp(4.5)),
                                  );
                                }),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Visibility(
                        visible: !isKeyboardVisible,
                        child: Padding(
                          padding: EdgeInsets.only(left: widget.wp(15)),
                          child: Text(
                            'Quiz of\nfeeling',
                            style: GoogleFonts.lato(
                                fontSize: widget.wp(10), color: kwhitecolor),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: widget.hp(5),
                    ),
                    //FORM LOGIN
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: widget.wp(5)),
                        child: Column(
                          children: [
                            TextFieldWidget(
                              keyTesting: Key("Login Email"),
                              focus: controller.emailFocus,
                              onSubmitted: (value) {
                                FocusScope.of(context).unfocus();
                                FocusScope.of(context)
                                    .requestFocus(controller.passwordFocus);
                              },
                              editingController: widget._emailController,
                              onChange: (value) => controller.isEmail(value),
                              isPassword: false,
                              hintText: 'Email',
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              errorText: controller.email == loginEnum.INVALID
                                  ? 'Bad Email'
                                  : null,
                              controller: controller,
                            ),
                            SizedBox(
                              height: widget.hp(3),
                            ),
                            TextFieldWidget(
                              keyTesting: Key("Login Password"),
                              focus: controller.passwordFocus,
                              editingController: widget._passwordController,
                              controller: controller,
                              errorText:
                                  controller.password == loginEnum.INVALID
                                      ? 'Bad password'
                                      : null,
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                              hintText: 'Password',
                              isPassword: true,
                              onChange: (value) => controller.isPassword(value),
                            ),
                            SizedBox(
                              height: widget.hp(3),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Sign in',
                                  style: GoogleFonts.lato(
                                      fontWeight: FontWeight.bold,
                                      fontSize: widget.wp(8),
                                      color: kdarkprimarycolor),
                                ),
                                controller.loadinguser == true
                                    ? CircularProgressIndicator()
                                    : GestureDetector(
                                        onTap: controller.email ==
                                                    loginEnum.VALID &&
                                                controller.password ==
                                                    loginEnum.VALID
                                            ? () async {
                                                print(widget
                                                    ._emailController.text);
                                                await controller.handleLogin(
                                                    widget
                                                        ._emailController.text,
                                                    widget._passwordController
                                                        .text);
                                              }
                                            : null,
                                        child: InnerShadow(
                                          offset: const Offset(5, 5),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: kdarklogincolor,
                                            ),
                                            child: CircleAvatar(
                                              backgroundColor: kdarklogincolor,
                                              radius: 35,
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                              ],
                            ),
                            SizedBox(
                              height: widget.hp(4),
                            ),
                            RaisedButton(
                              onPressed: widget.quizctrl.quizname != ""
                                  ? () async =>
                                      await controller.signInAnonymously()
                                  : null,
                              shape: StadiumBorder(),
                              elevation: 3,
                              color: kdarklogincolor,
                              child: Text(
                                'Sign in Anonymously',
                                style: GoogleFonts.lato(color: kwhitecolor),
                              ),
                            ),
                            SizedBox(
                              height: widget.hp(4),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    widget._emailController.clear();
                                    widget._passwordController.clear();
                                    Get.off(RegisterPage(),
                                        curve: Curves.easeIn,
                                        transition: Transition.fadeIn,
                                        duration: Duration(milliseconds: 500));
                                  },
                                  child: Text(
                                    'Sign up',
                                    style: GoogleFonts.lato(
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.bold,
                                        fontSize: widget.wp(5)),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    widget._emailController.clear();
                                    widget._passwordController.clear();
                                    Get.off(ForgotPasswordPage(),
                                        curve: Curves.easeIn,
                                        transition: Transition.fadeIn,
                                        duration: Duration(milliseconds: 500));
                                  },
                                  child: Hero(
                                    tag: 'ForgotPassword',
                                    transitionOnUserGestures: true,
                                    child: Text(
                                      "Forgot Password?",
                                      style: GoogleFonts.lato(
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.bold,
                                          fontSize: widget.wp(5)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      );*/
    });
  }
}
