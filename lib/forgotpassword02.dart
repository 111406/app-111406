import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ForgotPassword02 extends StatefulWidget {
  const ForgotPassword02({Key? key}) : super(key: key);

  @override
  State<ForgotPassword02> createState() => _ForgotPassword02State();
}

Widget _forgotPsNewPsTF() {
  //新密碼框
  Color primaryColor = HexColor("7C9C99");
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '新密碼',
        style: TextStyle(
            color: primaryColor, fontSize: 24, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 10.0,
      ),
      Container(
        alignment: Alignment.centerLeft,
        height: 50,
        child: TextField(
          // keyboardType: TextInputType.emailAddress,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 10),
            prefixIcon: Icon(
              Icons.lock,
              color: primaryColor,
            ),
            hintText: '新密碼',
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

Widget _forgotPsNewPsConf() {
  //確認新密碼
  Color primaryColor = HexColor("7C9C99");
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '確認密碼',
        style: TextStyle(
            color: primaryColor, fontSize: 24, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 10.0,
      ),
      Container(
        alignment: Alignment.centerLeft,
        height: 50,
        child: TextField(
          //keyboardType: TextInputType.emailAddress,
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

Widget _forgotPsLoginBtn() {
  //重新登入按紐
  Color primaryColor = HexColor("7C9C99");
  return Container(
    padding: EdgeInsets.symmetric(vertical: 20),
    height: 90,
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () {},
      child: Text(
        '重新登入',
        style: TextStyle(fontSize: 24),
      ),
      style: ElevatedButton.styleFrom(
        primary: primaryColor,
      ),
    ),
  );
}

class _ForgotPassword02State extends State<ForgotPassword02> {
  Color primaryColor = HexColor("7C9C99");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
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
                      child: Text(
                        '忘記密碼',
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          // fontFamily: 'OpenSans',
                          color: primaryColor,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _forgotPsNewPsTF(),
                    SizedBox(
                      height: 20,
                    ),
                    _forgotPsNewPsConf(),
                    SizedBox(
                      height: 30,
                    ),
                    _forgotPsLoginBtn(),
                  ]),
            )),
      ]),
    );
  }
}
