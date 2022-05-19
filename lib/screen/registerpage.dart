import 'package:flutter/material.dart';
import 'package:sport_app/theme/color.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

Widget _RegisterNumberTF() {
  //帳號輸入框
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
        child: const TextField(
          //keyboardType: TextInputType.emailAddress,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
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
        ),
      ),
    ],
  );
}

Widget _RegisterPasswordTF() {
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
        child: const TextField(
          obscureText: true,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 10),
            prefixIcon: Icon(
              Icons.lock,
              color: primaryColor,
            ),
            hintText: '請輸入密碼',
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
        ),
      ),
    ],
  );
}

Widget _RegisterConPasswordTF() {
  //確認密碼與輸入框
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        '確認密碼',
        style: TextStyle(
            color: primaryColor, fontSize: 24, fontWeight: FontWeight.bold),
      ),
      const SizedBox(
        height: 10.0,
      ),
      Container(
        alignment: Alignment.centerLeft,
        height: 50,
        child: const TextField(
          obscureText: true,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 10),
            prefixIcon: Icon(
              Icons.lock,
              color: primaryColor,
            ),
            hintText: '確認密碼',
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
        ),
      ),
    ],
  );
}

Widget _RegisterEmailTF() {
  //信箱框
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        '信箱',
        style: TextStyle(
            color: primaryColor, fontSize: 24, fontWeight: FontWeight.bold),
      ),
      const SizedBox(
        height: 10.0,
      ),
      Container(
        alignment: Alignment.centerLeft,
        height: 50,
        child: const TextField(
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 10),
            prefixIcon: Icon(
              Icons.email_rounded,
              color: primaryColor,
            ),
            hintText: '請輸入信箱',
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
        ),
      ),
    ],
  );
}

Widget _RegisterNextBtn() {
  //下一步
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 20),
    height: 90,
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () {},
      child: const Text(
        '下一步',
        style: TextStyle(fontSize: 24),
      ),
      style: ElevatedButton.styleFrom(
        primary: primaryColor,
      ),
    ),
  );
}

Widget _RegisterLoginBtn() {
  return Container(
    alignment: Alignment.center,
    child: GestureDetector(
      onTap: () => print('123'),
      child: const Text(
        '我已有帳號',
        style: TextStyle(
            color: primaryColor,
            fontSize: 20,
            decoration: TextDecoration.underline),
      ),
    ),
  );
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
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
                          // fontFamily: 'OpenSans',
                          color: primaryColor,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    _RegisterNumberTF(),
                    const SizedBox(
                      height: 10,
                    ),
                    _RegisterPasswordTF(),
                    const SizedBox(
                      height: 10,
                    ),
                    _RegisterConPasswordTF(),
                    const SizedBox(
                      height: 10,
                    ),
                    _RegisterEmailTF(),
                    const SizedBox(
                      height: 10,
                    ),
                    _RegisterNextBtn(),
                    _RegisterLoginBtn(),
                  ]),
            )),
      ]),
    );
  }
}
