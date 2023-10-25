import 'package:ecomfirebase/const/consts.dart';
import 'package:flutter/material.dart';

Widget ApplogoWidget() {
  return Image.asset(
    icAppLogo,
  ).box.size(70, 70).white.padding(EdgeInsets.all(8)).rounded.make();
}
