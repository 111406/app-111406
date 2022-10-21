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
  bool _isLoginForFirstTime = false;
  final pages = [const HomePage(), const UserInfoPage(), const OtherPage()];

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _asyncMethod();
    _getIsLoginForFirstTime();
  }

  _asyncMethod() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int returnMainPage = prefs.getInt('returnMainPage') ?? 0;
    setState(() {
      _currentIndex = returnMainPage;
    });
    prefs.remove('returnMainPage');
  }

  _getIsLoginForFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoginForFirstTime = prefs.getBool('isLoginForFirstTime') ?? false;
    setState(() {
      _isLoginForFirstTime = isLoginForFirstTime;
    });
  }

  _setIsLoginForFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoginForFirstTime', false);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: 登入必轉教學頁面 需調整 @cheese
    if (_isLoginForFirstTime) {
      _setIsLoginForFirstTime();
      // return const IntroPage();
    }
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
