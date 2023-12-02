import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomfirebase/common_Widget.dart/bgWidget.dart';
import 'package:ecomfirebase/common_Widget.dart/buttonWidget.dart';
import 'package:ecomfirebase/const/consts.dart';
import 'package:ecomfirebase/controller/profile_Controller.dart';
import 'package:ecomfirebase/view/authScreen/login_screen.dart';
import 'package:ecomfirebase/view/editprofileScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var controller = Get.put(ProfileController());

  //fetch data firestore in streamBuilder
  getUser(uid) {
    return FirebaseFirestore.instance
        .collection("users")
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
            body: StreamBuilder(
      stream: getUser(FirebaseAuth.instance.currentUser!.uid),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          DocumentSnapshot data = snapshot.data.docs[0];
          return SafeArea(
              child: Column(
            children: [
              IconButton(
                      onPressed: () {
                        Get.to(EditProfileScreen(
                          data: data,
                        ));
                      },
                      icon: Icon(Icons.edit))
                  .box
                  .alignBottomRight
                  .make(),
              Row(
                children: [
                  data["imgUrl"] == ""
                      ? Image.asset(
                          imgProfile2,
                          fit: BoxFit.cover,
                        )
                          .box
                          .size(52, 52)
                          .clip(Clip.antiAlias)
                          .roundedFull
                          .make()
                      : Image.network(
                          data["imgUrl"],
                          fit: BoxFit.cover,
                        )
                          .box
                          .size(52, 52)
                          .clip(Clip.antiAlias)
                          .roundedFull
                          .make(),
                  20.widthBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      data["name"].toString().text.white.size(18).bold.make(),
                      data["email"].toString().text.semiBold.gray300.make()
                    ],
                  ),
                  Spacer(),
                  buttonWidget(
                      name: "Logout",
                      color: Color.fromARGB(241, 228, 60, 9),
                      onPress: () async {
                        // await controller.siginOutMethod(context: context);
                        await FirebaseAuth.instance.signOut();
                        Get.offAll(LoginScreen());
                        VxToast.show(context, msg: "signout screen");
                      }),
                ],
              ).box.margin(EdgeInsets.symmetric(horizontal: 10)).make(),
              20.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  cartButton("WishList", "07"),
                  cartButton("In Cart", "22"),
                  cartButton("My Order", "125"),
                ],
              ),
              // 10.heightBox,
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(
                    4,
                    (index) => ListTile(
                          leading: Icon(iconList[index]),
                          title:
                              profileBottomList[index].toString().text.make(),
                        )),
              )
                  .box
                  .white
                  .rounded
                  .shadow
                  .margin(EdgeInsets.all(10))
                  .make()
                  .box
                  .color(redColor)
                  .make(),
            ],
          ));
        }
      },
    )));
  }

  //common cart button create
  Widget cartButton(
    String? title,
    String count,
  ) {
    return Column(
      children: [count.text.make(), title!.text.make()],
    ).box.p20.white.width(context.screenWidth / 3.4).roundedSM.make();
  }

  //bottom listTile view created
  List<IconData> iconList = [
    Icons.reviews,
    Icons.note_alt_outlined,
    Icons.message_rounded,
    Icons.privacy_tip
  ];
  List profileBottomList = [
    "Review",
    "My Wishlist",
    "Messenger",
    "Privacy Policy"
  ];
}
