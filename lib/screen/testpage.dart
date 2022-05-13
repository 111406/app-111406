import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:motion_sensors/motion_sensors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/db/model/chart_data.dart';
import 'package:sport_app/enum/training_part.dart';
import 'package:sport_app/utils/http_request.dart';

int _part = 0, _type = 0;

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);
  static const String routeName = "/test";
  @override
  State<TestPage> createState() => _TestPageState();
}

Widget _Title() {
  Color primaryColor = HexColor("7C9C99");

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
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
  Color primaryColor = HexColor("7C9C99");
  return Text(
    '剩餘秒數',
    style: TextStyle(
        color: primaryColor, fontSize: 32, fontWeight: FontWeight.bold),
  );
}

Widget _SecondLeft(int timer) {
  Color primaryColor = HexColor("7C9C99");
  return Text(
    timer.toString(),
    style: TextStyle(
        color: primaryColor, fontSize: 42, fontWeight: FontWeight.bold),
  );
}

Widget _CountNumberTitle() {
  Color primaryColor = HexColor("7C9C99");
  return Text(
    '次數',
    style: TextStyle(
        color: primaryColor, fontSize: 32, fontWeight: FontWeight.bold),
  );
}

Widget _CountNumber(int times) {
  Color primaryColor = HexColor("7C9C99");
  return Text(
    '$times次',
    style: TextStyle(
        color: primaryColor, fontSize: 72, fontWeight: FontWeight.bold),
  );
}

Widget _Angle(int displayAngle) {
  Color primaryColor = HexColor("7C9C99");
  return Text(
    '$displayAngle°',
    style: TextStyle(
        color: primaryColor, fontSize: 42, fontWeight: FontWeight.bold),
  );
}

Widget _AngleTitle() {
  Color primaryColor = HexColor("7C9C99");
  return Text(
    '角度',
    style: TextStyle(
        color: primaryColor, fontSize: 32, fontWeight: FontWeight.bold),
  );
}

Widget _EndBtn() {
  Color primaryColor = HexColor("7C9C99");
  return Container(
    alignment: Alignment.center,
    child: GestureDetector(
      onLongPress: () {},
      child: Text(
        '長按結束',
        style: TextStyle(
            color: primaryColor,
            fontSize: 20,
            decoration: TextDecoration.underline),
      ),
    ),
  );
}

class _TestPageState extends State<TestPage> {
  Color primaryColor = HexColor("7C9C99");
  FlutterTts flutterTts = FlutterTts();
  var _angleP = 0,
      _angleR = 0,
      _deltaSum = 0,
      _times = 0,
      _isAdded = false,
      _displayAngle = 0,
      _timer = 30,
      _timerStart = false,
      _startTime = 0;
  final List<ChartData> _angleList = [];

  @override
  void initState() {
    super.initState();
    _loadPrefs();
    motionSensors.accelerometer.listen((AccelerometerEvent event) {
      setState(() {
        calcAngles(event.x, event.y, event.z);
      });
    });
    setTimerEvent();
  }

  @override
  Widget build(BuildContext context) {
    setUpdateInterval(Duration.microsecondsPerSecond ~/ 60);
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width / 6,
              ),
              _Title(),
              SizedBox(
                height: 25,
              ),
              _SecondLeftTitle(),
              SizedBox(
                height: 30,
              ),
              _SecondLeft(_timer),
              SizedBox(
                height: 60,
              ),
              _CountNumberTitle(),
              _CountNumber(_times),
              SizedBox(
                height: 60,
              ),
              _Angle(_displayAngle),
              _AngleTitle(),
              SizedBox(
                height: 50,
              ),
              _EndBtn(),
            ],
          ),
        ],
      ),
    );
  }

  void _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _part = (prefs.getInt("part") ?? 0);
    _type = (prefs.getInt("type") ?? 0);
  }

  void calcAngles(double accelX, double accelY, double accelZ) {
    var deltaP = 0, deltaR = 0;
    var pitch =
        (180 * atan2(accelX, sqrt(accelY * accelY + accelZ * accelZ)) / pi)
            .floor();
    var roll =
        (180 * atan2(accelY, sqrt(accelX * accelX + accelZ * accelZ)) / pi)
            .floor();
    TrainingPart? part = TrainingPart.parse(_part);

    switch (part) {
      case TrainingPart.biceps:
        _displayAngle = roll;
        deltaR = roll - _angleR;

        if (deltaR >= 0) {
          _deltaSum += deltaR;
          deltaR = 0;
        } else {
          _deltaSum = 0;
        }

        _angleR = roll.floor();

        if (_deltaSum > 55) {
          _times += 1;
          _s();
          _deltaSum = 0;
        }
        break;
      case TrainingPart.deltoid:
        _displayAngle = pitch;
        deltaP = pitch - _angleP;

        if (deltaP <= 0) {
          _deltaSum = 0;
          _isAdded = false;
        }

        if (!_isAdded) {
          if (deltaP >= 0) {
            _deltaSum += deltaP;
            deltaP = 0;
          }
        }

        _angleP = pitch.floor();

        if (_deltaSum > 25 && deltaP < 20) {
          _times += 1;
          _s();
          _deltaSum = 0;
          _isAdded = true;
        }
        break;
      case TrainingPart.quadriceps:
        _displayAngle = roll;
        deltaR = roll - _angleR;

        if (deltaR >= -5) {
          deltaR = deltaR >= 0 ? deltaR : 0;
          _deltaSum += deltaR;
          deltaR = 0;
        } else {
          _deltaSum = 0;
        }

        _angleR = roll.floor();

        if (_deltaSum > 75) {
          _times += 1;
          _s();
          _deltaSum = 0;
        }
        break;
    }

    if (_timerStart) {
      int now = DateTime.now().millisecondsSinceEpoch;
      double sec = (now - _startTime) / 1000;
      var data = ChartData(sec, _displayAngle);
      _angleList.add(data);
    }
  }

  Future _s() async {
    await flutterTts.speak('$_times');
  }

  void setUpdateInterval(int interval) {
    motionSensors.accelerometerUpdateInterval = interval;
    setState(() {});
  }

  var period = const Duration(seconds: 1);

  void setTimerEvent() {
    _timerStart = true;
    _startTime = DateTime.now().millisecondsSinceEpoch;
    Timer.periodic(period, (timer) async {
      if (_timer < 1) {
        timer.cancel();
        _timerStart = false;
        String reqeustData = """
            {
              "user_id": "zsda5858sda",
              "part": $_part,
              "type": $_type,
              "times": "$_times",
              "angles": ${jsonEncode(_angleList)}
            }
        """;
        await HttpRequest().post("${HttpURL.host}/api/record", reqeustData);
      } else {
        _timer--;
      }
      setState(() {});
    });
  }
}
