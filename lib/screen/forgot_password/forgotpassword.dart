///忘記密碼第一頁

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/screen/components/app_logo.dart';
import 'package:sport_app/screen/components/button.dart';
import 'package:sport_app/screen/components/page_title.dart';
import 'package:sport_app/screen/components/textfield_inputbox.dart';
import 'package:sport_app/screen/forgot_password/forgotpassword02.dart';
import 'package:sport_app/screen/login/login.dart';
import 'package:sport_app/theme/color.dart';
import 'package:sport_app/utils/alertdialog.dart';
import 'dart:async';

import 'package:sport_app/utils/http_request.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);
  static const String routeName = "/forgotpassword";

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  Timer? timer;
  int _countdownTime = 0;
  final emailAddressController = TextEditingController();
  final optCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailAddressController.dispose();
    optCodeController.dispose();
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
                pageTitle('忘記密碼'),
                const SizedBox(height: 30),
                Column(
                  children: [
                    textField(
                      textFieldName: '電子郵件信箱',
                      hintText: '請輸入電子郵件信箱',
                      icon: Icons.mail,
                      controller: emailAddressController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 10),
                    textField(
                      textFieldName: '驗證碼',
                      hintText: '請輸入驗證碼',
                      icon: Icons.lock,
                      controller: optCodeController,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            final email = emailAddressController.text;
                            String requestData = """{
                                "email": "$email"
                              }""";
                            if (_countdownTime == 0 && email.isNotEmpty) {
                              try {
                                await HttpRequest.post(
                                        '${HttpURL.host}/mail/code',
                                        requestData)
                                    .then(
                                  (response) async {
                                    showAlertDialog(
                                      context,
                                      title: '',
                                      message: '驗證碼已傳送',
                                    );
                                    setState(() {
                                      _countdownTime = 60;
                                    });
                                    startCountdownTimer();
                                  },
                                );
                              } on Exception catch (e) {
                                showAlertDialog(
                                  context,
                                  title: '',
                                  message: '請輸入已註冊之電子郵件',
                                );
                              }
                            } else if (email.isEmpty) {
                              showAlertDialog(
                                context,
                                title: '',
                                message: '請輸入已註冊之電子郵件',
                              );
                            } else {
                              showAlertDialog(
                                context,
                                title: '驗證碼已傳送',
                                message: '請等候$_countdownTime秒後重新獲取',
                              );
                            }
                          },
                          child: Text(
                            _countdownTime > 0
                                ? '$_countdownTime秒後重新獲取'
                                : '獲取驗證碼',
                            style: TextStyle(
                              fontSize: 14,
                              color: _countdownTime > 0
                                  ? const Color.fromARGB(255, 183, 184, 195)
                                  : Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: primaryColor, elevation: 5),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                mainBtn(
                  text: '下一步',
                  onPressed: () async {
                    final email = emailAddressController.text;
                    final optCode = optCodeController.text;

                    String requestData = """{
                        "email": "$email", 
                        "otp": "$optCode"
                      }""";

                    if (email.isNotEmpty && optCode.isNotEmpty) {
                      try {
                        await HttpRequest.post(
                                '${HttpURL.host}/mail/validate', requestData)
                            .then(
                          (response) async {},
                        );
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString("email", email);

                        showAlertDialog(
                          context,
                          title: '驗證碼正確',
                          message: '驗證碼正確\n請繼續下一步',
                        );

                        Navigator.pushReplacementNamed(
                            context, ForgotPassword02.routeName);
                      } on Exception catch (e) {
                        showAlertDialog(
                          context,
                          title: '驗證碼錯誤',
                          message: '請重新輸入驗證碼',
                        );
                      }
                    } else {
                      // TODO: @cheese
                      showAlertDialog(
                        context,
                        title: '輸入框不得為空白',
                        message: '請重新輸入',
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),
                underScoreBtn(
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

  void startCountdownTimer() {
    const oneSec = Duration(seconds: 1);

    var callback = (timer) => {
          setState(() {
            if (_countdownTime < 1) {
              timer.cancel();
            } else {
              _countdownTime = _countdownTime - 1;
            }
          }),
        };

    timer = Timer.periodic(oneSec, callback);
  }
}
