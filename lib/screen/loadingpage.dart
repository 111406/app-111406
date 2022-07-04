import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sport_app/screen/mainpage.dart';
import 'package:sport_app/screen/testresultpage.dart';
import 'package:sport_app/theme/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingPage extends StatefulWidget {
  static const String routeName = "/loading";

  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  Timer? timer;
  int currentTimer = 0;
  bool isLogin = false;
  bool isTest = false;

  @override
  void initState() {
    super.initState();
    _asyncMethod();
  }

  _asyncMethod() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? loginloadingpage = prefs.getBool('loginloadingpage');
    bool? testloadingpage = prefs.getBool('testloadingpage');
    timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      currentTimer += 100;
      if (currentTimer >= 3000) {
        timer.cancel();
        if (loginloadingpage == true) {
          Navigator.pushNamed(context, MainPage.routeName);
          prefs.setBool('loginloadingpage', false);
          setState(() {
            loginloadingpage = false;
          });
        }
        // if (testloadingpage == true) {
        //   Navigator.pushNamed(context, TestResultPage.routeName);
        //   prefs.setBool('testloadingpage', false);
        //   setState(() {
        //     testloadingpage = false;
        //   });
        // }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation(primaryColor),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '讀取中',
              style: TextStyle(
                  color: secondColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
