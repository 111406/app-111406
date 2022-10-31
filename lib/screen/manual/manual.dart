///使用須知
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/screen/main_page.dart';
import 'package:sport_app/screen/manual/policy.dart';
import 'package:sport_app/theme/color.dart';

import '../login/login.dart';

class Manual extends StatefulWidget {
  const Manual({Key? key}) : super(key: key);
  static const String routeName = "/manual";

  @override
  State<Manual> createState() => _ManualState();
}

class _ManualState extends State<Manual> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 40),
            child: const Text(privateText),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    int? manualCon;
    return AppBar(
      backgroundColor: secondColor,
      centerTitle: true,
      elevation: 0,
      title: const Text('使用須知'),
      leading: Row(
        children: [
          IconButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              try {
                setState(() {
                  if (prefs.getInt('manualControll') == 1) {
                    Navigator.pushReplacementNamed(
                        context, LoginPage.routeName);
                    prefs.setInt('manualControll', 0);
                  } else {
                    prefs.setInt('returnMainPage', 2);
                    Navigator.pushReplacementNamed(context, Main.routeName);
                  }
                });
              } catch (e) {}
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ],
      ),
    );
  }
}
