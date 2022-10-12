import 'package:flutter/material.dart';
import 'package:sport_app/theme/color.dart';

Widget textField({
  String textFieldName = "",
  String hintText = "",
  bool obscureText = false,
  IconData? icon,
  TextEditingController? controller,
  keyboardType = TextInputType.text,
  formatter,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        textFieldName,
        style: const TextStyle(
          color: primaryColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        height: 50,
        child: TextField(
          keyboardType: keyboardType,
          //是否隱藏輸入文字
          obscureText: obscureText,
          //輸入文字的顏色
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            //輸入文字位置
            contentPadding: const EdgeInsets.only(top: 10),
            //icon的樣式
            prefixIcon: Icon(icon, color: primaryColor),
            //提示字
            hintText: hintText,
            hintStyle: const TextStyle(color: textColor),
            //框框
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor, width: 1),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            //輸入時框框的樣式
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor, width: 1),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
          ),
          controller: controller,
          inputFormatters: formatter,
        ),
      ),
    ],
  );
}
