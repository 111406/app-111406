import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/screen/components/app_logo.dart';
import 'package:sport_app/screen/components/button.dart';
import 'package:sport_app/screen/components/page_title.dart';
import 'package:sport_app/screen/components/textfield_inputbox.dart';
import 'package:sport_app/screen/login/login.dart';
import 'package:sport_app/screen/main_page.dart';
import 'package:sport_app/utils/alertdialog.dart';
import 'package:sport_app/utils/http_request.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);
  static const String routeName = "/changepassword";

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
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
              pageTitle('修改密碼'),
              const SizedBox(height: 20),
              Column(
                children: [
                  textField(
                    obscureText: true,
                    textFieldName: '舊密碼',
                    hintText: '請輸入舊密碼',
                    icon: Icons.lock,
                    controller: oldPasswordController,
                  ),
                  const SizedBox(height: 10),
                  textField(
                    obscureText: true,
                    textFieldName: '新密碼',
                    hintText: '請輸入新密碼',
                    icon: Icons.lock,
                    controller: newPasswordController,
                  ),
                  const SizedBox(height: 10),
                  textField(
                    obscureText: true,
                    textFieldName: '確認密碼',
                    hintText: '確認密碼',
                    icon: Icons.lock,
                    controller: confirmPasswordController,
                  ),
                ],
              ),
              const SizedBox(height: 50),
              mainBtn(
                text: '確認修改',
                onPressed: () async {
                  final oldPassword = oldPasswordController.text;
                  final newPassword = newPasswordController.text;
                  final confirmPassword = confirmPasswordController.text;

                  bool _textFieldIsNotEmpty = (oldPassword.isNotEmpty &&
                      newPassword.isNotEmpty &&
                      confirmPassword.isNotEmpty);
                  bool _passwordCheck = (newPassword == confirmPassword);

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
                      title: '確認密碼不相同',
                      message: '請重新輸入',
                    );
                  }

                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  final userId = prefs.getString("userId");

                  String requestData = """{
                    "userId": "$userId",
                    "password": "$newPassword"
                  }""";

                  if (_passwordCheck && _textFieldIsNotEmpty) {
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
                  Navigator.pushReplacementNamed(context, Main.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
