import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomfirebase/const/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemDetail extends StatelessWidget {
  final String? title;
  final dynamic data;
  ItemDetail({super.key, required this.title, this.data});

  @override
  Widget build(BuildContext context) {
    var quantity = 0.obs;
    var totalPrice = 0.obs;

    //total price value in cart
    calculateTotalPrice(price) {
      totalPrice.value = price * quantity.value;
    }

    //add to cart function create on database
    addToCart({name, sellerName, price, img, quan}) async {
      await FirebaseFirestore.instance.collection("cart").doc().set({
        "name": name,
        "sellerName": sellerName,
        "prices": price,
        "imgUrl": img,
        "quantity": quan,
        "addedBy": FirebaseAuth.instance.currentUser!.uid
      }).
          // print("create function add to cart");

          catchError((ex) {
        VxToast.show(context, msg: ex.toString());
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () => Get.back(),
        ),
        title: title!.text.make(),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.share)),
          IconButton(
              onPressed: () {}, icon: Icon(Icons.favorite_border_outlined))
        ],
      ),
      body: Column(children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VxSwiper.builder(
                  itemCount: 2,
                  height: 320,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      // "${data["p_imgs"][0]}",
                      imgB1,
                      height: 220,
                      width: 140,
                      fit: BoxFit.fill,
                    );
                  },
                ),
                "${data["p_name"]}".text.size(19).bold.make(),
                5.heightBox,
                VxRating(
                  maxRating: 5,
                  value: double.parse(data["p_rating"]),
                  onRatingUpdate: (value) {},
                  size: 22,
                ),
                5.heightBox,
                "${data["p_price"]}".text.color(redColor).size(22).bold.make(),
                10.heightBox,
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "${data["p_sellers"]}"
                            .text
                            .semiBold
                            .size(19)
                            .color(Colors.white)
                            .bold
                            .make(),
                        5.heightBox,
                        "In house Brand".text.semiBold.make()
                      ],
                    ),
                    Spacer(),
                    const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.message,
                          size: 22,
                        ))
                  ],
                ).box.color(Colors.grey).p12.make(),
                10.heightBox,
                Row(
                  children: [
                    "Color:"
                        .text
                        .color(const Color.fromARGB(255, 64, 60, 49))
                        .make(),
                    20.widthBox,
                    Row(
                      children: List.generate(
                        data["p_colors"].length,
                        (index) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              VxBox()
                                  .color(Color(data["p_colors"][index]))
                                  .size(30, 30)
                                  .roundedFull
                                  .margin(EdgeInsets.all(4))
                                  .make()
                                  .onTap(() {
                                // onChangeColors(index);
                              }),
                              Visibility(
                                visible: index == 0,
                                child: const Icon(
                                  Icons.done,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ).box.color(whiteColor).shadow.p12.make(),
                10.heightBox,
                Obx(
                  () => Row(
                    children: [
                      "Quantity:"
                          .text
                          .bold
                          .color(const Color.fromARGB(255, 64, 60, 49))
                          .make(),
                      20.widthBox,
                      IconButton(
                          onPressed: () {
                            if (quantity > 0) {
                              quantity.value--;
                              calculateTotalPrice(int.parse(data["p_price"]));
                            }
                          },
                          icon: Icon(
                            Icons.remove,
                            size: 28,
                          )),
                      quantity.value.text.make(),
                      IconButton(
                          onPressed: () {
                            if (quantity.value < int.parse(data["p_quantity"]))
                              quantity.value++;
                            calculateTotalPrice(int.parse(data["p_price"]));
                          },
                          icon: Icon(
                            Icons.add,
                            size: 28,
                          )),
                      10.widthBox,
                      "(${data["p_quantity"]} Remain)"
                          .text
                          .color(const Color.fromARGB(255, 76, 76, 76))
                          .make(),
                    ],
                  ),
                ),
                10.heightBox,
                Obx(
                  () => Row(
                    children: [
                      "Total Price:"
                          .text
                          .color(const Color.fromARGB(255, 77, 78, 79))
                          .bold
                          .make(),
                      Spacer(),
                      TextButton(
                          onPressed: () {},
                          child: totalPrice.value.text
                              .color(redColor)
                              .size(24)
                              .extraBold
                              .make())
                    ],
                  ).box.color(Color.fromARGB(255, 206, 172, 150)).p12.make(),
                ),
                10.heightBox,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Discription:".text.extraBold.extraBlack.make(),
                    "${data["p_description"]}".text.make(),
                  ],
                )
                    .box
                    .p20
                    .width(double.infinity)
                    .color(Color.fromARGB(255, 242, 242, 242))
                    .shadow
                    .make(),
                10.heightBox,
                ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(
                        bottomListSection.length,
                        (index) => Card(
                              child: ListTile(
                                leading: bottomListSection[index]
                                    .toString()
                                    .text
                                    .make(),
                                trailing: Icon(Icons.arrow_forward_ios_sharp),
                              ),
                            ))),
                20.heightBox,
                "Product you may like it".text.extraBold.size(15).make(),
                10.heightBox,
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: List.generate(
                      6,
                      (index) => Container(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              featureProduct[index],
                              height: MediaQuery.of(context).size.height / 7,
                            ),
                            featProTitle[index]
                                .toString()
                                .text
                                .size(17)
                                .bold
                                .make(),
                            6.heightBox,
                            featureRate[index]
                                .toString()
                                .text
                                .semiBold
                                .size(20)
                                .color(Colors.red)
                                .make(),
                          ],
                        ),
                      )
                          .box
                          .white
                          .roundedSM
                          .margin(EdgeInsets.only(left: 8))
                          .make(),
                    ))),
              ],
            ).box.p12.make(),
          ),
        ),
        MaterialButton(
          onPressed: () {
            addToCart(
                name: data["p_name"],
                sellerName: data["p_sellers"],
                price: totalPrice.value,
                img: data["p_imgs"],
                quan: quantity.value);
            VxToast.show(context, msg: "add to cart");
          },
          child: "Add to Cart".text.bold.size(18).color(Colors.white).make(),
        ).box.color(Colors.blue).shadowSm.size(double.infinity, 55).make()
      ]),
    );
  }

  //bottom list for listTile
  List bottomListSection = [
    "Video",
    "Reviews",
    "Privacy Policy",
    "Return Policy",
    "Support Policy"
  ];

  //feature product list for selling
  List featureProduct = [imgP1, imgP2, imgP3, imgP4, imgP5, imgP6];
  List featProTitle = [
    "Laptop",
    "Costmatic",
    "Dell",
    "Sandal",
    "Lady Purse",
    "Running Shoes"
  ];
  List featureRate = ["\$666", "\$89", "\$449", "\$14", "\$22", "\$40"];
}
