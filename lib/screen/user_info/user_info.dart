import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/screen/user_info/user_info_edit.dart';
import 'package:sport_app/theme/color.dart' as colors;
import 'package:sport_app/theme/color.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key}) : super(key: key);
  static const String routeName = "/userinfo";

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  var userId = '載入中';
  var birth = '19750101';
  // var _height = '載入中';
  // var _weight = '載入中';
  double _height = 170;
  double _weight = 70;
  var _gender = '載入中';
  var _ethsum = '載入中';

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  void _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString("userId") ?? "";
      _height = (prefs.getDouble("height") ?? 0);
      _weight = (prefs.getDouble("weight") ?? 0);
      _gender = prefs.getString("gender") ?? "";
      birth = prefs.getString("birthday") ?? "19750101";
      _ethsum = prefs.getString("ethsum") ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      appBar: appBar(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: FloatingActionButton(
      //   child: const Text("編輯"),
      //   backgroundColor: primaryColor,
      //   onPressed: () {
      //     Navigator.pushReplacementNamed(context, UserInfoEditPage.routeName);
      //   },
      // ),
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
                        '代幣數量',
                        style: TextStyle(
                          fontSize: 22,
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      _ethsum.toString(),
                      style: const TextStyle(
                        fontSize: 22,
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20, right: 15),
                constraints: const BoxConstraints(maxHeight: 56),
                decoration: BoxDecoration(
                  // color: Colors.white,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: primaryColor,
                    width: 5,
                  ),
                ),
              ),
              const SizedBox(height: 10),
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
                    Text(
                      DateFormat('yyyy/MM/dd').format(DateTime.parse(birth)),
                      style: const TextStyle(
                        fontSize: 22,
                        color: textColor,
                        fontWeight: FontWeight.bold,
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
                  border: Border.all(
                      color: const Color.fromARGB(255, 225, 225, 225)),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        '性別',
                        style: TextStyle(
                          fontSize: 22,
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      // (gender == 0) ? '男' : '女',
                      _gender,
                      style: const TextStyle(
                        fontSize: 22,
                        color: textColor,
                        fontWeight: FontWeight.bold,
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
                  border: Border.all(
                      color: const Color.fromARGB(255, 225, 225, 225)),
                ),
              ),
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
                    Text(
                      _height.toString(),
                      style: const TextStyle(
                        fontSize: 22,
                        color: textColor,
                        fontWeight: FontWeight.bold,
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
                  border: Border.all(
                      color: const Color.fromARGB(255, 225, 225, 225)),
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
                    Text(
                      _weight.toString(),
                      style: const TextStyle(
                        fontSize: 22,
                        color: textColor,
                        fontWeight: FontWeight.bold,
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
                  border: Border.all(
                      color: const Color.fromARGB(255, 225, 225, 225)),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'BMI',
                        style: TextStyle(
                          fontSize: 22,
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      calculateBMI(weight: _weight, height: _height),
                      style: const TextStyle(
                        fontSize: 22,
                        color: textColor,
                        fontWeight: FontWeight.bold,
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
                  border: Border.all(
                      color: const Color.fromARGB(255, 225, 225, 225)),
                ),
              ),

              // const SizedBox(height: 60),
              // mainBtn(
              //   text: '編輯',
              //   onPressed: () {
              //     Navigator.pushReplacementNamed(
              //         context, UserInfoEditPage.routeName);
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

  String calculateBMI({required double weight, required double height}) {
    double heightSquare = height * height / 10000;
    double bmi = weight / heightSquare;
    String text = "";
    if (bmi < 18.5) {
      text = "體重過輕";
    } else if (18.5 <= bmi && bmi < 24) {
      text = "健康體重";
    } else if (24 <= bmi && bmi < 27) {
      text = "體重過重";
    } else if (bmi >= 27) {
      text = "肥胖";
    }
    return bmi.toStringAsFixed(2) + " ($text)";
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: colors.secondColor,
      centerTitle: true,
      elevation: 0,
      title: const Text('個人資訊'),
      leading: Container(),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, UserInfoEditPage.routeName);
          },
          child: const Text('編輯'),
          style: ElevatedButton.styleFrom(
            primary: secondColor,
            elevation: 0,
          ),
        ),
      ],
    );
  }
}
