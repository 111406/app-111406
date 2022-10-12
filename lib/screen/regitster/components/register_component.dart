import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/screen/components/button.dart';
import 'package:sport_app/screen/login/login.dart';

Widget backToLoginButton(context) {
  return underScoreBtn(
    text: '我已有帳號，返回登入',
    onPressed: () async {
      final prefs = await SharedPreferences.getInstance();
      prefs.clear();
      Navigator.pushReplacementNamed(context, LoginPage.routeName);
    },
  );
}
