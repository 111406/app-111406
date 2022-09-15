///註冊第一頁

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/screen/components/app_logo.dart';
import 'package:sport_app/screen/components/button.dart';
import 'package:sport_app/screen/components/page_title.dart';
import 'package:sport_app/screen/components/textfield_inputbox.dart';
import 'package:sport_app/screen/login/login.dart';
import 'package:sport_app/screen/regitster/register_next.dart';
import 'package:sport_app/utils/alertdialog.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static const String routeName = "/register";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

// Widget _registerNumberTF(userIdController) {
//   //帳號輸入框
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       const Text(
//         '帳號',
//         style: TextStyle(
//           color: primaryColor,
//           fontSize: 24,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       const SizedBox(height: 10.0),
//       Container(
//         alignment: Alignment.centerLeft,
//         height: 50,
//         child: TextField(
//           //keyboardType: TextInputType.emailAddress,
//           style: const TextStyle(color: Colors.black),
//           decoration: const InputDecoration(
//             contentPadding: EdgeInsets.only(top: 10),
//             prefixIcon: Icon(Icons.account_box_rounded, color: primaryColor),
//             hintText: '請輸入帳號',
//             hintStyle: TextStyle(color: primaryColor),
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: primaryColor, width: 1),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: primaryColor, width: 1),
//             ),
//           ),
//           controller: userIdController,
//           inputFormatters: [
//             FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]"))
//           ],
//         ),
//       ),
//     ],
//   );
// }

// Widget _registerPasswordTF(passwordController) {
//   //密碼與輸入框
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       const Text(
//         '密碼',
//         style: TextStyle(
//           color: primaryColor,
//           fontSize: 24,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       const SizedBox(height: 10.0),
//       Container(
//         alignment: Alignment.centerLeft,
//         height: 50,
//         child: TextField(
//           obscureText: true,
//           style: const TextStyle(color: Colors.black),
//           decoration: const InputDecoration(
//             contentPadding: EdgeInsets.only(top: 10),
//             prefixIcon: Icon(Icons.lock, color: primaryColor),
//             hintText: '請輸入密碼',
//             hintStyle: TextStyle(color: primaryColor),
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: primaryColor, width: 1),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: primaryColor, width: 1),
//             ),
//           ),
//           controller: passwordController,
//           inputFormatters: [
//             FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]"))
//           ],
//         ),
//       ),
//     ],
//   );
// }

// Widget _registerConPasswordTF(cpasswordController) {
//   //確認密碼與輸入框
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       const Text(
//         '確認密碼',
//         style: TextStyle(
//           color: primaryColor,
//           fontSize: 24,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       const SizedBox(height: 10.0),
//       Container(
//         alignment: Alignment.centerLeft,
//         height: 50,
//         child: TextField(
//           obscureText: true,
//           style: const TextStyle(color: Colors.black),
//           decoration: const InputDecoration(
//             contentPadding: EdgeInsets.only(top: 10),
//             prefixIcon: Icon(Icons.lock, color: primaryColor),
//             hintText: '確認密碼',
//             hintStyle: TextStyle(color: primaryColor),
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: primaryColor, width: 1),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: primaryColor, width: 1),
//             ),
//           ),
//           controller: cpasswordController,
//           inputFormatters: [
//             FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]"))
//           ],
//         ),
//       ),
//     ],
//   );
// }

// Widget _registerEmailTF(emailController) {
//   //信箱框
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       const Text(
//         '信箱',
//         style: TextStyle(
//           color: primaryColor,
//           fontSize: 24,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       const SizedBox(height: 10.0),
//       Container(
//         alignment: Alignment.centerLeft,
//         height: 50,
//         child: TextField(
//           keyboardType: TextInputType.emailAddress,
//           style: const TextStyle(color: Colors.black),
//           decoration: const InputDecoration(
//             contentPadding: EdgeInsets.only(top: 10),
//             prefixIcon: Icon(Icons.email_rounded, color: primaryColor),
//             hintText: '請輸入信箱',
//             hintStyle: TextStyle(color: primaryColor),
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: primaryColor, width: 1),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: primaryColor, width: 1),
//             ),
//           ),
//           controller: emailController,
//           inputFormatters: [
//             FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9@.]"))
//           ],
//         ),
//       ),
//     ],
//   );
// }

// Widget _registerLoginBtn(context) {
//   return Container(
//     alignment: Alignment.center,
//     child: GestureDetector(
//       onTap: () {
//         Navigator.pushReplacementNamed(context, LoginPage.routeName);
//       },
//       child: const Text(
//         '我已有帳號',
//         style: TextStyle(
//           color: primaryColor,
//           fontSize: 20,
//           decoration: TextDecoration.underline,
//         ),
//       ),
//     ),
//   );
// }

class _RegisterPageState extends State<RegisterPage> {
  final userIdController = TextEditingController();
  final passwordController = TextEditingController();
  final cpasswordController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void dispose() {
    userIdController.dispose();
    passwordController.dispose();
    cpasswordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
            child: Column(
              children: [
                appLogo(),
                pageTitle('註冊'),
                const SizedBox(height: 5),
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
                    const SizedBox(height: 10),
                    textField(
                      textFieldName: '確認密碼',
                      hintText: '確認密碼',
                      obscureText: true,
                      icon: Icons.lock,
                      controller: cpasswordController,
                    ),
                    const SizedBox(height: 10),
                    textField(
                      textFieldName: '信箱',
                      hintText: '請輸入信箱',
                      icon: Icons.email,
                      controller: emailController,
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                mainBtn(
                  // 下一步按鈕
                  onPressed: () async {
                    String userId = userIdController.text;
                    String password = passwordController.text;
                    String confirmPassword = cpasswordController.text;
                    String email = emailController.text;

                    bool _textFieldIsNotEmpty = userId.isNotEmpty &&
                        password.isNotEmpty &&
                        confirmPassword.isNotEmpty &&
                        email.isNotEmpty;
                    bool _passwordCheck = (password == confirmPassword);

                    if (_textFieldIsNotEmpty && _passwordCheck) {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString("userId", userId);
                      prefs.setString("password", password);
                      prefs.setString("email", email);
                      Navigator.pushNamed(context, RegisterPage02.routeName);
                    } else if (!_passwordCheck) {
                      showAlertDialog(
                        context,
                        title: '密碼與確認密碼不相同',
                        message: '請重新輸入',
                      );
                    } else {
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
                  text: '我已有帳號，返回登入',
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, LoginPage.routeName);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
