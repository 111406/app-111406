///忘記密碼第二頁

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
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
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(height: 10),
                    textField(
                      textFieldName: '確認密碼',
                      hintText: '確認密碼',
                      obscureText: true,
                      icon: Icons.lock,
                      controller: confirmNewPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                mainBtn(
                  text: '重新登入',
                  onPressed: () async {
                    final newPassword = newPasswordController.text,
                        confirmNewPassword = confirmNewPasswordController.text;

                    bool _textFieldIsNotEmpty = (newPassword.isNotEmpty &&
                        confirmNewPassword.isNotEmpty);
                    bool _passwordCheck = (newPassword == confirmNewPassword);

                    if (!_textFieldIsNotEmpty) {
                      showAlertDialog(
                        context,
                        title: '輸入框不得為空白',
                        message: '請重新輸入',
                      );
                    }
                    if (!_passwordCheck && _textFieldIsNotEmpty) {
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
                        _loadingCircle();
                        await HttpRequest.post(
                                '${HttpURL.host}/user/update/password',
                                requestData)
                            .then(
                          (response) async {},
                        );
                        await prefs.setBool('loadingdone', true);
                        showAlertDialog(
                          context,
                          title: '修改成功',
                          message: '',
                        );
                        Timer(const Duration(seconds: 2), () {
                          Navigator.pushReplacementNamed(
                              context, LoginPage.routeName);
                        });
                      } on Exception catch (e) {
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
                    Navigator.pushReplacementNamed(
                        context, LoginPage.routeName);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _loadingCircle() async {
    //讀取
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('changePage', false);
    Timer? _timer1;
    late double _progress;
    EasyLoading.instance
      ..backgroundColor = primaryColor
      ..textColor = Colors.white
      ..progressColor = Colors.white
      ..maskColor = Colors.white70
      ..displayDuration = const Duration(milliseconds: 10000)
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorType = EasyLoadingIndicatorType.wave
      ..maskType = EasyLoadingMaskType.custom
      ..userInteractions = false;

    _progress = 0;
    _timer1?.cancel();
    _timer1 = Timer.periodic(
      const Duration(milliseconds: 500),
      (Timer timer) async {
        EasyLoading.showProgress(_progress,
            status: '${(_progress * 100).toStringAsFixed(0)}%');
        _progress += 0.05;

        if (_progress >= 1 || prefs.getBool('loadingdone') == true) {
          _timer1?.cancel();
          EasyLoading.dismiss();
          await prefs.setBool('loadingdone', false);
        }
      },
    );
    //讀取結束
  }
}
