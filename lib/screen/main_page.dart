///主頁面

import 'dart:convert';
import 'dart:io';
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

  bool checkComplete = true;
  List checkCompleteList = [];
  void _loadStates() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("trainingState");
    final todoList = <UserTodo>[];
    final todoMap = {};
    final userId = prefs.getString("userId");
    await HttpRequest.get('${HttpURL.host}/target/$userId')
        .then((response) async {
      final dataList = response['data'] as List;
      if (dataList.isNotEmpty) {
        // 有本周訓練資料
        for (var data in response['data']) {
          var todo = UserTodo.fromJson(data);
          checkCompleteList.add(todo.complete);

          todoMap[todo.targetDate] = todo;
          todoList.add(todo);
        }
        checkComplete = checkCompleteList.contains(false);

        await prefs.setString("todoMap", json.encode(todoMap));

        // TODO 訓練表部分待調整
        if (checkComplete) {
          prefs.setString("userTodo",
              json.encode(todoList.firstWhere((element) => !element.complete)));
        }
      } else {
        // 檢查是不是剛做完檢測，因為不會馬上指派任務
        await HttpRequest.get('${HttpURL.host}/target/started/$userId')
            .then((response) {
          final isHadTarget = response['data'];
          prefs.remove("todoList");
          prefs.remove("userTodo");
          if (isHadTarget) {
            // 如果是剛檢測完會跑到這
            prefs.setString("trainingState", AppConfig.WAITING_TRAINING);
          } else {
            // 代表還沒做檢測
            prefs.setString("trainingState", AppConfig.CANNOT_TRAINING);
          }
        });
      }
    });
    if (!checkComplete) {
      // 進到這裡表示本周任務已完成
      prefs.setString("trainingState", AppConfig.TRAINING_FINISH);
    }

    // TODO check
    await HttpRequest.get('${HttpURL.host}/user/$userId').then((response) {
      var height = response['data']['height'] ?? .0;
      var weight = response['data']['weight'] ?? .0;
      var birth = response['data']['birthday'];
      var gender = response['data']['gender'];
      var ethsum = response['data']['eth_sum'];

      prefs.setDouble("height", height);
      prefs.setDouble("weight", weight);
      prefs.setString("birthday", birth);
      prefs.setString("gender", gender);
      prefs.setString("ethsum", ethsum.toString());
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
