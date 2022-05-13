import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class RegisterPage02 extends StatefulWidget {
  const RegisterPage02({Key? key}) : super(key: key);

  @override
  State<RegisterPage02> createState() => _RegisterPage02State();
}

Widget _RegisterHeightTF() {
  //身高
  Color primaryColor = HexColor("7C9C99");
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '身高',
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
            hintText: '公分',
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

Widget _RegisterWeightTF() {
  //體重
  Color primaryColor = HexColor("7C9C99");
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '體重',
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
              Icons.account_box_rounded,
              color: primaryColor,
            ),
            hintText: '公斤',
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

Widget _RegisterBirTF() {
  //生日
  Color primaryColor = HexColor("7C9C99");
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '生日',
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
              Icons.account_box_rounded,
              color: primaryColor,
            ),
            hintText: '民國年/月/日',
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

// Widget _RegisterGenderTF() {
//   //性別 目前用不到
//   bool _normalHasBeenPressed = true;
//   bool _visionHasBeenPressed = false;
//   //登入與輸入框
//   Color primaryColor = HexColor("7C9C99");
//   Color thirdColor = HexColor("AAD4D0");
//   return Column(
//     children: [
//       Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             padding: const EdgeInsets.symmetric(
//               vertical: 30,
//             ),
//             child: ElevatedButton(
//               onPressed: () {
//                 setState() {
//                   _normalHasBeenPressed = true;
//                   _visionHasBeenPressed = false;
//                 }

//                 ;
//               },
//               child: Text(
//                 "一般模式",
//                 style: const TextStyle(fontSize: 20),
//               ),
//               style: ElevatedButton.styleFrom(
//                 primary: _normalHasBeenPressed ? primaryColor : thirdColor,
//                 elevation: 5,
//               ),
//             ),
//           ),
//           SizedBox(
//             width: 35,
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(
//               vertical: 30,
//             ),
//             child: ElevatedButton(
//               onPressed: () {
//                 setState() {
//                   _normalHasBeenPressed = false;
//                   _visionHasBeenPressed = true;
//                 }

//                 ;
//               },
//               child: Text(
//                 "視覺辨識",
//                 style: const TextStyle(fontSize: 20),
//               ),
//               style: ElevatedButton.styleFrom(
//                 primary: _visionHasBeenPressed ? primaryColor : thirdColor,
//                 elevation: 5,
//               ),
//             ),
//           ),
//         ],
//       ),
//     ],
//   );
// }

Widget _RegisterDoneBtn() {
  //完成註冊按鈕
  Color primaryColor = HexColor("7C9C99");
  return Container(
    padding: EdgeInsets.symmetric(vertical: 20),
    height: 90,
    width: double.infinity,
    child: ElevatedButton(
      onPressed: () {},
      child: Text(
        '完成/返回登入',
        style: TextStyle(fontSize: 24),
      ),
      style: ElevatedButton.styleFrom(
        primary: primaryColor,
      ),
    ),
  );
}

Widget _RegisterPreBtn() {
  Color primaryColor = HexColor("7C9C99");
  return Container(
    alignment: Alignment.center,
    child: GestureDetector(
      onTap: () => print('123'),
      child: Text(
        '上一步',
        style: TextStyle(
            color: primaryColor,
            fontSize: 20,
            decoration: TextDecoration.underline),
      ),
    ),
  );
}

class _RegisterPage02State extends State<RegisterPage02> {
  bool _normalHasBeenPressed = true;
  bool _visionHasBeenPressed = false;
  Color primaryColor = HexColor("7C9C99");
  Color thirdColor = HexColor("AAD4D0");

  String? _selectedColor;
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
                    SizedBox(
                      height: 5,
                    ),
                    _RegisterHeightTF(),
                    SizedBox(
                      height: 10,
                    ),
                    _RegisterWeightTF(),
                    SizedBox(
                      height: 10,
                    ),
                    _RegisterBirTF(),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '性別選擇',
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _normalHasBeenPressed = true;
                                    _visionHasBeenPressed = false;
                                  });
                                },
                                child: Text(
                                  "男生",
                                  style: const TextStyle(fontSize: 20),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: _normalHasBeenPressed
                                      ? primaryColor
                                      : thirdColor,
                                  elevation: 5,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 35,
                            ),
                            Container(
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _normalHasBeenPressed = false;
                                    _visionHasBeenPressed = true;
                                  });
                                },
                                child: Text(
                                  "女生",
                                  style: const TextStyle(fontSize: 20),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: _visionHasBeenPressed
                                      ? primaryColor
                                      : thirdColor,
                                  elevation: 5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    _RegisterDoneBtn(),
                    _RegisterPreBtn(),
                  ]),
            )),
      ]),
    );
  }
}
