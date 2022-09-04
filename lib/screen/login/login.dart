import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/screen/components/app_logo.dart';
import 'package:sport_app/screen/components/button.dart';
import 'package:sport_app/screen/components/page_title.dart';
import 'package:sport_app/screen/components/textfield_inputbox.dart';
import 'package:sport_app/screen/forgot_password/forgotpassword.dart';
import 'package:sport_app/screen/main_page.dart';
import 'package:sport_app/screen/regitster/register.dart';
import 'package:sport_app/theme/color.dart';
import 'package:sport_app/utils/alertdialog.dart';
import 'package:sport_app/utils/http_request.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:async';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String routeName = "/login";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _agree = false;
  final userIdController = TextEditingController();
  final passwordController = TextEditingController();

  Widget _loginCheckbox() {
    //免責聲明勾選按鈕
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Theme(
          data: ThemeData(unselectedWidgetColor: primaryColor),
          child: Checkbox(
            value: _agree,
            checkColor: Colors.white,
            activeColor: primaryColor,
            onChanged: (value) {
              setState(() {
                _agree = value!;
              });
            },
          ),
        ),
        GestureDetector(
          onTap: () {
            showAlertDialog(
              context,
              title: "免責聲明",
              message: "免責聲明",
            );
          },
          child: const Text(
            '我已經詳閱並同意個人資料\n蒐集條款，與免責說明',
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: primaryColor,
            ),
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    userIdController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Timer? _timer1;
    late double _progress;

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 40),
          child: Column(
            children: [
              appLogo(),
              pageTitle('登入'),
              const SizedBox(height: 20),
              Column(
                children: [
                  textField(
                    textFieldName: '帳號',
                    hintText: '請輸入帳號',
                    icon: Icons.account_box_rounded,
                    controller: userIdController,
                  ),
                  const SizedBox(height: 10),
                  textField(
                    textFieldName: '密碼',
                    hintText: '請輸入密碼',
                    obscureText: true,
                    icon: Icons.lock,
                    controller: passwordController,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              underScoreBtn(
                text: '忘記密碼',
                alignment: Alignment.centerRight,
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, ForgotPassword.routeName);
                },
              ),
              const SizedBox(height: 20),
              _loginCheckbox(),
              const SizedBox(height: 50),
              mainBtn(
                // 登入按鈕
                text: '登入',
                onPressed: () async {
                  if (!_agree) {
                    showAlertDialog(
                      context,
                      title: "登入失敗",
                      message: "請勾選同意條款聲明",
                    );
                  } else {
                    String userId = userIdController.text;
                    String requestData = """{
                    "user_id": "$userId",
                    "password": "${passwordController.text}"
                    }""";

                    EasyLoading.instance
                      ..backgroundColor = primaryColor
                      ..textColor = Colors.white
                      ..progressColor = Colors.white
                      ..maskColor = Colors.white70
                      ..displayDuration = const Duration(milliseconds: 1500)
                      ..loadingStyle = EasyLoadingStyle.custom
                      ..indicatorType = EasyLoadingIndicatorType.wave
                      ..maskType = EasyLoadingMaskType.custom
                      ..userInteractions = false;

                    _progress = 0;
                    _timer1?.cancel();
                    _timer1 = Timer.periodic(
                      const Duration(milliseconds: 100),
                      (Timer timer) {
                        EasyLoading.showProgress(_progress,
                            status: '${(_progress * 100).toStringAsFixed(0)}%');
                        _progress += 0.04;

                        if (_progress >= 1) {
                          _timer1?.cancel();
                          EasyLoading.dismiss();
                        }
                      },
                    );
                    await HttpRequest()
                        .post('${HttpURL.host}/api/user/login', requestData)
                        .then(
                      (response) async {
                        final prefs = await SharedPreferences.getInstance();
                        // prefs.setString("loginUser", userId);
                        prefs.setString("userId", userId);
                        Navigator.pushReplacementNamed(context, Main.routeName);
                      },
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              underScoreBtn(
                text: '尚未有帳號，註冊',
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, RegisterPage.routeName);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
