import 'package:flutter/material.dart';
import 'package:sport_app/theme/color.dart';

Future<void> showAlertDialog(
  context, {
  title = '提示',
  message = '執行錯誤',  
}) async {
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

   await showGeneralDialog(
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


Future<void> showCheckDialog(
  context, {
  title = '提示',
  message = '',
  VoidCallback? func
}) async {
  // Init
  AlertDialog dialog = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      ElevatedButton(
        child: const Text("否"),
        style: ElevatedButton.styleFrom(primary: primaryColor),
        onPressed: () {
          Navigator.pop(context);
        },
      ),      
      ElevatedButton(
        child: const Text("是"),
        style: ElevatedButton.styleFrom(primary: primaryColor),
        onPressed: func,
      ),
    ],
  );

   await showGeneralDialog(
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
