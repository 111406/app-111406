import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/screen/components/app_logo.dart';
import 'package:sport_app/screen/components/button.dart';
import 'package:sport_app/screen/components/page_title.dart';
import 'package:sport_app/screen/components/textfield_inputbox.dart';
import 'package:sport_app/screen/forgot_password/forgotpassword.dart';
import 'package:sport_app/screen/main_page.dart';
import 'package:sport_app/screen/manual/manual.dart';
import 'package:sport_app/screen/regitster/register.dart';
import 'package:sport_app/theme/color.dart';
import 'package:sport_app/utils/alertdialog.dart';
import 'package:sport_app/utils/app_utils.dart';
import 'package:sport_app/utils/http_request.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:async';

import '../../model/user_todo.dart';
import '../../utils/app_config.dart';
import '../intro/intropage.dart';

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
  late Timer _timer;

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
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setInt('manualControll', 1);
            Navigator.pushReplacementNamed(context, Manual.routeName);
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
    _loadPrefs();
  }

  void _loadPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userIdController.text = prefs.getString("userId") ?? "";
    });
  }

  @override
  void dispose() {
    userIdController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool onClick = false;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
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
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 10),
                    textField(
                      textFieldName: '密碼',
                      hintText: '請輸入密碼',
                      obscureText: true,
                      icon: Icons.lock,
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                underScoreBtn(
                  text: '忘記密碼',
                  alignment: Alignment.centerRight,
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, ForgotPassword.routeName);
                  },
                ),
                const SizedBox(height: 20),
                _loginCheckbox(),
                const SizedBox(height: 50),
                mainBtn(
                  // 登入按鈕
                  text: '登入',
                  onPressed: () async {
                    if (!onClick) {
                      onClick = true;
                      if (!_agree) {
                        showAlertDialog(
                          context,
                          title: "登入失敗",
                          message: "請勾選同意條款聲明",
                        );
                      } else {
                        final userId = userIdController.text;
                        final password = passwordController.text;
                        final fcmToken = await AppUtils.getToken();
                        String requestData = """{
                        "user_id": "$userId",
                        "password": "${passwordController.text}",
                        "registration_token": "$fcmToken"
                        }""";
                        bool _textFieldIsNotEmpty = (userId.isNotEmpty && password.isNotEmpty);
                        if (_textFieldIsNotEmpty) {
                          try {
                            _loadingCircle();
                            await HttpRequest.post('${HttpURL.host}/user/login', requestData).then(
                              (response) async {
                                final prefs = await SharedPreferences.getInstance();
                                prefs.setString("userId", userId);
                                prefs.setBool('isLoginForFirstTime', true);
                                bool checkComplete = true;
                                List checkCompleteList = [];
                                await prefs.remove("trainingState");
                                final todoList = <UserTodo>[];
                                final todoMap = {};
                                await HttpRequest.get('${HttpURL.host}/target/$userId').then((response) async {
                                  final dataList = response['data'] as List;
                                  if (dataList.isNotEmpty) {
                                    // 有本周訓練資料
                                    for (var data in response['data']) {
                                      var todo = UserTodo.fromJson(data);
                                      checkCompleteList.add(todo.complete);

                                      todoMap[todo.targetDate] = todo;
                                      todoList.add(todo);
                                    }
                                    checkComplete = checkCompleteList.contains(false);

                                    await prefs.setString("todoMap", json.encode(todoMap));

                                    // TODO 訓練表部分待調整
                                    if (checkComplete) {
                                      prefs.setString("userTodo", json.encode(todoList.firstWhere((element) => !element.complete)));
                                    }
                                  } else {
                                    // 檢查是不是剛做完檢測，因為不會馬上指派任務
                                    await HttpRequest.get('${HttpURL.host}/target/started/$userId').then((response) {
                                      final isHadTarget = response['data'];
                                      prefs.remove("todoList");
                                      prefs.remove("userTodo");
                                      if (isHadTarget) {
                                        // 如果是剛檢測完會跑到這
                                        prefs.setString("trainingState", AppConfig.WAITING_TRAINING);
                                      } else {
                                        // 代表還沒做檢測
                                        prefs.setString("trainingState", AppConfig.CANNOT_TRAINING);
                                      }
                                    });
                                  }
                                });
                                if (!checkComplete) {
                                  // 進到這裡表示本周任務已完成
                                  prefs.setString("trainingState", AppConfig.TRAINING_FINISH);
                                }

                                // TODO check
                                await HttpRequest.get('${HttpURL.host}/user/$userId').then((response) {
                                  var height = response['data']['height'] ?? .0;
                                  var weight = response['data']['weight'] ?? .0;
                                  var birth = response['data']['birthday'];
                                  var gender = response['data']['gender'];
                                  var ethsum = response['data']['eth_sum'];

                                  prefs.setDouble("height", height);
                                  prefs.setDouble("weight", weight);
                                  prefs.setString("birthday", birth);
                                  prefs.setString("gender", gender);
                                  prefs.setString("ethsum", ethsum.toString());
                                });
                                if (prefs.getBool('routeTointro') == true) {
                                  _timer.cancel();
                                  EasyLoading.dismiss();
                                  Navigator.pushReplacementNamed(context, IntroPage.routeName);
                                  prefs.setBool('routeTointro', false);
                                } else {
                                  _timer.cancel();
                                  EasyLoading.dismiss();
                                  Navigator.pushReplacementNamed(context, Main.routeName);
                                }
                              },
                            );
                          } on Exception catch (e) {
                            _timer.cancel();
                            EasyLoading.dismiss();
                            showAlertDialog(
                              context,
                              title: '帳號或密碼錯誤',
                              message: '請重新輸入',
                            );
                          }
                        } else {
                          showAlertDialog(
                            context,
                            title: '輸入框不得為空白',
                            message: '請重新輸入',
                          );
                        }
                      }
                      onClick = false;
                    }
                  },
                ),
                const SizedBox(height: 20),
                underScoreBtn(
                  text: '尚未有帳號，註冊',
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.clear();
                    Navigator.pushReplacementNamed(context, RegisterPage.routeName);
                  },
                )
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
    _timer = Timer.periodic(
      const Duration(milliseconds: 750),
      (Timer timer) async {
        EasyLoading.showProgress(_progress, status: '載入中...');
        _progress += 0.05;

        if (_progress >= 1 || prefs.getBool('changePage') == true) {
          _timer.cancel();
          EasyLoading.dismiss();
          await prefs.setBool('changePage', false);
        }
      },
    );
    //讀取結束
  }
}
