import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pizza_quiz/controllers/login_controller.dart';
import 'package:pizza_quiz/controllers/register_controller.dart';
import 'package:pizza_quiz/pages/Login/login_page.dart';
import 'package:pizza_quiz/utils/colors_fonts.dart';
import 'package:pizza_quiz/utils/innerShadow.dart';
import 'package:pizza_quiz/utils/register_background.dart';
import 'package:pizza_quiz/widgets/TextFieldWidget.dart';
import 'package:responsive_screen/responsive_screen.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  final registerctrl = Get.put(RegisterController());

  final loginctrl = Get.put(LoginController());

  TextEditingController _namectrl = TextEditingController();

  TextEditingController _emailctrl = TextEditingController();

  TextEditingController _passctrl = TextEditingController();

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
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;
    return Scaffold(
      body: GetBuilder<RegisterController>(builder: (controller) {
        return Stack(
          children: [
            SizedBox.expand(
              child: CustomPaint(
                painter: RegisterBackGround(animation: _controller.view),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: wp(4),
                vertical: hp(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: wp(5), top: hp(10)),
                      child: Text(
                        'Create\nAccount',
                        style: GoogleFonts.lato(
                            fontSize: wp(10), color: kwhitecolor),
                      ),
                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: wp(5)),
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        TextFieldWidget(
                          focus: controller.emailFocus,
                          onSubmitted: (value) {
                            FocusScope.of(context).unfocus();
                            FocusScope.of(context)
                                .requestFocus(controller.passwordFocus);
                          },
                          isRegister: true,
                          hintText: 'Email',
                          editingController: _emailctrl,
                          keyboardType: TextInputType.text,
                          isPassword: false,
                          textInputAction: TextInputAction.next,
                          errorText:
                              controller.validEmail == registerEnum.INVALID
                                  ? 'Bad email'
                                  : null,
                          controller: controller,
                          onChange: (value) => controller.isEmail(value),
                        ),
                        SizedBox(
                          height: hp(3),
                        ),
                        TextFieldWidget(
                          focus: controller.passwordFocus,
                          isRegister: true,
                          hintText: 'Password',
                          editingController: _passctrl,
                          keyboardType: TextInputType.visiblePassword,
                          isPassword: true,
                          textInputAction: TextInputAction.done,
                          errorText:
                              controller.validPass == registerEnum.INVALID
                                  ? 'Bad password'
                                  : null,
                          controller: controller,
                          onChange: (value) => controller.isPassword(value),
                        ),
                        SizedBox(
                          height: hp(8),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Sign up',
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.bold,
                                  fontSize: wp(8),
                                  color: kwhitecolor),
                            ),
                            GestureDetector(
                              onTap: controller.validEmail ==
                                          registerEnum.VALID &&
                                      controller.validPass ==
                                          registerEnum.VALID
                                  ? () async {
                                      final user =
                                          await controller.handleRegister(
                                              _emailctrl.text.trim(),
                                              _passctrl.text.trim());
                                      if (user != null) {
                                        await loginctrl.handleLogin(
                                            _emailctrl.text.trim(),
                                            _passctrl.text.trim());
                                      }
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
                          height: hp(8),
                        ),
                        GestureDetector(
                          onTap: () => Get.off(LoginPage(),
                              curve: Curves.easeIn,
                              transition: Transition.fadeIn,
                              duration: Duration(milliseconds: 500)),
                          child: Text(
                            'Sign in',
                            style: GoogleFonts.lato(
                                color: kwhitecolor,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                fontSize: wp(5)),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
