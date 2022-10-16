///訓練選擇頁
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/enum/training_part.dart';
import 'package:sport_app/model/user_todo.dart';
import 'package:sport_app/screen/choosing/choosinghand.dart';
import 'package:sport_app/screen/main_page.dart';
import 'package:sport_app/screen/manual/training_intropage.dart';
import 'package:sport_app/theme/color.dart';
import 'package:sport_app/utils/alertdialog.dart';
import '../main_page.dart';
import '../manual/intropage.dart';

class ChoosingPage extends StatefulWidget {
  const ChoosingPage({Key? key}) : super(key: key);
  static const String routeName = "/choosing";

  @override
  State<ChoosingPage> createState() => _ChoosingPageState();
}

class _ChoosingPageState extends State<ChoosingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: buildAppBar(),
      body: Column(
        children: [
          const SizedBox(height: 70),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.symmetric(horizontal: 35),
            child: const Text(
              '選擇訓練部位',
              style: TextStyle(
                fontSize: 28,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 35),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.symmetric(horizontal: 35),
            child: const Text(
              '上半身肌肉(上肢部分)',
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            child: InkWell(
              onTap: () {
                goNextPage(TrainingPart.biceps.value);
              },
              child: Ink(child: bicepsBtn()),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            child: InkWell(
              onTap: () {
                goNextPage(TrainingPart.deltoid.value);
              },
              child: Ink(child: deltaBtn()),
            ),
          ),
          const SizedBox(height: 35),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.symmetric(horizontal: 35),
            child: const Text(
              '下半身肌肉(下肢部分)',
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            child: InkWell(
              onTap: () {
                goNextPage(TrainingPart.quadriceps.value);
              },
              child: Ink(child: squatBtn()),
            ),
          ),
        ],
      ),
    );
  }

  Container bicepsBtn() {
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
                  child: Image.asset('assets/schematic/biceps.png'),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: const Text(
                  '二頭肌彎舉',
                  style: TextStyle(
                    fontSize: 22,
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

  Container deltaBtn() {
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
                  child: Image.asset('assets/schematic/triceps.png'),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: const Text(
                  '三角肌平舉',
                  style: TextStyle(
                    fontSize: 22,
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

  Container squatBtn() {
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
                  child: Image.asset('assets/schematic/squat.png'),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: const Text(
                  '滑牆深蹲運動',
                  style: TextStyle(
                    fontSize: 22,
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
      centerTitle: true,
      elevation: 0,
      title: const Text('開始訓練'),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.pushReplacementNamed(context, Main.routeName);
        },
      ),
    );
  }

  void goNextPage(int part) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("trainingPart", part);

    final userTodoString = prefs.getString("userTodo")!;
    final userTodo = UserTodo.fromJson(jsonDecode(userTodoString));
    final totalTimes = userTodo.targetTimes[part]['total'];
    if (part != TrainingPart.quadriceps.value) {
      if (userTodo.actualTimes[part]['left']['times'] >= totalTimes && userTodo.actualTimes[part]['right']['times'] >= totalTimes) {
        final trainpart = TrainingPart.parse(part);
        showAlertDialog(context, message: "${trainpart.string}訓練已完成！");
      } else {
        Navigator.pushReplacementNamed(context, ChoosingHandPage.routeName);
      }
    } else {
      if (userTodo.actualTimes[part]['times'] >= totalTimes) {
        showAlertDialog(context, message: "滑牆深蹲訓練已完成！");
      } else {
        prefs.setInt("times", userTodo.targetTimes[part]['times']);
        prefs.setInt("set", userTodo.targetTimes[part]['set']);
        prefs.setInt("total", totalTimes);
        await prefs.setInt('introScreen', 4);
        Navigator.pushReplacementNamed(context, IntroPage.routeName);
      }
    }
  }
}
