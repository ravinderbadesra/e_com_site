 import 'package:ecomfirebase/const/consts.dart';
import 'package:ecomfirebase/view/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
 import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: SplashScreen()
      ,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.transparent,
          appBarTheme: AppBarTheme(backgroundColor: Colors.transparent),
          fontFamily: regular),
      debugShowCheckedModeBanner: false,
    );
  }
}
