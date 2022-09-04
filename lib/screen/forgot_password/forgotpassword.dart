import 'package:flutter/material.dart';
import 'package:sport_app/screen/components/app_logo.dart';
import 'package:sport_app/screen/components/button.dart';
import 'package:sport_app/screen/components/page_title.dart';
import 'package:sport_app/screen/components/textfield_inputbox.dart';
import 'package:sport_app/theme/color.dart';
import 'dart:async';

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
              pageTitle('忘記密碼'),
              const SizedBox(height: 20),
              textField(
                textFieldName: '電子郵件信箱',
                hintText: '請輸入電子郵件信箱',
                icon: Icons.mail,
                controller: emailAddressController,
              ),
              const SizedBox(height: 20),
              textField(
                textFieldName: '驗證碼',
                hintText: '請輸入驗證碼',
                icon: Icons.lock,
                controller: emailAddressController,
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_countdownTime == 0) {
                            setState(() {
                              _countdownTime = 60;
                            });
                            startCountdownTimer();
                          } else {
                            return;
                          }
                        },
                        child: Text(
                          _countdownTime > 0 ? '$_countdownTime後重新獲取' : '獲取驗證碼',
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
                onPressed: () {},
              )
            ],
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
