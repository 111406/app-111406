///註冊第一頁

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/enum/gender.dart';
import 'package:sport_app/screen/components/app_logo.dart';
import 'package:sport_app/screen/components/button.dart';
import 'package:sport_app/screen/components/page_title.dart';
import 'package:sport_app/screen/components/textfield_inputbox.dart';
import 'package:sport_app/screen/login/login.dart';
import 'package:sport_app/theme/color.dart';
import 'package:sport_app/utils/alertdialog.dart';
import 'package:sport_app/utils/http_request.dart';

import 'register_component.dart';

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

  int genderValue = 0;
  late String userId, password, email, walletAddress, privateKey;
  late int sum;
  bool initBirth = false;
  DateTime birth = DateTime(1960, 1, 1);
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final referenceController = TextEditingController();

  bool? hypertension, hyperglycemia, hyperlipidemia;

  @override
  void initState() {
    _loadState();
    super.initState();
  }

  @override
  void dispose() {
    userIdController.dispose();
    passwordController.dispose();
    cpasswordController.dispose();
    emailController.dispose();

    heightController.dispose();
    weightController.dispose();
    referenceController.dispose();
    super.dispose();
  }

  String? gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scrollbar(
          isAlwaysShown: true,
          child: SingleChildScrollView(
            // physics: const NeverScrollableScrollPhysics(),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
              child: Column(
                children: [
                  appLogo(),
                  pageTitle('註冊'),
                  const SizedBox(height: 5),
                  // 帳號相關
                  Column(
                    children: [
                      textField(
                        textFieldName: '帳號',
                        hintText: '請輸入帳號',
                        icon: Icons.account_box_rounded,
                        controller: userIdController,
                        keyboardType: TextInputType.name,
                        formatter: [
                          FilteringTextInputFormatter.allow(
                              RegExp("[a-zA-Z0-9]"))
                        ],
                      ),
                      const SizedBox(height: 10),
                      textField(
                        textFieldName: '密碼',
                        hintText: '請輸入密碼',
                        obscureText: true,
                        icon: Icons.lock,
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      const SizedBox(height: 10),
                      textField(
                        textFieldName: '確認密碼',
                        hintText: '確認密碼',
                        obscureText: true,
                        icon: Icons.lock,
                        controller: cpasswordController,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      const SizedBox(height: 10),
                      textField(
                        textFieldName: '信箱',
                        hintText: '請輸入信箱',
                        icon: Icons.email,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // 個人資訊
                  Column(
                    children: [
                      // 性別
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
                            value: genderValue,
                            onChanged: (int? newValue) {
                              genderValue = newValue!;
                            },
                            items: [Gender.male, Gender.female]
                                .map<DropdownMenuItem<int>>(
                              (Gender gender) {
                                return DropdownMenuItem<int>(
                                  value: gender.value,
                                  child: Text(
                                    gender.string,
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
                      // 生日
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
                                        ? DateFormat('yyyy / MM / dd')
                                            .format(birth)
                                        : '請選擇出生年月日(西元)',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: (initBirth)
                                          ? Colors.black
                                          : textColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      textField(
                        textFieldName: '身高',
                        hintText: '請輸入身高 (公分)',
                        icon: Icons.account_box_rounded,
                        controller: heightController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        formatter: [
                          FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
                        ],
                      ),
                      const SizedBox(height: 10),
                      textField(
                        textFieldName: '體重',
                        hintText: '請輸入體重 (公斤)',
                        icon: Icons.account_box_rounded,
                        controller: weightController,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        formatter: [
                          FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // 三高
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '是否有三高',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                          border: Border.all(color: primaryColor),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    '高血壓',
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: RadioListTile(
                                    activeColor: secondColor,
                                    title: const Text(
                                      "無",
                                      style: TextStyle(
                                        color: secondColor,
                                        fontSize: 20,
                                      ),
                                    ),
                                    value: false,
                                    groupValue: hypertension,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        hypertension = value;
                                      });
                                    },
                                  ),
                                ),
                                Flexible(
                                  child: RadioListTile(
                                    activeColor: secondColor,
                                    title: const Text(
                                      "有",
                                      style: TextStyle(
                                        color: secondColor,
                                        fontSize: 20,
                                      ),
                                    ),
                                    value: true,
                                    groupValue: hypertension,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        hypertension = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    '高血糖',
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: RadioListTile(
                                    activeColor: secondColor,
                                    title: const Text(
                                      "無",
                                      style: TextStyle(
                                        color: secondColor,
                                        fontSize: 20,
                                      ),
                                    ),
                                    value: false,
                                    groupValue: hyperglycemia,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        hyperglycemia = value;
                                      });
                                    },
                                  ),
                                ),
                                Flexible(
                                  child: RadioListTile(
                                    activeColor: secondColor,
                                    title: const Text(
                                      "有",
                                      style: TextStyle(
                                        color: secondColor,
                                        fontSize: 20,
                                      ),
                                    ),
                                    value: true,
                                    groupValue: hyperglycemia,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        hyperglycemia = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Expanded(
                                  child: Text(
                                    '高血脂',
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: RadioListTile(
                                    activeColor: secondColor,
                                    title: const Text(
                                      "無",
                                      style: TextStyle(
                                        color: secondColor,
                                        fontSize: 20,
                                      ),
                                    ),
                                    value: false,
                                    groupValue: hyperlipidemia,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        hyperlipidemia = value;
                                      });
                                    },
                                  ),
                                ),
                                Flexible(
                                  child: RadioListTile(
                                    activeColor: secondColor,
                                    title: const Text(
                                      "有",
                                      style: TextStyle(
                                        color: secondColor,
                                        fontSize: 20,
                                      ),
                                    ),
                                    value: true,
                                    groupValue: hyperlipidemia,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        hyperlipidemia = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  textField(
                    textFieldName: '推薦人',
                    hintText: '請輸入推薦人 (選填)',
                    icon: Icons.account_box_rounded,
                    controller: referenceController,
                  ),
                  const SizedBox(height: 40),
                  mainBtn(
                    text: '完成 / 返回登入',
                    onPressed: _onPressed,
                  ),
                  const SizedBox(height: 50),
                  // mainBtn(
                  //   // 下一步按鈕
                  //   onPressed: () async {
                  //     String userId = userIdController.text;
                  //     String password = passwordController.text;
                  //     String confirmPassword = cpasswordController.text;
                  //     String email = emailController.text;

                  //     bool _textFieldIsNotEmpty = userId.isNotEmpty &&
                  //         password.isNotEmpty &&
                  //         confirmPassword.isNotEmpty &&
                  //         email.isNotEmpty;
                  //     bool _passwordCheck = (password == confirmPassword);

                  //     if (_textFieldIsNotEmpty && _passwordCheck) {
                  //       SharedPreferences prefs =
                  //           await SharedPreferences.getInstance();
                  //       prefs.setString("userId", userId);
                  //       prefs.setString("password", password);
                  //       prefs.setString("email", email);
                  //       Navigator.pushNamed(context, RegisterPage02.routeName);
                  //     } else if (!_passwordCheck) {
                  //       showAlertDialog(
                  //         context,
                  //         title: '密碼與確認密碼不相同',
                  //         message: '請重新輸入',
                  //       );
                  //     } else {
                  //       showAlertDialog(
                  //         context,
                  //         title: '輸入框不得為空白',
                  //         message: '請重新輸入',
                  //       );
                  //     }
                  //   },
                  // ),
                  // const SizedBox(height: 20),
                  backToLoginButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userIdController.text = prefs.getString("userId") ?? "";
      emailController.text = prefs.getString("email") ?? "";
    });
  }

  void _onPressed() async {
    final userId = userIdController.text,
        password = passwordController.text,
        confirmPassword = cpasswordController.text,
        email = emailController.text,
        height = heightController.text,
        weight = weightController.text,
        birthday = DateFormat('yyyyMMdd').format(birth),
        reference = referenceController.text;

    bool _textFieldIsNotEmpty = userId.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        email.isNotEmpty &&
        height.isNotEmpty &&
        weight.isNotEmpty;

    bool _threeHighIsNotNull = (hypertension != null) &&
        (hypertension != null) &&
        (hypertension != null);

    bool _birthIsNotEmpty = initBirth;
    bool _passwordCheck = (password == confirmPassword);

    // if (!_textFieldIsNotEmpty || !_birthIsNotEmpty || !_threeHighIsNotNull) {
    //   showAlertDialog(
    //     context,
    //     title: '輸入框不得為空白',
    //     message: '請重新輸入',
    //   );
    // }

    if (!_passwordCheck) {
      showAlertDialog(
        context,
        title: '密碼與確認密碼不相同',
        message: '請重新輸入',
      );
    }

    // TODO ETH帳號
    // add account
    Object accountrawData = {};

    await HttpRequest.post(
            "${HttpURL.ethHost}/addAccount", jsonEncode(accountrawData))
        .then((response) {
      walletAddress = response['walletAddress'];
      privateKey = response['privateKey'];
      sum = int.parse(response['sum']);
    });

    if (_textFieldIsNotEmpty && _birthIsNotEmpty && _threeHighIsNotNull) {
      Map requestData = {
        "user_id": userId,
        "password": password,
        "email": email,
        "gender": genderValue,
        "role": 100,
        "height": height,
        "weight": weight,
        "birthday": birthday,
        "eth_account": walletAddress,
        "eth_password": privateKey,
        "eth_sum": sum
      };
      // "hypertension": hypertension,
      // "hyperglycemia": hyperglycemia,
      // "hyperlipidemia": hyperlipidemia,

      if (reference.isNotEmpty) requestData['reference'] = reference;

      final response = await HttpRequest.post(
          '${HttpURL.host}/user/signup', jsonEncode(requestData));

      showAlertDialog(context, message: response['message']).then((_) =>
          Navigator.pushNamedAndRemoveUntil(
              context, LoginPage.routeName, (route) => false));
    } else {
      showAlertDialog(
        context,
        title: '輸入框不得為空白',
        message: '請重新輸入',
      );
    }
  }
}
