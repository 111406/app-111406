import 'package:flutter/material.dart';
import 'package:sport_app/theme/color.dart';

Widget mainBtn({
  String text = '下一步',
  onPressed,
  double fontSize = 22,
}) {
  return SizedBox(
    // padding: const EdgeInsets.symmetric(vertical: 20),
    height: 40,
    width: double.infinity,
    // width: 200,
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(text, style: TextStyle(fontSize: fontSize)),
      style: ElevatedButton.styleFrom(primary: primaryColor),
    ),
  );
}

Widget underScoreBtn({
  String text = '返回',
  onPressed,
  double fontSize = 20,
  alignment = Alignment.center,
}) {
  return Container(
    alignment: alignment,
    child: GestureDetector(
      onTap: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: primaryColor,
          fontSize: fontSize,
          decoration: TextDecoration.underline,
        ),
      ),
    ),
  );
}
