import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/enum/training_hand.dart';
import 'package:sport_app/model/user_todo.dart';
import 'package:sport_app/screen/main_page.dart';
import 'package:sport_app/screen/manual/training_intropage.dart';
import 'package:sport_app/theme/color.dart';
import 'package:sport_app/utils/alertdialog.dart';
import '../main_page.dart';
import '../manual/intropage.dart';

class ChoosingHandPage extends StatefulWidget {
  const ChoosingHandPage({Key? key}) : super(key: key);
  static const String routeName = "/choosing_hand";

  @override
  State<ChoosingHandPage> createState() => _ChoosingHandPageState();
}

class _ChoosingHandPageState extends State<ChoosingHandPage> {
  late UserTodo userTodo;

  @override
  void initState() {
    super.initState();
    _loadState();
  }

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
            margin: const EdgeInsets.symmetric(horizontal: 25),
            child: InkWell(
              onTap: () {
                goNextPage("left");
              },
              child: Ink(child: leftHandBtn()),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            child: InkWell(
              onTap: () {
                goNextPage("right");
              },
              child: Ink(child: rightHandBtn()),
            ),
          ),
        ],
      ),
    );
  }

  Container leftHandBtn() {
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
                  '左手',
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
            child: const Icon(Icons.play_arrow_rounded,
                size: 30, color: Colors.black),
          )
        ],
      ),
    );
  }

  Container rightHandBtn() {
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
                  '右手',
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
            child: const Icon(Icons.play_arrow_rounded,
                size: 30, color: Colors.black),
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
          Navigator.pushNamed(context, Main.routeName);
        },
      ),
    );
  }

  void goNextPage(String trainingHand) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final userTodoString = prefs.getString("userTodo")!;
    final part = prefs.getInt("trainingPart")!;
    final userTodo = UserTodo.fromJson(jsonDecode(userTodoString));
    final totalTimes = userTodo.targetTimes[part]['total'];
    final hand = TrainingHand.parse(trainingHand);
    if (userTodo.actualTimes[part][trainingHand]['times'] >= totalTimes) {
      showAlertDialog(context, message: "${hand.string}訓練已完成！");
    } else {
      prefs.setString("trainingHand", trainingHand);
      prefs.setInt("times", userTodo.targetTimes[part]['times']);
      prefs.setInt("set", userTodo.targetTimes[part]['set']);
      prefs.setInt("total", totalTimes);
      await prefs.setInt('introScreen', 2);
      Navigator.pushReplacementNamed(context, IntroPage.routeName);
    }
  }

  Future<void> _loadState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final todoString = prefs.getStringList("todoList")![0];
    setState(() {
      userTodo = UserTodo.fromJson(jsonDecode(todoString));
    });
  }
}
