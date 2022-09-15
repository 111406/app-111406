import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sport_app/screen/main_page.dart';
import 'package:sport_app/screen/training/trainingpage.dart';
import 'package:sport_app/theme/color.dart';

var _displayTimer = 60;
var _ss = 0;

class RestPage extends StatefulWidget {
  const RestPage({Key? key}) : super(key: key);
  static const String routeName = "/rest";

  @override
  State<RestPage> createState() => _RestPageState();
}

Widget _title() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Opacity(
        opacity: 0.5,
        child: Text(
          '肌動GO',
          style: TextStyle(
            color: primaryColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      )
    ],
  );
}

Widget _secondLeftTitle() {
  return const Text(
    '剩餘秒數',
    style: TextStyle(
      color: primaryColor,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget _secondLeft(int timer) {
  return Text(
    timer.toString(),
    style: const TextStyle(
      color: primaryColor,
      fontSize: 42,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget _countNumberTitle() {
  return const Text(
    '休息時間',
    style: TextStyle(
      color: primaryColor,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget _warmUpGit() {
  return FadeInImage.assetNetwork(
    placeholder: 'assets/icon/rest.gif',
    image: 'https://c.tenor.com/-U7dV-vMdOEAAAAC/%E4%BC%91%E6%81%AF%E4%B8%80%E4%B8%8B-corgi.gif',
  );
}

Widget _endBtn(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    child: GestureDetector(
      onLongPress: () {
        _ss = 1;
        Navigator.pushReplacementNamed(context, Main.routeName);
      },
      child: const Text(
        '長按結束',
        style: TextStyle(
          color: primaryColor,
          fontSize: 20,
          decoration: TextDecoration.underline,
        ),
      ),
    ),
  );
}

class _RestPageState extends State<RestPage> {
  final int _timer = 60;

  @override
  void initState() {
    super.initState();
    _setTimerEvent();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.width / 6),
              _title(),
              const SizedBox(height: 20),
              _countNumberTitle(),
              const SizedBox(height: 30),
              _warmUpGit(),
              const SizedBox(height: 30),
              _secondLeftTitle(),
              const SizedBox(height: 30),
              _secondLeft(_displayTimer),
              const SizedBox(height: 35),
              _endBtn(context),
            ],
          ),
        ],
      ),
    );
  }

  var period = const Duration(seconds: 1);

  ///設定倒數計時器
  void _setTimerEvent() {
    Timer.periodic(period, (timer) async {
      _displayTimer = _timer - timer.tick;
      setState(() {
        _displayTimer;
      });
      if (_displayTimer == 0) {
        timer.cancel();
        Navigator.pushReplacementNamed(context, TrainingPage.routeName);
      }
      if (_ss == 1) {
        timer.cancel();
        _ss = 0;
      }
    });
  }
}
