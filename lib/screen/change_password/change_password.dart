///變更密碼頁

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/screen/components/app_logo.dart';
import 'package:sport_app/screen/components/button.dart';
import 'package:sport_app/screen/components/page_title.dart';
import 'package:sport_app/screen/components/textfield_inputbox.dart';
import 'package:sport_app/screen/main_page.dart';
import 'package:sport_app/theme/color.dart';
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
  late Timer _timer;

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
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
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
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(height: 10),
                    textField(
                      obscureText: true,
                      textFieldName: '新密碼',
                      hintText: '請輸入新密碼',
                      icon: Icons.lock,
                      controller: newPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(height: 10),
                    textField(
                      obscureText: true,
                      textFieldName: '確認密碼',
                      hintText: '確認密碼',
                      icon: Icons.lock,
                      controller: confirmPasswordController,
                      keyboardType: TextInputType.visiblePassword,
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
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    final userId = prefs.getString("userId");

                    String requestData = """{
                      "user_id": "$userId",
                      "old_password": "$oldPassword",
                      "new_password": "$newPassword"
                    }""";
                    if (!_textFieldIsNotEmpty) {
                      showAlertDialog(
                        context,
                        title: '輸入框不得為空白',
                        message: '請重新輸入',
                      );
                    } else if (!_passwordCheck && _textFieldIsNotEmpty) {
                      showAlertDialog(
                        context,
                        title: '確認密碼不相同',
                        message: '請重新輸入',
                      );
                    } else {
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
                              context, Main.routeName);
                        });
                      } on Exception catch (e) {
                        _timer.cancel();
                        EasyLoading.dismiss();
                        showAlertDialog(context,
                            title: '修改失敗', message: e.toString().split(" ")[1]);
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
      ),
    );
  }

  Future<void> _loadingCircle() async {
    //讀取
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('changePage', false);

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
    // _timer.cancel();
    _timer = Timer.periodic(
      const Duration(milliseconds: 500),
      (Timer timer) async {
        EasyLoading.showProgress(_progress, status: '載入中...');
        _progress += 0.05;

        if (_progress >= 1 || prefs.getBool('loadingdone') == true) {
          _timer.cancel();
          EasyLoading.dismiss();
          await prefs.setBool('loadingdone', false);
        }
      },
    );
    //讀取結束
  }
}
