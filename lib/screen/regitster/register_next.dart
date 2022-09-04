import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/screen/components/app_logo.dart';
import 'package:sport_app/screen/components/button.dart';
import 'package:sport_app/screen/components/page_title.dart';
import 'package:sport_app/screen/components/textfield_inputbox.dart';
import 'package:sport_app/screen/login/login.dart';
import 'package:sport_app/screen/regitster/register.dart';
import 'package:sport_app/theme/color.dart';
import 'package:sport_app/utils/alertdialog.dart';
import 'package:sport_app/utils/http_request.dart';

class RegisterPage02 extends StatefulWidget {
  const RegisterPage02({Key? key}) : super(key: key);
  static const String routeName = "/register02";

  @override
  State<RegisterPage02> createState() => _RegisterPage02State();
}

// Widget _registerHeightTF(heightController) {
//身高
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       const Text(
//         '身高',
//         style: TextStyle(
//             color: primaryColor, fontSize: 24, fontWeight: FontWeight.bold),
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
//             prefixIcon: Icon(
//               Icons.account_box_rounded,
//               color: primaryColor,
//             ),
//             hintText: '公分',
//             hintStyle: TextStyle(
//               color: primaryColor,
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(
//                 color: primaryColor,
//                 width: 1,
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(
//                 color: primaryColor,
//                 width: 1,
//               ),
//             ),
//           ),
//           controller: heightController,

//           inputFormatters: [
//             FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
//           ],
//           keyboardType: TextInputType.number,
//         ),
//       ),
//     ],
//   );
// }

// Widget _registerWeightTF(weightController) {
//   //體重
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       const Text(
//         '體重',
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
//           style: const TextStyle(color: Colors.black),
//           decoration: const InputDecoration(
//             contentPadding: EdgeInsets.only(top: 10),
//             prefixIcon: Icon(Icons.account_box_rounded, color: primaryColor),
//             hintText: '公斤',
//             hintStyle: TextStyle(color: primaryColor),
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: primaryColor, width: 1),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: primaryColor, width: 1),
//             ),
//           ),
//           controller: weightController,
//           inputFormatters: [
//             FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
//           ],
//           keyboardType: TextInputType.number,
//         ),
//       ),
//     ],
//   );
// }

// Widget _RegisterBirTF(birthdayController, context) {
//生日
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       const Text(
//         '生日',
//         style: TextStyle(
//             color: primaryColor, fontSize: 24, fontWeight: FontWeight.bold),
//       ),
//       const SizedBox(
//         height: 10.0,
//       ),
//       Container(
//         alignment: Alignment.centerLeft,
//         height: 50,
//         child: TextField(
//           style: const TextStyle(color: Colors.black),
//           decoration: const InputDecoration(
//             contentPadding: EdgeInsets.only(top: 10),
//             prefixIcon: Icon(
//               Icons.account_box_rounded,
//               color: primaryColor,
//             ),
//             hintText: '民國年/月/日',
//             hintStyle: TextStyle(color: primaryColor),
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: primaryColor, width: 1),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: primaryColor, width: 1),
//             ),
//           ),
//           controller: birthdayController,
//           inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
//         ),
//       ),
//     ],
//   );
// }

class _RegisterPage02State extends State<RegisterPage02> {
  String dropdownValue = '男';

  late String userId, password, email;
  bool initBirth = false;
  DateTime birth = DateTime(1960, 1, 1);
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    textFieldName: '身高',
                    hintText: '請輸入身高 (公分)',
                    icon: Icons.account_box_rounded,
                    controller: heightController,
                  ),
                  const SizedBox(height: 10),
                  textField(
                    textFieldName: '體重',
                    hintText: '請輸入體重 (公斤)',
                    icon: Icons.account_box_rounded,
                    controller: weightController,
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '性別',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.account_box_rounded,
                              color: primaryColor),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: primaryColor, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: primaryColor, width: 1),
                          ),
                        ),
                        value: dropdownValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items: <String>['男', '女'].map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                  color: textColor,
                                  // fontSize: 18,
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '生日',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: _datePicker,
                        child: Container(
                          height: 50,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: primaryColor),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.account_box_rounded,
                                  color: primaryColor),
                              const SizedBox(width: 10),
                              Text(
                                (initBirth)
                                    ? DateFormat('yyyy / MM / dd').format(birth)
                                    : '請選擇出生年月日(西元)',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: (initBirth) ? Colors.black : textColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
              mainBtn(
                text: '完成 / 返回登入',
                onPressed: () async {
                  final height = heightController.text,
                      weight = weightController.text,
                      birthday = DateFormat('yyyyMMdd').format(birth);

                  bool _textFieldIsNotEmpty =
                      height.isNotEmpty && weight.isNotEmpty;
                  bool _birthIsNotEmpty = initBirth;
                  if (_textFieldIsNotEmpty && _birthIsNotEmpty) {
                    String reqeustData = """{
                            "user_id": "$userId",
                            "password": "$password",
                            "email": "$email",
                            "gender": ${(dropdownValue == '男') ? 0 : 1},
                            "role": 100,
                            "height": $height,
                            "weight": $weight,
                            "birthday": "$birthday"
                          }""";
                    await HttpRequest()
                        .post('${HttpURL.host}/api/user/signup', reqeustData)
                        .then((response) {
                      _showAlertDialog(context, response['message']);
                    });
                  } else {
                    // TODO: showAlertDialog @cheese
                    showAlertDialog(
                      context,
                      title: '',
                      message: '',
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              underScoreBtn(
                text: '上一步',
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, RegisterPage.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("userId") ?? "";
    password = prefs.getString("password") ?? "";
    email = prefs.getString("email") ?? "";
  }

  void _datePicker() async {
    initBirth = true;
    var result = await showDatePicker(
      context: context,
      initialDate: birth,
      firstDate: DateTime(1900, 01),
      lastDate: DateTime(1960, 01),
    );

    if (result != null) {
      setState(() {
        birth = result;
      });
    }
  }

  // Show AlertDialog
  void _showAlertDialog(context, message) {
    // Init
    AlertDialog dialog = AlertDialog(
      title: Text(message),
      actions: [
        ElevatedButton(
          child: const Text("確認"),
          style: ElevatedButton.styleFrom(primary: primaryColor),
          onPressed: () {
            Navigator.pushReplacementNamed(context, LoginPage.routeName);
          },
        ),
      ],
    );

    // Show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }
}
