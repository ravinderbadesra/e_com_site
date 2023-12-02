import 'package:ecomfirebase/const/consts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Widget customTextField({String? title,String? hint, controller,bool? obScure}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(redColor).fontFamily(bold).size(18).make(),
      6.heightBox,
      TextFormField(controller: controller,obscureText: obScure!,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
            ),
            hintText: hint,
            filled: true,
            isDense: true,
            fillColor: Color.fromARGB(255, 223, 223, 223)),
      ),8.heightBox,
    ],
  );
}
