/// 使用者資訊編輯

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/screen/components/button.dart';
import 'package:sport_app/theme/color.dart';
import 'package:sport_app/utils/alertdialog.dart';
import 'package:sport_app/utils/http_request.dart';
import '../main_page.dart';

class UserInfoEditPage extends StatefulWidget {
  const UserInfoEditPage({Key? key}) : super(key: key);
  static const String routeName = "/userinfo/edit";

  @override
  State<UserInfoEditPage> createState() => _UserInfoEditPageState();
}

class _UserInfoEditPageState extends State<UserInfoEditPage> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  late Timer _timer;

  var userId = '載入中';
  var birth = DateTime(1975, 1, 1);
  var height = '載入中';
  var weight = '載入中';
// var gender = '載入中';

  @override
  void initState() {
    _loadPrefs();
    super.initState();
  }

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  void _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString("userId") ?? "";
      height = (prefs.getDouble("height") ?? 0).toString();
      weight = (prefs.getDouble("weight") ?? 0).toString();
      // gender = prefs.getString("gender") ?? "";
      var _b = prefs.getString("birthday") ?? "";
      birth = DateTime.parse(_b);
    });
  }

  heightChange(BuildContext context) {
    // Init
    AlertDialog dialog = AlertDialog(
      title: const Text("輸入新身高"),
      content: TextField(
        controller: heightController,
        keyboardType: TextInputType.number,
        maxLines: 1,
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9.]"))],
      ),
      actions: [
        ElevatedButton(
          child: const Text("確認"),
          style: ElevatedButton.styleFrom(primary: primaryColor),
          onPressed: () {
            setState(() {
              final _height = heightController.text;
              if (_height.isEmpty) {
                showAlertDialog(context, message: "請輸入身高");
                return;
              }

              double heightNumber = double.parse(_height);
              if (heightNumber < 130 || heightNumber > 200) {
                showAlertDialog(context, message: "請輸入身高正常範圍(130 ~ 200)");
                return;
              }
              height = _height;
              Navigator.pop(context);
            });
          },
        ),
        ElevatedButton(
          child: const Text("取消"),
          style: ElevatedButton.styleFrom(primary: primaryColor),
          onPressed: () {
            Navigator.pop(context);
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

  weightChange(BuildContext context) {
    // Init

    AlertDialog dialog = AlertDialog(
      title: const Text("輸入新體重"),
      content: TextField(
        controller: weightController,
        keyboardType: TextInputType.number,
        maxLines: 1,
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9.]"))],
      ),
      actions: [
        ElevatedButton(
          child: const Text("確認"),
          style: ElevatedButton.styleFrom(primary: primaryColor),
          onPressed: () {
            setState(() {
              final _weight = weightController.text;
              if (_weight.isEmpty) {
                showAlertDialog(context, message: "請輸入體重");
                return;
              }

              double weightNumber = double.parse(_weight);
              if (weightNumber < 30 || weightNumber > 150) {
                showAlertDialog(context, message: "請輸入體重正常範圍(30 ~ 150)");
                return;
              }
              weight = _weight;
              Navigator.pop(context);
            });
          },
        ),
        ElevatedButton(
          child: const Text("取消"),
          style: ElevatedButton.styleFrom(primary: primaryColor),
          onPressed: () {
            Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Container(
                alignment: Alignment.center,
                child: const Icon(
                  Icons.account_circle_rounded,
                  color: Color(0xffB5C0BF),
                  size: 100,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                userId,
                style: const TextStyle(
                  fontSize: 30,
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Container(
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        '出生年月日',
                        style: TextStyle(
                          fontSize: 22,
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: _datePicker,
                      child: Container(
                        child: Text(
                          DateFormat('yyyy/MM/dd').format(birth),
                          style: const TextStyle(
                            fontSize: 22,
                            color: editTextColor,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        alignment: Alignment.center,
                      ),
                    ),
                  ],
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20, right: 15),
                constraints: const BoxConstraints(maxHeight: 56),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: const Color.fromARGB(255, 225, 225, 225)),
                ),
              ),
              // const SizedBox(height: 10),
              // Container(
              //   child: Row(
              //     children: [
              //       const Expanded(
              //         child: Text(
              //           '性別',
              //           style: TextStyle(
              //             fontSize: 22,
              //             color: textColor,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //       ),
              //       TextButton(
              //         child: const Text('男'),
              //         onPressed: () {},
              //       ),
              //       TextButton(
              //         child: const Text('女'),
              //         onPressed: () {},
              //       )
              //     ],
              //   ),
              //   alignment: Alignment.centerLeft,
              //   padding: const EdgeInsets.only(left: 20, right: 15),
              //   margin: const EdgeInsets.only(left: 20, right: 20),
              //   constraints: const BoxConstraints(maxHeight: 56),
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(5),
              //     border: Border.all(
              //         color: const Color.fromARGB(255, 225, 225, 225)),
              //   ),
              // ),
              const SizedBox(height: 10),
              Container(
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        '身高(公分)',
                        style: TextStyle(
                          fontSize: 22,
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        heightChange(context);
                      },
                      child: Text(
                        height.toString(),
                        style: const TextStyle(
                          fontSize: 22,
                          color: editTextColor,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20, right: 15),
                constraints: const BoxConstraints(maxHeight: 56),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: const Color.fromARGB(255, 225, 225, 225)),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        '體重(公斤)',
                        style: TextStyle(
                          fontSize: 22,
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        weightChange(context);
                      },
                      child: Text(
                        weight.toString(),
                        style: const TextStyle(
                          fontSize: 22,
                          color: editTextColor,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20, right: 15),
                constraints: const BoxConstraints(maxHeight: 56),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: const Color.fromARGB(255, 225, 225, 225)),
                ),
              ),
              const SizedBox(height: 60),
              mainBtn(
                text: "完成",
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  String birthday = DateFormat('yyyyMMdd').format(birth);

                  String requestData = """{
                    "birthday": "$birthday",
                    "height": $height,
                    "weight": $weight
                  }""";

                  try {
                    _loadingCircle();
                    await HttpRequest.post('${HttpURL.host}/user/update/$userId', requestData).then(
                      (response) async {
                        prefs.setDouble("height", double.parse(height));
                        prefs.setDouble("weight", double.parse(weight));
                        prefs.setString("birthday", birthday);
                      },
                    );
                    await prefs.setInt('returnMainPage', 1);
                    showAlertDialog(context, message: '修改成功').then((_) => Navigator.pushReplacementNamed(context, Main.routeName));
                  } on Exception catch (e) {
                    showAlertDialog(
                      context,
                      title: '修改失敗',
                      message: e.toString().split(" ")[1],
                    );
                  }
                  _timer.cancel();
                  EasyLoading.dismiss();
                },
              ),
              const SizedBox(height: 10),
              mainBtn(
                text: '取消',
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setInt('returnMainPage', 1);
                  Navigator.pushReplacementNamed(context, Main.routeName);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: secondColor,
      centerTitle: true,
      elevation: 0,
      title: const Text('編輯 個人資訊'),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setInt('returnMainPage', 1);
          Navigator.pushReplacementNamed(context, Main.routeName);
        },
      ),
    );
  }

  void _datePicker() async {
    var result = await showDatePicker(
      locale: const Locale('zh', 'TW'),
      context: context,
      initialDate: birth,
      firstDate: DateTime(1900, 01),
      lastDate: DateTime(1975, 01),
    );

    if (result != null) {
      setState(() {
        birth = result;
      });
    }
  }

  Future<void> _loadingCircle() async {
    double _progress = 0;
    EasyLoading.instance
      ..backgroundColor = primaryColor
      ..textColor = Colors.white
      ..progressColor = Colors.white
      ..maskColor = Colors.white70
      ..displayDuration = const Duration(milliseconds: 10000)
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorType = EasyLoadingIndicatorType.wave
      ..maskType = EasyLoadingMaskType.custom
      ..userInteractions = false;

    // _timer.cancel();
    _timer = Timer.periodic(
      const Duration(milliseconds: 150),
      (Timer timer) async {
        EasyLoading.showProgress(_progress, status: '載入中...');
        _progress += 0.05;

        if (_progress >= 1) {
          _timer.cancel();
          EasyLoading.dismiss();
        }
      },
    );
    //讀取結束
  }
}
