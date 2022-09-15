import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/screen/main_page.dart';
import 'package:sport_app/theme/color.dart';

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
      body: const Center(
        child: Text(
          '施工中',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: secondColor,
      centerTitle: true,
      elevation: 0,
      title: const Text('使用教學'),
      leading: Row(
        children: [
          IconButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setInt('returnMainPage', 2);
              Navigator.pushReplacementNamed(context, Main.routeName);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ],
      ),
    );
  }
}
