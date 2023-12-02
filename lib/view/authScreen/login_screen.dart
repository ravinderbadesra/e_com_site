import 'package:ecomfirebase/common_Widget.dart/app_Logo.dart';
import 'package:ecomfirebase/common_Widget.dart/bgWidget.dart';
import 'package:ecomfirebase/common_Widget.dart/buttonWidget.dart';
import 'package:ecomfirebase/common_Widget.dart/costomTextField.dart';
import 'package:ecomfirebase/const/consts.dart';
import 'package:ecomfirebase/controller/auth_controller.dart';
import 'package:ecomfirebase/view/authScreen/sigin_screen.dart';
import 'package:ecomfirebase/view/BottomScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  var controller = Get.put(AuthController());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .1,
          ),
          Center(child: ApplogoWidget()),
          "Login $appname".text.white.fontFamily(bold).size(16).make(),
          Column(
            children: [
              customTextField(
                  title: "Email",
                  hint: "$credits",
                  obScure: false,
                  controller: emailController),
              customTextField(
                  title: "Password",
                  obScure: true,
                  hint: "********",
                  controller: passwordController),
              Align(
                alignment: Alignment.bottomRight,
                child: "Forget Password".text.color(Colors.blue).bold.make(),
              ),
              10.heightBox,
              controller.isLoaded.value
                  ? CircularProgressIndicator()
                  : buttonWidget(
                          name: login,
                          onPress: () async {
                            controller.isLoaded(true);
                            try {
                              await controller
                                  .loginMethod(
                                      context: context,
                                      email: emailController.text,
                                      password: passwordController.text)
                                  .then((value) {
                                if (value != null) {
                                  Get.offAll(() => BottomScreen());
                                } else {
                                  controller.isLoaded(false);
                                }
                              }).then((value) => controller.isLoaded(false));
                            } catch (ex) {
                              VxToast.show(context, msg: ex.toString());

                              // else {
                              //   controller.isLoaded(false);
                            }
                          },
                          color: Colors.red)
                      .box
                      .width(context.screenWidth)
                      .make(),
              7.heightBox,
              "OR, Create a new account".text.make(),
              7.heightBox,
              buttonWidget(
                  name: signup,
                  color: Color.fromARGB(255, 114, 113, 112),
                  onPress: () {
                    Get.to(SiginScreen());
                    print("onpress button clickable");
                  }).box.width(context.screenWidth).make(),
              7.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    3,
                    (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 23,
                            backgroundColor:
                                const Color.fromARGB(255, 252, 235, 235),
                            child: Image.asset(
                              socialApp[index],
                              width: 27,
                            ),
                          ),
                        )),
              )
            ],
          ).box.white.p20.margin(EdgeInsets.all(22)).shadowSm.rounded.make(),
        ]),
      ),
    ));
  }

  List socialApp = [icFacebookLogo, icGoogleLogo, icAppleLogo];
}
