import 'package:ecomfirebase/common_Widget.dart/app_Logo.dart';
import 'package:ecomfirebase/const/consts.dart';
import 'package:ecomfirebase/view/authScreen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  changeScreen() {
    Future.delayed(Duration(seconds: 3),() => Get.to(LoginScreen()));
     
  }

  @override
  void initState() {
    // TODO: implement initState
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Column(children: [
        Align(
          alignment: Alignment.topLeft,
          child: Image.asset(
            icSplashBg,
            width: 300,
            height: 250,
          ),
        ),
        20.heightBox,
        ApplogoWidget(),
        10.heightBox,
        appname.text.bold.white.size(20).make(),
        6.heightBox,
        appversion.text.white.make(),
        Spacer(),
        credits.text.white.make(),
        20.heightBox
        //complete splash page
      ]),
    );
  }
}
