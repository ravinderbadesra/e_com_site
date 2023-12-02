import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomfirebase/common_Widget.dart/bgWidget.dart';
import 'package:ecomfirebase/const/consts.dart';
import 'package:ecomfirebase/view/catagorySection/itemDetail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CatagoryDetail extends StatelessWidget {
  final String? title;
  const CatagoryDetail({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    List gridviewTitle = ["Blazer", "Laptops", "Women", "Sofa", "Machine"];
    getProduct(catagory) {
      return FirebaseFirestore.instance
          .collection("product")
          .where("p_catagory", isEqualTo: catagory)
          .snapshots();
    }

    return bgWidget(
        child: Scaffold(
            appBar: AppBar(
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new),
                  onPressed: () => Get.back(),
                ),
                title: title!.text.make()),
            body: StreamBuilder(
              stream: getProduct(title),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(
                      child: "Not data found"
                          .text
                          .size(28)
                          .color(const Color.fromARGB(255, 74, 72, 66))
                          .center
                          .make());
                } else {
                  var data = snapshot.data!.docs;
                  return Column(children: [
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: List.generate(
                              gridviewTitle.length,
                              (index) => gridviewTitle[index]
                                  .toString()
                                  .text
                                  .bold
                                  .size(14)
                                  .make()
                                  .box
                                  .white
                                  .rounded
                                  .size(100, 60)
                                  .alignCenter
                                  .margin(EdgeInsets.only(left: 8))
                                  .make())),
                    ),
                    12.heightBox,
                    Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        // itemCount: data.length,
                        itemCount: 1,
                        // physics: AlwaysScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            mainAxisExtent: 200),
                        itemBuilder: (context, index) {
                          return Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                "${data[index]["p_imgs"][0]}",
                                height: 100,
                                width: 80,
                                // fit: BoxFit.cover,
                              ),
                              8.heightBox,
                              "${data[index]["p_name"]}".text.bold.make(),
                              10.heightBox,
                              " ${data[index]["p_price"]}"
                                  .numCurrency
                                  .text
                                  .bold
                                  .size(17)
                                  .color(redColor)
                                  .make()
                            ],
                          ).box.white.p12.height(200).rounded.make().onTap(() {
                            Get.to(ItemDetail(
                              title: title,
                              data: data[index],
                            ));
                          });
                        },
                      ),
                    )
                  ]);
                }
              },
            )));
  }
}
