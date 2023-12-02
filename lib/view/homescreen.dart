import 'package:ecomfirebase/const/consts.dart';
import 'package:flutter/material.dart';
 
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //swiper list created here
  List swiperList_1 = [imgSlider1, imgSlider2, imgSlider3, imgSlider4];
  List swiperList_2 = [imgSs1, imgSs2, imgSs3, imgSs4];
  //feature list created here
  List featureImg = [imgS1, imgS2, imgS3, imgS4, imgS5, imgS6];
  List featureTitle = [
    "Women Dress",
    "Girl Dress",
    "Girl Watch",
    "Boys Glass",
    "Mobile Phone",
    "T-shirts"
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
  //items gridviewbuilder list
  List gridviewList = [imgFc1, imgFc2, imgFc4, imgFc5, imgFc6, imgFc7];
  List gridviewTitle = [
    "Blazer",
    "Dell",
    "Kids",
    "Sports",
    "iPhone",
    "Costmatic"
  ];

  Widget homeButton(
    icon,
    String? title,
    height,
    width,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          icon,
          width: 28,
        ),
        10.heightBox,
        title!.text.semiBold.make(),
      ],
    )
        .box
        .p12
        .color(const Color.fromARGB(255, 248, 237, 237))
        .shadow
        .rounded
        .size(width, height)
        .make();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Search here",
                        suffixIcon: Icon(Icons.search),
                        border: InputBorder.none)),
              )
                  .box
                  .color(const Color.fromARGB(255, 240, 239, 239))
                  .rounded
                  .p12
                  .height(50)
                  .make(),
              //slider swiper list_1
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(children: [
                    VxSwiper.builder(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      height: 140,
                      itemCount: swiperList_1.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Image.asset(
                            swiperList_1[index],
                            fit: BoxFit.fill,
                          ),
                        )
                            .box
                            .clip(Clip.antiAlias)
                            .rounded
                            .margin(EdgeInsets.only(top: 10, left: 7))
                            .make();
                      },
                    ),
                    16.heightBox,
                    //homebutton created
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(
                            2,
                            (index) => homeButton(
                                index == 0 ? icTodaysDeal : icFlashDeal,
                                index == 0 ? "TodayDeals" : "FlashSale",
                                (context.screenHeight / 7),
                                (context.screenWidth / 2.5)))),
                    14.heightBox,
                    //slider list_2
                    VxSwiper.builder(
                      height: context.screenHeight / 5,
                      enlargeCenterPage: true,
                      itemCount: swiperList_2.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Image.asset(
                            swiperList_2[index],
                            fit: BoxFit.fill,
                          ),
                        )
                            .box
                            .clip(Clip.antiAlias)
                            .margin(EdgeInsets.only(left: 8))
                            .rounded
                            .make();
                      },
                    ),
                    12.heightBox,
                    //homebutton use in three time
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                          3,
                          (index) => homeButton(
                              index == 0
                                  ? icTopCategories
                                  : index == 1
                                      ? icBrands
                                      : icTopSeller,
                              index == 0
                                  ? "Catagory"
                                  : index == 1
                                      ? "Brands"
                                      : "Sellar",
                              (context.screenHeight / 7.2),
                              (context.screenWidth / 4))),
                    ),
                    14.heightBox,
                    Align(
                      alignment: Alignment.topLeft,
                      child: "Featured Catagory"
                          .text
                          .semiBold
                          .size(17)
                          .color(Colors.blueGrey)
                          .make(),
                    ),
                    //feature widget builder
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            featureImg.length,
                            (index) => Container(
                                  child: Column(children: [
                                    Image.asset(
                                      featureImg[index],
                                      height: 55,
                                      width: 55,
                                      fit: BoxFit.fill,
                                    ),
                                    featureTitle[index]
                                        .toString()
                                        .text
                                        .bold
                                        .size(18)
                                        .make(),
                                  ]),
                                ).box.p12.rounded.make()),
                      ),
                    ),
                    //feature products widget
                    20.heightBox,
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Feature Product"
                              .text
                              .white
                              .size(18)
                              .extraBold
                              .make(),
                          7.heightBox,
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  children: List.generate(
                                6,
                                (index) => Container(
                                  padding: EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        featureProduct[index],
                                        height:
                                            MediaQuery.of(context).size.height /
                                                7,
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
                      ),
                    ).box.p8.color(Colors.red).make(),
                    20.heightBox,
                    GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 6,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          crossAxisCount: 2,
                          mainAxisExtent: 180),
                      itemBuilder: (context, index) {
                        return Column(children: [
                          Image.asset(
                            gridviewList[index],
                            fit: BoxFit.fill,
                            height: 140,
                          ),
                          Spacer(),
                          gridviewTitle[index]
                              .toString()
                              .text
                              .semiBold
                              .size(19)
                              .make()
                        ]).box.roundedSM.make();
                      },
                    )
                  ]),
                ),
              )
            ],
          )),
    ));
  }
}



