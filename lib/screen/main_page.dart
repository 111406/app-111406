import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/model/user_todo.dart';
import 'package:sport_app/screen/home/home.dart';
import 'package:sport_app/screen/other/other_page.dart';
import 'package:sport_app/screen/user_info/user_info.dart';
import 'package:sport_app/theme/color.dart';
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

  void _loadStates() async {
    // final prefs = await SharedPreferences.getInstance();
    // // var userId = '';
    // userId = prefs.getString("userId") ?? "";
    // var height = 0.0;
    // var weight = 0.0;
    // var birth = '';
    // var gender = '';
    // HttpRequest().get('${HttpURL.host}/api/user/$userId').then((response) {
    //   height = response['data']['height'];
    //   weight = response['data']['weight'];
    //   birth = response['data']['birth'];
    //   gender = response['data']['gender'];

    //   prefs.setDouble("height", height);
    //   prefs.setDouble("weight", weight);
    //   prefs.setString("birth", birth);
    //   prefs.setString("gender", gender);
    // });
    final prefs = await SharedPreferences.getInstance();
    final todoList = <String>[];
    final userId = prefs.getString("userId");
    await HttpRequest().get('${HttpURL.host}/api/target/$userId').then((response) {
      final dataList = response['data'];
      if (dataList != false) {
        for (var data in response['data']) {
          var todo = UserTodo.fromJson(data);
          todoList.add(json.encode(todo));
        }
        prefs.setStringList("todoList", todoList);
        prefs.setBool(AppConfig.CHECK_TRAINING, true);
      } else {
        prefs.setBool(AppConfig.CHECK_TRAINING, false);
      }
    });
  }

  _asyncMethod() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? returnMainPage = 0;
    returnMainPage = prefs.getInt('returnMainPage');
    if (returnMainPage == 1) {
      setState(() {
        _currentIndex = returnMainPage!;
        returnMainPage = 0;
      });
    }
    prefs.remove('returnMainPage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: bottomNavigatorBar(),
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
