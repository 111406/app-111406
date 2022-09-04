import 'package:flutter/material.dart';
import 'package:sport_app/theme/color.dart';

showAlertDialog(
  context, {
  title = '提示',
  message = '執行錯誤',
}) {
  // Init
  AlertDialog dialog = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      ElevatedButton(
        child: const Text("關閉"),
        style: ElevatedButton.styleFrom(primary: primaryColor),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ],
  );

  showGeneralDialog(
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return Wrap();
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return Transform(
        transform: Matrix4.translationValues(
          0.0,
          (1.0 - Curves.easeInOut.transform(anim1.value)) * 400,
          0.0,
        ),
        child: dialog,
      );
    },
    transitionDuration: const Duration(milliseconds: 400),
  );
}
