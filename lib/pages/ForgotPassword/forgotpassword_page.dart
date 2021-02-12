import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
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
      body: GetBuilder<ForgotPasswordController>(
        builder: (controller) {
          return KeyboardVisibilityProvider(
            child: Body(
              controller: _controller,
              wp: wp,
              hp: hp,
              emailctrl: emailctrl,
              emailFocus: emailFocus,
              forgotcontroller: controller,
            ),
          );
        },
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key key,
    @required AnimationController controller,
    @required this.wp,
    @required this.hp,
    @required this.emailctrl,
    @required this.emailFocus,
    this.forgotcontroller,
  })  : _controller = controller,
        super(key: key);

  final AnimationController _controller;
  final Function wp;
  final Function hp;
  final TextEditingController emailctrl;
  final FocusNode emailFocus;
  final ForgotPasswordController forgotcontroller;

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible =
        KeyboardVisibilityProvider.isKeyboardVisible(context);
    return Stack(
      children: [
        SizedBox.expand(
          child: CustomPaint(
            painter: RegisterBackGround(animation: _controller.view),
          ),
        ),
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.9,
          child: Column(
            children: [
              Expanded(
                  child: Padding(
                padding: EdgeInsets.only(left: wp(3), top: hp(3)),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: wp(7),
                        color: kwhitecolor,
                      ),
                      onPressed: () => Get.off(LoginPage(),
                          curve: Curves.easeIn,
                          transition: Transition.fadeIn,
                          duration: Duration(milliseconds: 500)),
                    ),
                  ],
                ),
              )),
              Visibility(
                visible: !isKeyboardVisible,
                child: Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(top: hp(8)),
                    child: Image.asset(
                      './assets/examen.png',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: hp(12),
              ),
              Expanded(
                flex: isKeyboardVisible ? 4:  2,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: wp(9)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFieldWidget(
                        editingController: emailctrl,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.emailAddress,
                        focus: emailFocus,
                        onSubmitted: () => FocusScope.of(context).unfocus(),
                        isRegister: true,
                        isPassword: false,
                        hintText: 'Email',
                        errorText: forgotcontroller.email == loginEnum.INVALID
                            ? 'Bad Email'
                            : null,
                        onChange: (value) => forgotcontroller.isEmail(value),
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
                        onPressed: () =>
                            forgotcontroller.sendEmail(emailctrl.text),
                        child: Text(
                          'Enviar',
                          style: GoogleFonts.lato(
                              color: kwhitecolor, fontSize: wp(5)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
