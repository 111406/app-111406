import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/screen/loadingpage.dart';
import 'package:sport_app/screen/mainpage.dart';
import 'package:sport_app/screen/registerpage.dart';
import 'package:sport_app/theme/color.dart';
import 'package:sport_app/utils/http_request.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String routeName = "/login";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userIdController = TextEditingController();
  final passwordController = TextEditingController();
  bool _agree = false;

  Widget _loginEmailTF() {
    //登入與輸入框
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '帳號',
          style: TextStyle(
              color: primaryColor, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          height: 50,
          // width: 600,
          child: TextField(
            //keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(top: 10),
              prefixIcon: Icon(
                Icons.account_box_rounded,
                color: primaryColor,
              ),
              hintText: '請輸入帳號',
              hintStyle: TextStyle(
                color: primaryColor,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: primaryColor,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: primaryColor,
                  width: 1,
                ),
              ),
            ),
            controller: userIdController,
          ),
        ),
      ],
    );
  }

  Widget _loginPasswordTF() {
    //密碼與輸入框
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '密碼',
          style: TextStyle(
              color: primaryColor, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          height: 50,
          child: TextField(
            //是否隱藏輸入文字
            obscureText: true,
            //輸入文字的顏色
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
              //輸入文字位置
              contentPadding: EdgeInsets.only(top: 10),
              //icon的樣式
              prefixIcon: Icon(
                Icons.lock,
                color: primaryColor,
              ),
              //提示字
              hintText: '請輸入密碼',
              hintStyle: TextStyle(
                color: primaryColor,
              ),
              //框框
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: primaryColor,
                  width: 1,
                ),
              ),
              //輸入時框框的樣式
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: primaryColor,
                  width: 1,
                ),
              ),
            ),
            controller: passwordController,
          ),
        ),
      ],
    );
  }

  Widget _loginForgetPasswordBtn() {
    //忘記密碼按鈕
    return Container(
        alignment: Alignment.centerRight,
        child: TextButton(
            onPressed: () {},
            child: const Text(
              '忘記密碼',
              style: TextStyle(
                  decoration: TextDecoration.underline, color: primaryColor),
            )));
  }

  Widget _loginCheckbox() {
    //免責聲明勾選按鈕
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
              }),
        ),
        GestureDetector(
          onTap: () {
            showAlertDialog(context, "免責聲明", "免責聲明");
          },
          child: const Text(
            '我已經詳閱並同意個人資料\n蒐集條款，與免責說明',
            style: TextStyle(
                decoration: TextDecoration.underline, color: primaryColor),
          ),
        )
      ]),
    );
  }

  Widget _loginBtn() {
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
            await HttpRequest()
                .post('${HttpURL.host}/api/user/login', requestData)
                .then((response) async {
              final prefs = await SharedPreferences.getInstance();
              prefs.setString("loginUser", userId);
              Navigator.pushReplacementNamed(context, LoadingPage.routeName);
              prefs.setBool('loginloadingpage', true);
            });
          }
        },
        child: const Text(
          '登入',
          style: TextStyle(fontSize: 24),
        ),
        style: ElevatedButton.styleFrom(
          primary: primaryColor,
        ),
      ),
    );
  }

  Widget _loginRegisterBtn() {
    return Container(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, RegisterPage.routeName);
        },
        child: const Text(
          '尚未有帳號，註冊',
          style: TextStyle(
              color: primaryColor,
              fontSize: 20,
              decoration: TextDecoration.underline),
        ),
      ),
    );
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
      body: Stack(children: [
        Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 80.0,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/icon/logo01.png',
                        fit: BoxFit.contain,
                        width: 150,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: const Text(
                        '登入',
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          // fontFamily: 'OpenSans',
                          color: primaryColor,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    _loginEmailTF(),
                    const SizedBox(
                      height: 20,
                    ),
                    _loginPasswordTF(),
                    _loginForgetPasswordBtn(),
                    _loginCheckbox(),
                    _loginBtn(),
                    _loginRegisterBtn(),
                  ]),
            )),
      ]),
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
            }),
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
