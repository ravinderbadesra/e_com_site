import 'package:ecomfirebase/const/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buttonWidget({String? name,Color? color, onPress}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
      ),
      onPressed: onPress,
      child: name!.text.fontFamily(bold).make());
}
