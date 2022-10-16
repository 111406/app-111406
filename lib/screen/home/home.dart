///主頁分頁

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/screen/choosing/choosing.dart';
import 'package:sport_app/screen/manual/intropage.dart';
import 'package:sport_app/theme/color.dart';
import 'package:sport_app/utils/alertdialog.dart';
import 'package:sport_app/utils/app_config.dart';
import 'package:sport_app/utils/http_request.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var todoList = <String>[];

  @override
  initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      todoList = prefs.getStringList('todoList') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: buildAppBar(),
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.63,
            child: Stack(
              children: [
                Container(
                  height: size.height * 0.57,
                  decoration: const BoxDecoration(
                    color: secondColor,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 30,
                  ),
                  height: size.height * 0.4,
                  child: target(),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    child: InkWell(
                      onTap: () async {
                        final prefs = await SharedPreferences.getInstance();
                        final trainingState = prefs.getString("trainingState");
                        switch (trainingState) {
                          case AppConfig.CANNOT_TRAINING:
                            showAlertDialog(context, message: "請先進行運動測試再回來做訓練喔！");
                            break;
                          case AppConfig.TRAINING_FINISH:
                            showCheckDialog(context, message: "您目前的訓練已完成，是否要建立新的訓練？", func: addUserTodo);
                            break;
                          case AppConfig.WAITING_TRAINING:
                            showAlertDialog(context, message: "恭喜您完成測驗，請等待至隔周即可開始任務！");
                            break;
                          default:
                            Navigator.pushReplacementNamed(context, ChoosingPage.routeName);
                        }
                      },
                      child: Ink(child: trainingBtn()),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            child: InkWell(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setInt('introScreen', 1);
                Navigator.pushReplacementNamed(context, IntroPage.routeName);
              },
              child: Ink(child: testingBtn()),
            ),
          )
        ],
      ),
    );
  }

  Container target() {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('asdsad'),
          Text('asdsad'),
          Text('asdsad'),
          Text('asdsad'),
          Text('asdsad'),
          Text('asdsad'),
          Text('asdsad'),
          Text('asdsad'),
          Text('asdsad'),
          Text('asdsad'),
          Text('asdsad'),
          Text('asdsad'),
        ],
      ),
    );
  }

  Container trainingBtn() {
    return Container(
      height: 90,
      padding: const EdgeInsets.only(left: 15, right: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(children: [
              SizedBox(
                height: 75,
                width: 75,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset('assets/icon/training.png'),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: const Text(
                  '訓練',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ]),
          ),
          Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              color: const Color(0x50292D32),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.play_arrow_rounded, size: 30, color: Colors.black),
          )
        ],
      ),
    );
  }

  Container testingBtn() {
    return Container(
      height: 90,
      padding: const EdgeInsets.only(left: 15, right: 25),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(children: [
              SizedBox(
                height: 75,
                width: 75,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset('assets/icon/testing.png'),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: const Text(
                  '開始測試',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ]),
          ),
          Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              color: const Color(0x50292D32),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.play_arrow_rounded, size: 30, color: Colors.black),
          )
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: secondColor,
      centerTitle: false,
      elevation: 0,
      title: const Text('肌動Go'),
      leading: Container(
        margin: const EdgeInsets.only(left: 10),
        child: Image.asset('assets/icon/logo_white.png'),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none),
        ),
      ],
    );
  }

  Future<void> addUserTodo() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString("userId");
    String targetDate = DateFormat('yyyyMMdd').format(DateTime.now());
    dynamic userTodo = {
      "target_date": targetDate,
      "target_times": [
        {"times": 15, "set": 2, "total": 30},
        {"times": 8, "set": 1, "total": 8},
        {"times": 15, "set": 2, "total": 30}
      ],
      "complete": false
    };
    try {
      await HttpRequest.post('${HttpURL.host}/target/add/todo/$userId', jsonEncode(userTodo));
      Navigator.pushReplacementNamed(context, ChoosingPage.routeName);
    } catch (e) {
      Navigator.pop(context);
      final errorMessage = e.toString().split(" ")[1];
      showAlertDialog(context, message: errorMessage);
    }
  }
}
