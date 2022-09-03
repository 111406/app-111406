import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/screen/login/login.dart';
import 'package:sport_app/theme/color.dart';

class OtherPage extends StatefulWidget {
  const OtherPage({Key? key}) : super(key: key);
  static const String routeName = "/register";

  @override
  State<OtherPage> createState() => _OtherPageState();
}

class _OtherPageState extends State<OtherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBar(),
      body: Column(
        children: [
          const SizedBox(height: 46),
          Container(
            child: const Text('使用相關', style: TextStyle(fontSize: 20)),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 26),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {},
            child: Ink(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
              ),
              child: Container(
                child: const Text('使用教學', style: TextStyle(fontSize: 20)),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 50),
              ),
            ),
          ),
          const SizedBox(height: 5),
          InkWell(
            onTap: () {},
            child: Ink(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
              ),
              child: Container(
                child: const Text('使用須知', style: TextStyle(fontSize: 20)),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 50),
              ),
            ),
          ),
          const SizedBox(height: 34),
          Container(
            child: const Text('帳戶相關', style: TextStyle(fontSize: 20)),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 26),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {},
            child: Ink(
              height: 48,
              // color: Colors.white,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
              ),
              child: Container(
                child: const Text('修改密碼', style: TextStyle(fontSize: 20)),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 50),
              ),
            ),
          ),
          const SizedBox(height: 248),
          InkWell(
            onTap: () async {
              Navigator.pushReplacementNamed(context, LoginPage.routeName);
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString("userId", '');
              prefs.setString("token", '');
              prefs.clear();
            },
            child: Ink(
              height: 48,
              // color: Colors.white,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
              ),
              child: Container(
                child: const Text('登出', style: TextStyle(fontSize: 20)),
                alignment: Alignment.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: secondColor,
      centerTitle: true,
      elevation: 0,
      title: const Text('其他'),
    );
  }
}
