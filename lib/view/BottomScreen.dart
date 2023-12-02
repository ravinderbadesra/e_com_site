import 'package:ecomfirebase/common_Widget.dart/buttonWidget.dart';
import 'package:ecomfirebase/const/consts.dart';
import 'package:ecomfirebase/view/cartscreen.dart';
import 'package:ecomfirebase/view/catagorySection/catagoryscreen.dart';
import 'package:ecomfirebase/view/homeScreen.dart';
import 'package:ecomfirebase/view/profilescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BottomScreen extends StatelessWidget {
  const BottomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var currentItem = 0.obs;
    var bodyScreenWidget = [
      HomeScreen(),
      CatagoryScreen(),
      CartScreen(),
      ProfileScreen(),
    ];
//exit dialog box created to know user about exit or not
    Widget ExitDialogBox() {
      return Dialog(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          "Confirm".text.semiBold.size(18).make(),
          "Are you sure you want to exit?".text.bold.make(),
          16.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buttonWidget(
                  name: "Yes",
                  color: Colors.green,
                  onPress: () {
                    SystemNavigator.pop();
                  }),
              buttonWidget(
                  name: "No",
                  color: Colors.lightBlue,
                  onPress: () {
                    Get.back();
                  })
            ],
          )
        ]).box.p20.roundedSM.make(),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => ExitDialogBox());

        return false;
      },
      child: Scaffold(
        body: Obx(() => bodyScreenWidget.elementAt(currentItem.value)),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
              onTap: (value) {
                currentItem.value = value;
              },
              selectedItemColor: Colors.amber,
              type: BottomNavigationBarType.fixed,
              currentIndex: currentItem.value,
              items: [
                const BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.category_sharp), label: "Catagory"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart_outlined), label: "Cart"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_2_outlined), label: "Account"),
              ]),
        ),
      ),
    );
  }
}
