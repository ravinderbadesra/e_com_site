import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomfirebase/common_Widget.dart/buttonWidget.dart';
import 'package:ecomfirebase/const/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //get data from database firebase
   getCartData(uid) {
      return FirebaseFirestore.instance
          .collection("cart")
          .where("addedBy", isEqualTo: uid)
          .snapshots();
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: "Shoping cart".text.make(),
        ),
        body: StreamBuilder(
          stream: getCartData(FirebaseAuth.instance.currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "Is Empty cart".text.bold.size(22).makeCentered();
            } else {
              var data = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  Expanded(child:
                      ListView.builder(itemBuilder: (context, int index) {
                    return ListTile(
                      leading: data[index]["name"],
                    );
                  })),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Total Price:"
                          .text
                          .extraBold
                          .size(18)
                          .color(Colors.blueGrey)
                          .make(),
                      "00".text.extraBold.size(18).color(Colors.red).make(),
                    ],
                  ),
                  10.heightBox,
                  buttonWidget(
                          name: "Proceed to Shiping",
                          color: Colors.red,
                          onPress: () {})
                      .box
                      .size(context.screenWidth, 55)
                      .make()
                ]),
              );
            }
          },
        ));
  }
}
