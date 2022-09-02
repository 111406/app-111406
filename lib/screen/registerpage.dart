import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/screen/loginpage.dart';
import 'package:sport_app/screen/registerpage02.dart';
import 'package:sport_app/theme/color.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static const String routeName = "/register";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

Widget _registerNumberTF(userIdController) {
  //帳號輸入框
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        '帳號',
        style: TextStyle(
          color: primaryColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 10.0),
      Container(
        alignment: Alignment.centerLeft,
        height: 50,
        child: TextField(
          //keyboardType: TextInputType.emailAddress,
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(top: 10),
            prefixIcon: Icon(Icons.account_box_rounded, color: primaryColor),
            hintText: '請輸入帳號',
            hintStyle: TextStyle(color: primaryColor),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor, width: 1),
            ),
          ),
          controller: userIdController,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]"))
          ],
        ),
      ),
    ],
  );
}

Widget _registerPasswordTF(passwordController) {
  //密碼與輸入框

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        '密碼',
        style: TextStyle(
          color: primaryColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 10.0),
      Container(
        alignment: Alignment.centerLeft,
        height: 50,
        child: TextField(
          obscureText: true,
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(top: 10),
            prefixIcon: Icon(Icons.lock, color: primaryColor),
            hintText: '請輸入密碼',
            hintStyle: TextStyle(color: primaryColor),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor, width: 1),
            ),
          ),
          controller: passwordController,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]"))
          ],
        ),
      ),
    ],
  );
}

Widget _registerConPasswordTF(cpasswordController) {
  //確認密碼與輸入框
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        '確認密碼',
        style: TextStyle(
          color: primaryColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 10.0),
      Container(
        alignment: Alignment.centerLeft,
        height: 50,
        child: TextField(
          obscureText: true,
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(top: 10),
            prefixIcon: Icon(Icons.lock, color: primaryColor),
            hintText: '確認密碼',
            hintStyle: TextStyle(color: primaryColor),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor, width: 1),
            ),
          ),
          controller: cpasswordController,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]"))
          ],
        ),
      ),
    ],
  );
}

Widget _registerEmailTF(emailController) {
  //信箱框
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        '信箱',
        style: TextStyle(
          color: primaryColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 10.0),
      Container(
        alignment: Alignment.centerLeft,
        height: 50,
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(top: 10),
            prefixIcon: Icon(Icons.email_rounded, color: primaryColor),
            hintText: '請輸入信箱',
            hintStyle: TextStyle(color: primaryColor),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor, width: 1),
            ),
          ),
          controller: emailController,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9@.]"))
          ],
        ),
      ),
    ],
  );
}

Widget _registerLoginBtn(context) {
  return Container(
    alignment: Alignment.center,
    child: GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      },
      child: const Text(
        '我已有帳號',
        style: TextStyle(
          color: primaryColor,
          fontSize: 20,
          decoration: TextDecoration.underline,
        ),
      ),
    ),
  );
}

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
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
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
                        '註冊',
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: primaryColor,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    _registerNumberTF(userIdController),
                    const SizedBox(height: 10),
                    _registerPasswordTF(passwordController),
                    const SizedBox(height: 10),
                    _registerConPasswordTF(cpasswordController),
                    const SizedBox(height: 10),
                    _registerEmailTF(emailController),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      height: 90,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          String userId = userIdController.text;
                          String password = passwordController.text;
                          String email = emailController.text;
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString("userId", userId);
                          prefs.setString("password", password);
                          prefs.setString("email", email);
                          Navigator.pushNamed(
                              context, RegisterPage02.routeName);
                        },
                        child:
                            const Text('下一步', style: TextStyle(fontSize: 24)),
                        style: ElevatedButton.styleFrom(primary: primaryColor),
                      ),
                    ),
                    _registerLoginBtn(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
