import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/screen/components/app_logo.dart';
import 'package:sport_app/screen/components/page_title.dart';
import 'package:sport_app/screen/components/textfield_inputbox.dart';
import 'package:sport_app/screen/forgotpassword.dart';
import 'package:sport_app/screen/main_page.dart';
import 'package:sport_app/screen/regitster/register.dart';
import 'package:sport_app/theme/color.dart';
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
  // Timer? _timer1;
  // late double _progress;
  final userIdController = TextEditingController();
  final passwordController = TextEditingController();

  Widget _loginForgetPasswordBtn() {
    //忘記密碼按鈕
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, ForgotPassword.routeName);
        },
        child: const Text(
          '忘記密碼',
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: primaryColor,
          ),
        ),
      ),
    );
  }

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
            showAlertDialog(context, "免責聲明", "免責聲明");
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

  Widget _loginBtn() {
    Timer? _timer1;
    late double _progress;
    //登入按鈕
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      height: 90,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          if (!_agree) {
            showAlertDialog(context, "登入失敗", "請勾選同意條款聲明");
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
        child: const Text('登入', style: TextStyle(fontSize: 24)),
        style: ElevatedButton.styleFrom(primary: primaryColor),
      ),
    );
  }

  Widget _loginRegisterBtn() {
    return Container(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          Navigator.pushReplacementNamed(context, RegisterPage.routeName);
        },
        child: const Text(
          '尚未有帳號，註冊',
          style: TextStyle(
            color: primaryColor,
            fontSize: 20,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
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
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 40),
          child: Column(
            children: [
              appLogo(),
              pageTitle('登入'),
              const SizedBox(height: 20),
              textField(
                textFieldName: '帳號',
                hintText: '請輸入帳號',
                icon: Icons.account_box_rounded,
                controller: userIdController,
              ),
              // _loginEmailTF(),
              const SizedBox(height: 20),
              // _loginPasswordTF(),
              textField(
                textFieldName: '密碼',
                hintText: '請輸入密碼',
                obscureText: true,
                icon: Icons.lock,
                controller: passwordController,
              ),
              _loginForgetPasswordBtn(),
              _loginCheckbox(),
              _loginBtn(),
              _loginRegisterBtn(),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(context, title, message) {
    // Init
    AlertDialog dialog = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        ElevatedButton(
          child: const Text("關閉"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );

    // Show the dialog (showDialog() => showGeneralDialog())
    showGeneralDialog(
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
}
// children: [
//         Container(
//           height: double.infinity,
//           child: SingleChildScrollView(
//             physics: AlwaysScrollableScrollPhysics(),
//             padding: EdgeInsets.symmetric(
//               horizontal: 40.0,
//               vertical: 120.0,
//             ),
//             child:
//                 Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//               Text(
//                 '肌動GO',
//                 style: TextStyle(
//                   decoration: TextDecoration.none,
//                   fontFamily: 'OpenSans',
//                   color: Colors.white,
//                   fontSize: 30.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               )
//             ]),
//           ),
//         ),
//       ],
