import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/screen/components/app_logo.dart';
import 'package:sport_app/screen/components/button.dart';
import 'package:sport_app/screen/components/page_title.dart';
import 'package:sport_app/screen/components/textfield_inputbox.dart';
import 'package:sport_app/screen/login/login.dart';
import 'package:sport_app/theme/color.dart';
import 'package:sport_app/utils/alertdialog.dart';
import 'package:sport_app/utils/http_request.dart';

class ForgotPassword02 extends StatefulWidget {
  const ForgotPassword02({Key? key}) : super(key: key);
  static const String routeName = "/forgotpassword/next";

  @override
  State<ForgotPassword02> createState() => _ForgotPassword02State();
}

class _ForgotPassword02State extends State<ForgotPassword02> {
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 40),
          child: Column(
            children: [
              appLogo(),
              pageTitle('重新建立密碼'),
              const SizedBox(height: 30),
              Column(
                children: [
                  textField(
                    textFieldName: '新密碼',
                    hintText: '請輸入新密碼',
                    obscureText: true,
                    icon: Icons.lock,
                    controller: newPasswordController,
                  ),
                  const SizedBox(height: 10),
                  textField(
                    textFieldName: '確認密碼',
                    hintText: '確認密碼',
                    obscureText: true,
                    icon: Icons.lock,
                    controller: confirmNewPasswordController,
                  ),
                ],
              ),
              const SizedBox(height: 40),
              mainBtn(
                text: '重新登入',
                onPressed: () async {
                  final newPassword = newPasswordController.text,
                      confirmNewPassword = confirmNewPasswordController.text;

                  bool _textFieldIsNotEmpty =
                      (newPassword.isNotEmpty && confirmNewPassword.isNotEmpty);
                  bool _passwordCheck = (newPassword == confirmNewPassword);

                  if (!_textFieldIsNotEmpty) {
                    showAlertDialog(
                      context,
                      title: '輸入框不得為空白',
                      message: '請重新輸入',
                    );
                  }
                  if (!_passwordCheck) {
                    showAlertDialog(
                      context,
                      title: '新密碼與舊密碼不相同',
                      message: '請重新輸入',
                    );
                  }

                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  final email = prefs.getString("email");

                  String requestData = """{
                    "email": "$email", 
                    "password": "$newPassword"
                  }""";

                  if (_textFieldIsNotEmpty && _passwordCheck) {
                    try {
                      await HttpRequest()
                          .post('${HttpURL.host}/api/user/update/password',
                              requestData)
                          .then(
                            (response) async {},
                          );
                      showAlertDialog(
                        context,
                        title: '修改成功',
                        message: '',
                      );
                      Timer(Duration(seconds: 2), () {
                        Navigator.pushReplacementNamed(
                            context, LoginPage.routeName);
                      });
                    } on Exception catch (e) {
                      // TODO
                      showAlertDialog(
                        context,
                        title: '',
                        message: '',
                      );
                    }
                  }
                },
              ),
              const SizedBox(height: 20),
              underScoreBtn(
                text: '取消 / 返回',
                onPressed: () {
                  Navigator.pushReplacementNamed(context, LoginPage.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
