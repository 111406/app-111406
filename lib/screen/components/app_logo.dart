import 'package:flutter/material.dart';

Widget appLogo() {
  return Container(
    alignment: Alignment.center,
    child: Image.asset(
      'assets/icon/logo01.png',
      fit: BoxFit.contain,
      width: 150,
    ),
  );
}
