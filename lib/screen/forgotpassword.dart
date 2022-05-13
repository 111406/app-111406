import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

Widget _forgotPsEmailTF() {
  //信箱框
  Color primaryColor = HexColor("7C9C99");
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '信箱',
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

Widget _forgotPsCodeTF() {
  //驗證碼框
  Color primaryColor = HexColor("7C9C99");
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '驗證碼',
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
            hintText: '驗證碼認證',
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

Widget _forgotPsNext() {
  //下一步
  Color primaryColor = HexColor("7C9C99");
  return Container(
    padding: EdgeInsets.symmetric(vertical: 20),
    height: 90,
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () {},
      child: Text(
        '下一步',
        style: TextStyle(fontSize: 24),
      ),
      style: ElevatedButton.styleFrom(
        primary: primaryColor,
      ),
    ),
  );
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Color primaryColor = HexColor("7C9C99");
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
                    _forgotPsEmailTF(),
                    SizedBox(
                      height: 20,
                    ),
                    _forgotPsCodeTF(),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  "寄送驗證碼",
                                  style: const TextStyle(fontSize: 20),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: primaryColor,
                                  elevation: 5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _forgotPsNext(),
                  ]),
            )),
      ]),
    );
  }
}
