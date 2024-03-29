import 'package:flutter/material.dart';
import 'package:sport_app/theme/color.dart';

Widget radioButton({
  required String text,
  required groupValue,
  required updateGroupValue,
  falseName = "無",
  trueName = "有",
  double fontSize = 22.0,
}) {
  return Row(
    children: [
      Expanded(
        child: Text(
          text,
          style: TextStyle(
            color: primaryColor,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Flexible(
        child: RadioListTile(
          activeColor: secondColor,
          title: Text(
            falseName,
            style: const TextStyle(
              color: secondColor,
              fontSize: 20,
            ),
          ),
          value: false,
          groupValue: groupValue,
          onChanged: (value) {
            updateGroupValue(value);
          },
        ),
      ),
      Flexible(
        child: RadioListTile(
          activeColor: secondColor,
          title: Text(
            trueName,
            style: const TextStyle(
              color: secondColor,
              fontSize: 20,
            ),
          ),
          value: true,
          groupValue: groupValue,
          onChanged: (value) {
            updateGroupValue(value);
          },
        ),
      ),
    ],
  );
}
