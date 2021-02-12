import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pizza_quiz/routes/routes.dart';
import 'package:pizza_quiz/utils/colors_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp(
      options: FirebaseOptions(
    appId: '1:1048262391656:android:8ffbe948fb7a9f95f588dd',
    messagingSenderId: '...',
    projectId: '...',
    apiKey: 'AIzaSyAPhM0lrpenTg0a9Jg0B6L1uhfAm-uqTz0',
    databaseURL: 'https://huntlng.firebaseio.com',
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: pages,
      title: 'PizzApp',
      initialRoute: SPLASH_PAGE,
      theme: ThemeData(primaryColor: kdarklogincolor),
    );
  }
}
