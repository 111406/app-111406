import 'package:flutter/material.dart';
import 'package:sport_app/theme/color.dart';

Widget pageTitle(String text) {
  return Container(
    alignment: Alignment.center,
    child: Text(
      text,
      style: const TextStyle(
        decoration: TextDecoration.none,
        color: primaryColor,
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
