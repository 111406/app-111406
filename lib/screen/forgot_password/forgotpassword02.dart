import 'package:flutter/material.dart';
import 'package:sport_app/theme/color.dart';

class ForgotPassword02 extends StatefulWidget {
  const ForgotPassword02({Key? key}) : super(key: key);

  @override
  State<ForgotPassword02> createState() => _ForgotPassword02State();
}

Widget _forgotPsNewPsTF() {
  //新密碼框
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        '新密碼',
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
        child: const TextField(
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 10),
            prefixIcon: Icon(Icons.lock, color: primaryColor),
            hintText: '新密碼',
            hintStyle: TextStyle(color: primaryColor),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor, width: 1),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _forgotPsNewPsConf() {
  //確認新密碼
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
        child: const TextField(
          //keyboardType: TextInputType.emailAddress,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
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
        ),
      ),
    ],
  );
}

Widget _forgotPsLoginBtn() {
  //重新登入按紐
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 20),
    height: 90,
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () {},
      child: const Text('重新登入', style: TextStyle(fontSize: 24)),
      style: ElevatedButton.styleFrom(primary: primaryColor),
    ),
  );
}

class _ForgotPassword02State extends State<ForgotPassword02> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      '忘記密碼',
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: primaryColor,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _forgotPsNewPsTF(),
                  const SizedBox(height: 20),
                  _forgotPsNewPsConf(),
                  const SizedBox(height: 30),
                  _forgotPsLoginBtn(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
