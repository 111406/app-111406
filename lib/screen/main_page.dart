///主頁面

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/model/user_todo.dart';
import 'package:sport_app/screen/home/home.dart';
import 'package:sport_app/screen/other/other_page.dart';
import 'package:sport_app/screen/user_info/user_info.dart';
import 'package:sport_app/theme/color.dart';
import 'package:sport_app/utils/alertdialog.dart';
import 'package:sport_app/utils/app_config.dart';
import 'package:sport_app/utils/http_request.dart';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);
  static const String routeName = "/main";

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int _currentIndex = 0;
  final pages = [const HomePage(), const UserInfoPage(), const OtherPage()];

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _asyncMethod();
    _loadStates();
  }

  bool checkComplete = false;
  List checkCompleteList = [];
  void _loadStates() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("trainingPart");
    final todoStringList = <String>[];
    final todoList = <UserTodo>[];
    final userId = prefs.getString("userId");
    await HttpRequest().get('${HttpURL.host}/target/$userId').then((response) {
      final dataList = (response['data'] ?? []) as List;
      if (dataList.isNotEmpty) {
        for (var data in response['data']) {
          var todo = UserTodo.fromJson(data);
          checkCompleteList.add(todo.complete);
          todoStringList.add(json.encode(todo));
          todoList.add(todo);
        }
        checkComplete = checkCompleteList.contains(false);
        prefs.setStringList("todoList", todoStringList);
        // TODO 訓練表部分待調整
        if (checkComplete) {
          prefs.setString("userTodo", json.encode(todoList.firstWhere((element) => !element.complete)));
        }
        prefs.setBool(AppConfig.CHECK_TRAINING, true);
      } else {
        prefs.remove("todoList");
        prefs.remove("userTodo");
        checkComplete = true;
        prefs.setBool(AppConfig.CHECK_TRAINING, false);
      }
    });
    if (checkComplete) {
      prefs.setBool(AppConfig.TRAINING_FINISH, false);
    } else {
      prefs.setBool(AppConfig.TRAINING_FINISH, true);
    }

    await HttpRequest().get('${HttpURL.host}/user/$userId').then((response) {
      var height = response['data']['height'];
      var weight = response['data']['weight'];
      var birth = response['data']['birthday'];
      var gender = response['data']['gender'];

      prefs.setDouble("height", height);
      prefs.setDouble("weight", weight);
      prefs.setString("birth", birth);
      prefs.setString("gender", gender);
    });
  }

  _asyncMethod() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int returnMainPage = prefs.getInt('returnMainPage') ?? 0;
    setState(() {
      _currentIndex = returnMainPage;
    });
    prefs.remove('returnMainPage');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: pages[_currentIndex],
        bottomNavigationBar: bottomNavigatorBar(),
      ),
      onWillPop: () async {
        showCheckDialog(context, message: "是否離開肌動Go", func: () => exit(0));
        return false;
      },
    );
  }

  BottomNavigationBar bottomNavigatorBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: '首頁',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined),
          label: '個人資訊',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz_rounded),
          label: '其他',
        ),
      ],
      currentIndex: _currentIndex,
      fixedColor: primaryColor,
      onTap: _onItemClick,
    );
  }

  void _onItemClick(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
