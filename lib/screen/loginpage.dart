import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _agree = false;
  Widget _loginEmailTF() {
    //登入與輸入框
    Color primaryColor = HexColor("7C9C99");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '帳號',
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

  Widget _loginPasswordTF() {
    //密碼與輸入框
    Color primaryColor = HexColor("7C9C99");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '密碼',
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

  Widget _loginForgetPasswordBtn() {
    //忘記密碼按鈕
    Color primaryColor = HexColor("7C9C99");
    return Container(
        alignment: Alignment.centerRight,
        child: TextButton(
            onPressed: () {},
            child: Text(
              '忘記密碼',
              style: TextStyle(
                  decoration: TextDecoration.underline, color: primaryColor),
            )));
  }

  Widget _loginCheckbox() {
    Color primaryColor = HexColor("7C9C99");
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
            showAlertDialog(context);
          },
          child: Text(
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
    Color primaryColor = HexColor("7C9C99");
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      height: 90,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
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
    Color primaryColor = HexColor("7C9C99");
    return Container(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () => print('123'),
        child: Text(
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
  Widget build(BuildContext context) {
    Color primaryColor = HexColor("7C9C99");
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
                    SizedBox(
                      height: 20.0,
                    ),
                    _loginEmailTF(),
                    SizedBox(
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

  showAlertDialog(BuildContext context) {
    // Init
    AlertDialog dialog = AlertDialog(
      title: Text("聲明說明"),
      content: Text(('聲明敘述')),
      actions: [
        ElevatedButton(
            child: Text("關閉"),
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
      transitionDuration: Duration(milliseconds: 400),
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
