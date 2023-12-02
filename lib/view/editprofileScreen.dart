import 'dart:io';

import 'package:ecomfirebase/common_Widget.dart/bgWidget.dart';
import 'package:ecomfirebase/common_Widget.dart/buttonWidget.dart';
import 'package:ecomfirebase/common_Widget.dart/costomTextField.dart';
import 'package:ecomfirebase/const/consts.dart';
import 'package:ecomfirebase/controller/profile_Controller.dart';
import 'package:ecomfirebase/view/profilescreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  final data;
  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    // var nameController = TextEditingController();
    // var passController = TextEditingController();
    controller.nameController.text = data["name"];
    // controller.passController.text = data['password'];

    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.to(ProfileScreen());
          },
        ),
        elevation: 0,
      ),
      body: Obx(
        () => Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
              data["imgUrl"] == "" && controller.profileImagePath.isEmpty
                  ? Image.asset(
                      imgProfile2,
                      fit: BoxFit.cover,
                    ).box.size(77, 77).clip(Clip.antiAlias).roundedFull.make()
                  : data["imgUrl"] != "" && controller.profileImagePath.isEmpty
                      ? Image.network(
                          data["imgUrl"],
                          fit: BoxFit.cover,
                        )
                          .box
                          .size(88, 90)
                          .clip(Clip.antiAliasWithSaveLayer)
                          .roundedFull
                          .make()
                      : Image.file(
                          File(controller.profileImagePath.value),
                          fit: BoxFit.cover,
                        )
                          .box
                          .size(88, 90)
                          .clip(Clip.antiAliasWithSaveLayer)
                          .roundedFull
                          .make(),
              buttonWidget(
                  name: "Change",
                  color: Colors.red,
                  onPress: () async {
                    controller.changeImage(context);
                  }),
              customTextField(
                  title: "Name",
                  hint: "hint",
                  obScure: false,
                  controller: controller.nameController),
              customTextField(
                  controller: controller.OldController,
                  title: "OldPassword",
                  hint: "pass****",
                  obScure: false),
              customTextField(
                  controller: controller.NewController,
                  title: "NewPassword",
                  hint: "pass****",
                  obScure: false),
              controller.isLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : buttonWidget(
                      name: "Save",
                      color: Colors.red,
                      onPress: () async {
                        controller.isLoading(true);
                        //if image is not selected
                        if (controller.profileImagePath.value.isNotEmpty) {
                          await controller.UploadProfile();
                        } else {
                          controller.profileImageLink = data["imgUrl"];
                        }
                        //if old password matches database
                        if (data["password"] == controller.OldController.text) {
                          await controller.changeAuthPassword(
                              email: data["email"],
                              oldPassword: controller.OldController.text,
                              newPassword: controller.NewController.text);
                          await controller.UpdateProfile(
                              password: controller.NewController.text,
                              name: controller.nameController.text,
                              imgUrl: controller.profileImageLink);
                          VxToast.show(context,
                              msg: "update successful", bgColor: Colors.green);
                        } else {
                          VxToast.show(context,
                              msg: "Old password not matched");
                        }
                        controller.isLoading(false);
                      }).box.width(context.screenWidth).p12.make()
            ])
            .box
            .white
            .p16
            .margin(EdgeInsets.all(10))
            .shadow2xl
            .rounded
            .make(),
      ),
    ));
  }
}
