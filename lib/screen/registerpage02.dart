import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/screen/loginpage.dart';
import 'package:sport_app/screen/registerpage.dart';
import 'package:sport_app/theme/color.dart';
import 'package:sport_app/utils/http_request.dart';

class RegisterPage02 extends StatefulWidget {
  const RegisterPage02({Key? key}) : super(key: key);
  static const String routeName = "/register02";

  @override
  State<RegisterPage02> createState() => _RegisterPage02State();
}

Widget _RegisterHeightTF(heightController) {
  //身高

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        '身高',
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
          //keyboardType: TextInputType.emailAddress,
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(
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
          controller: heightController,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
          ],
          keyboardType: TextInputType.number,
        ),
      ),
    ],
  );
}

Widget _RegisterWeightTF(weightController) {
  //體重

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        '體重',
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
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(
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
          controller: weightController,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
          ],
          keyboardType: TextInputType.number,
        ),
      ),
    ],
  );
}

Widget _RegisterBirTF(birthdayController, context) {
  //生日

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        '生日',
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
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(
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
          controller: birthdayController,
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
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

Widget _RegisterPreBtn(context) {
  return Container(
    alignment: Alignment.center,
    child: GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, RegisterPage.routeName);
      },
      child: const Text(
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
  bool _malePressed = true;
  bool _femalePressed = false;

  late String userId, password, email;

  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final birthdayController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    birthdayController.dispose();
    super.dispose();
  }

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
                    _RegisterHeightTF(heightController),
                    const SizedBox(
                      height: 10,
                    ),
                    _RegisterWeightTF(weightController),
                    const SizedBox(
                      height: 10,
                    ),
                    _RegisterBirTF(birthdayController, context),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '性別',
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _malePressed = true;
                                    _femalePressed = false;
                                  });
                                },
                                child: const Text(
                                  "男",
                                  style: TextStyle(fontSize: 20),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary:
                                      _malePressed ? primaryColor : thirdColor,
                                  elevation: 5,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 35,
                            ),
                            Container(
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _malePressed = false;
                                    _femalePressed = true;
                                  });
                                },
                                child: const Text(
                                  "女",
                                  style: TextStyle(fontSize: 20),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: _femalePressed
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
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      height: 90,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          final height = heightController.text,
                              weight = weightController.text,
                              birthday = birthdayController.text;
                          String reqeustData = """{
                            "user_id": "$userId",
                            "password": "$password",
                            "email": "$email",
                            "gender": ${_malePressed ? 0 : 1},
                            "role": "N",
                            "height": $height,
                            "weight": $weight,
                            "birthday": "$birthday"
                          }""";
                          await HttpRequest()
                              .post('${HttpURL.host}/api/user/signup',
                                  reqeustData)
                              .then((response) {
                            _showAlertDialog(context, response['message']);
                          });
                        },
                        child: const Text(
                          '完成/返回登入',
                          style: TextStyle(fontSize: 24),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                        ),
                      ),
                    ),
                    _RegisterPreBtn(context),
                  ]),
            )),
      ]),
    );
  }

  void _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("userId") ?? "";
    password = prefs.getString("password") ?? "";
    email = prefs.getString("email") ?? "";
  }

  // Show AlertDialog
  void _showAlertDialog(context, message) {
    // Init
    AlertDialog dialog = AlertDialog(
      title: Text(message),
      actions: [
        ElevatedButton(
            child: const Text("確認"),
            onPressed: () {
              Navigator.pushReplacementNamed(context, LoginPage.routeName);
            }),
      ],
    );

    // Show the dialog
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });
  }
}
