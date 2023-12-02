import 'package:ecomfirebase/common_Widget.dart/app_Logo.dart';
import 'package:ecomfirebase/common_Widget.dart/bgWidget.dart';
import 'package:ecomfirebase/common_Widget.dart/buttonWidget.dart';
import 'package:ecomfirebase/common_Widget.dart/costomTextField.dart';
import 'package:ecomfirebase/const/consts.dart';
import 'package:ecomfirebase/controller/auth_controller.dart';
import 'package:ecomfirebase/view/authScreen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SiginScreen extends StatefulWidget {
  const SiginScreen({super.key});

  @override
  State<SiginScreen> createState() => _SiginScreenState();
}

class _SiginScreenState extends State<SiginScreen> {
  bool? isChecked = false;
  var controller = Get.put(AuthController());
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var reTypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .04,
            ),
            Center(child: ApplogoWidget()),
            "Login $appname".text.white.bold.size(17).make(),
            Column(
              children: [
                customTextField(
                    title: "Name",
                    hint: "anshu",
                    controller: nameController,
                    obScure: false),
                customTextField(
                    title: "Email",
                    hint: "@rsbasesra",
                    obScure: false,
                    controller: emailController),
                customTextField(
                    title: "Password",
                    obScure: true,
                    hint: "******",
                    controller: passwordController),
                customTextField(
                    obScure: true,
                    title: "Retype password",
                    controller: reTypeController),
                6.heightBox,
                Row(
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value;
                        });
                        print("click to check here");
                      },
                    ),
                    "I agree to the ".text.bold.make(),
                    "Terms & Conditions".text.bold.red700.make(),
                  ],
                ),
                buttonWidget(
                    name: signup,
                    color: isChecked == true
                        ? Colors.red
                        : const Color.fromARGB(255, 255, 205, 205),
                    onPress: () async {
                      if (isChecked != false) {
                        try {
                          await controller
                              .signupMethod(
                                  context: context,
                                  email: emailController.text,
                                  password: passwordController.text)
                              .then((value) {
                            return controller.storeUserData(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text);
                          }).then((value) {
                            Get.offAll(LoginScreen());
                            VxToast.show(context, msg: "login successful");
                          });
                        } catch (ex) {
                          VxToast.show(context, msg: ex.toString());
                          FirebaseAuth.instance.signOut();
                        }
                      }
                    }).box.width(context.screenWidth).make(),
                7.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    "Already have an account?".text.bold.make(),
                    "Login".text.red900.size(17).semiBold.make().onTap(() {
                      Get.back();
                    }),
                  ],
                )
              ],
            ).box.p20.margin(EdgeInsets.all(20)).white.rounded.shadowSm.make(),
          ],
        ),
      ),
    ));
  }
}
