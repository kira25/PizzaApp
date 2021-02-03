import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_quiz/controllers/forgotpassword_controller.dart';
import 'package:pizza_quiz/pages/Login/login_page.dart';
import 'package:pizza_quiz/utils/colors_fonts.dart';
import 'package:pizza_quiz/utils/register_background.dart';
import 'package:pizza_quiz/widgets/TextFieldWidget.dart';
import 'package:responsive_screen/responsive_screen.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  final loginctrl = Get.put(ForgotPasswordController());
  FocusNode emailFocus;
  TextEditingController emailctrl = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _controller.forward();
    emailFocus = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    emailFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kdarklogincolor,
        elevation: 0,
        leading: IconButton(


          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Get.off(LoginPage(),
              curve: Curves.easeIn,
              transition: Transition.fadeIn,
              duration: Duration(milliseconds: 500)),
        ),
      ),
      body: GetBuilder<ForgotPasswordController>(
        builder: (controller) {
          return ListView(
            physics: AlwaysScrollableScrollPhysics(),

            children: [
              CustomPaint(
                size: Size(wp(100), hp(100)),
                painter: RegisterBackGround(animation: _controller.view),
                child: Container(
                  height: MediaQuery.of(context).size.height*0.9,
                  padding: EdgeInsets.only(
                      left: wp(4), right: wp(4), top: hp(5)),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: hp(8)),
                        child: Image.asset(
                          './assets/examen.png',
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                      ),
                      SizedBox(
                        height: hp(12),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: wp(5)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFieldWidget(

                              editingController: emailctrl,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.emailAddress,
                              focus: emailFocus,
                              onSubmitted: (value) =>
                                  FocusScope.of(context).unfocus(),
                              isRegister: true,
                              isPassword: false,
                              hintText: 'Email',
                              errorText: controller.email == loginEnum.INVALID
                                  ? 'Bad Email'
                                  : null,
                              onChange: (value) => controller.isEmail(value),
                            ),
                            SizedBox(
                              height: hp(12),
                            ),
                            RaisedButton(
                              padding: EdgeInsets.all(wp(3)),
                              splashColor: Colors.transparent,
                              elevation: 5,
                              color: kdarklogincolor,
                              shape: StadiumBorder(),
                              onPressed: () =>controller.sendEmail(emailctrl.text),
                              child: Text(
                                'Enviar',
                                style: GoogleFonts.lato(
                                    color: kwhitecolor, fontSize: wp(6)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
          return Stack(
            children: [
              SizedBox.expand(
                child: CustomPaint(
                  painter: RegisterBackGround(animation: _controller.view),
                ),
              ),
              SizedBox.expand(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: wp(4),
                    vertical: hp(2),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: hp(8)),
                          child: Image.asset(
                            './assets/examen.png',
                            height: MediaQuery.of(context).size.height * 0.3,
                          ),
                        ),
                        SizedBox(
                          height: hp(12),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: wp(5)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TextFieldWidget(
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.emailAddress,
                                focus: emailFocus,
                                onSubmitted: (value) =>
                                    FocusScope.of(context).unfocus(),
                                isRegister: true,
                                isPassword: false,
                                hintText: 'Enter email',
                              ),
                              SizedBox(
                                height: hp(12),
                              ),
                              RaisedButton(
                                padding: EdgeInsets.all(wp(3)),
                                splashColor: Colors.transparent,
                                elevation: 5,
                                color: kdarklogincolor,
                                shape: StadiumBorder(),
                                onPressed: () {},
                                child: Text(
                                  'Enviar',
                                  style: GoogleFonts.lato(
                                      color: kwhitecolor, fontSize: wp(6)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
