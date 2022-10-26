///熱身頁

import 'dart:async';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';
import 'package:motion_sensors/motion_sensors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/model/chart_data.dart';
import 'package:sport_app/screen/intro/prepare/prepare.dart';
import 'package:sport_app/screen/main_page.dart';
import 'package:sport_app/screen/training/trainingpage.dart';
import 'package:sport_app/theme/color.dart';

var _timerStart = false;
var _displayTimer = 60;
late Timer timer;

class WarmupPage extends StatefulWidget {
  const WarmupPage({Key? key}) : super(key: key);
  static const String routeName = "/warm";

  @override
  State<WarmupPage> createState() => _WarmupPageState();
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
    '暖身時間',
    style: TextStyle(
      color: primaryColor,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget _warmUpGit() {
  return FadeInImage.assetNetwork(
    placeholder: 'assets/icon/warmup.gif',
    image:
        'https://www.heyueptc.com/heyueptc/6-education/edu_stretch/edu_sports_warm_up/_imagecache/edu_sports%20warm%20up%2003.gif',
  );
}

Widget _endBtn(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    child: GestureDetector(
      onLongPress: () =>
          Navigator.pushReplacementNamed(context, Main.routeName),
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

class _WarmupPageState extends State<WarmupPage> {
  FlutterTts flutterTts = FlutterTts();
  var displayAngle = 0, _startTime = 0;
  final List<ChartData> _angleList = [];
  late final int tobeMinused = 60;

  @override
  void initState() {
    super.initState();
    _setTimerEvent();
  }

  @override
  void dispose() {
    timer.cancel();
    _displayTimer = 60;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setUpdateInterval(Duration.microsecondsPerSecond ~/ 60);
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

  ///設置加速度器更新時間
  void setUpdateInterval(int interval) {
    motionSensors.accelerometerUpdateInterval = interval;
    setState(() {
      if (_timerStart) {
        int now = DateTime.now().millisecondsSinceEpoch;
        double sec = (now - _startTime) / 1000;
        var data = ChartData(sec, displayAngle);
        _angleList.add(data);
      }
    });
  }

  var period = const Duration(seconds: 1);

  ///設定倒數計時器
  void _setTimerEvent() {
    _timerStart = true;
    _startTime = DateTime.now().millisecondsSinceEpoch;
    timer = Timer.periodic(period, (_timer) async {
      setState(() {
        _displayTimer = tobeMinused - _timer.tick;
      });
      if (_displayTimer == 0) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        int? part = prefs.getInt("trainingPart");
        _timer.cancel();
        _timerStart = false;
        if (part != null) {
          Navigator.pushReplacementNamed(context, TrainingPage.routeName);
        } else {
          Navigator.pushReplacementNamed(context, Prepare.routeName);
        }
      }
    });
  }
}
