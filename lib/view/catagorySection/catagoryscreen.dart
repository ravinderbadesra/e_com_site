import 'package:ecomfirebase/common_Widget.dart/bgWidget.dart';
import 'package:ecomfirebase/const/consts.dart';
import 'package:ecomfirebase/view/catagorySection/catagoryDetail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class CatagoryScreen extends StatelessWidget {
  const CatagoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List gridviewImg = [
      imgFc1,
      imgFc2,
      imgP5,
      imgFc4,
      imgFc5,
      imgFc6,
      imgFc7,
      imgFc8,
      imgFc9,
      imgFc10
    ];
    List gridviewTitle = [
      "Blazer",
      "Laptops",
      "Women",
      "Kids",
      "Sports",
      "iPhone",
      "Bueaty",
      "Tool kit",
      "Sofa",
      "Machine"
    ];

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Get.back(),
            ),
            elevation: 0,
            title: "Catagory".text.semiBold.size(20).make()),
        body: GridView.builder(
          itemCount: gridviewImg.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              mainAxisExtent: 200),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Image.asset(
                  gridviewImg[index],
                  fit: BoxFit.cover,
                ),
                Spacer(),
                gridviewTitle[index]
                    .toString()
                    .text
                    .align(TextAlign.center)
                    .bold
                    .size(20)
                    .make()
              ],
            ).box.color(Colors.white).roundedSM.p12.make().onTap(() {
              Get.to(CatagoryDetail(title: gridviewTitle[index]));
            });
          },
        ),
      ),
    );
  }
}
