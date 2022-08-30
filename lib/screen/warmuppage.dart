import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';
import 'package:motion_sensors/motion_sensors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/db/model/chart_data.dart';
import 'package:sport_app/enum/training_part.dart';
import 'package:sport_app/screen/loadingpage.dart';
import 'package:sport_app/screen/mainpage.dart';
import 'package:sport_app/screen/prepare.dart';
import 'package:sport_app/screen/testpage.dart';
import 'package:sport_app/screen/testresultpage.dart';
import 'package:sport_app/theme/color.dart';
import 'package:sport_app/utils/http_request.dart';

class WarmupPage extends StatefulWidget {
  const WarmupPage({Key? key}) : super(key: key);
  static const String routeName = "/warm";

  @override
  State<WarmupPage> createState() => _WarmupPageState();
}

Widget _Title() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Opacity(
        opacity: 0.5,
        child: Text(
          '肌動GO',
          style: TextStyle(
              color: primaryColor, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      )
    ],
  );
}

Widget _SecondLeftTitle() {
  return const Text(
    '剩餘秒數',
    style: TextStyle(
        color: primaryColor, fontSize: 32, fontWeight: FontWeight.bold),
  );
}

Widget _SecondLeft(int timer) {
  return Text(
    timer.toString(),
    style: const TextStyle(
        color: primaryColor, fontSize: 42, fontWeight: FontWeight.bold),
  );
}

Widget _CountNumberTitle() {
  return const Text(
    '暖身時間',
    style: TextStyle(
        color: primaryColor, fontSize: 32, fontWeight: FontWeight.bold),
  );
}

Widget _WarmUpGit() {
  return Container(
    child: FadeInImage.assetNetwork(
      placeholder: 'assets/icon/warmup.gif',
      image:
          'https://www.heyueptc.com/heyueptc/6-education/edu_stretch/edu_sports_warm_up/_imagecache/edu_sports%20warm%20up%2003.gif',
    ),
  );
}

Widget _EndBtn(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    child: GestureDetector(
      onLongPress: () {
        Navigator.pushNamed(context, MainPage.routeName);
      },
      child: const Text(
        '長按結束',
        style: TextStyle(
            color: primaryColor,
            fontSize: 20,
            decoration: TextDecoration.underline),
      ),
    ),
  );
}

class _WarmupPageState extends State<WarmupPage> {
  FlutterTts flutterTts = FlutterTts();
  var _times = 0,
      _displayAngle = 0,
      _displayTimer = 60,
      _timerStart = false,
      _startTime = 0,
      _checkAddNum = 0.0;
  final List<ChartData> _angleList = [];
  final int _timer = 60;
  late StreamSubscription<AccelerometerEvent> subscription;
  @override
  @override
  void initState() {
    super.initState();
    _setTimerEvent();
  }

  @override
  void dispose() {
    subscription.cancel();
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
              _Title(),
              const SizedBox(height: 20),
              _CountNumberTitle(),
              const SizedBox(height: 30),
              _WarmUpGit(),
              const SizedBox(height: 30),
              _SecondLeftTitle(),
              const SizedBox(height: 30),
              _SecondLeft(_displayTimer),
              const SizedBox(height: 35),
              _EndBtn(context),
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
        var data = ChartData(sec, _displayAngle);
        _angleList.add(data);
      }
    });
  }

  var period = const Duration(seconds: 1);

  ///設定倒數計時器
  void _setTimerEvent() {
    _timerStart = true;
    _startTime = DateTime.now().millisecondsSinceEpoch;
    Timer.periodic(period, (timer) async {
      _displayTimer = _timer - timer.tick;
      setState(() {
        _displayTimer;
      });
      if (_displayTimer == 0) {
        timer.cancel();
        _timerStart = false;
        Navigator.pushNamed(context, Prepare.routeName);
        //測試資料
        // String reqeustData = """
        //     {
        //       "user_id": "zsda5858sda",
        //       "part": $_part,
        //       "type": $_type,
        //       "times": "$_times",
        //       "angles": ${jsonEncode(_angleList)}
        //     }
        // """;
        // dynamic response = await HttpRequest()
        //     .post("${HttpURL.host}/api/standard/analyze", """{
        //       "user_id": "zsda5858sda",
        //       "gender": 0,
        //       "part": $_part,
        //       "age": 100,
        //       "times": $_times
        //   }""");
      }
    });
  }
}
