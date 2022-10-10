import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';
import 'package:motion_sensors/motion_sensors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/enum/training_part.dart';
import 'package:sport_app/model/user_todo.dart';
import 'package:sport_app/screen/main_page.dart';
import 'package:sport_app/screen/restpage.dart';
import 'package:sport_app/theme/color.dart';
import 'package:sport_app/utils/alertdialog.dart';
import 'package:sport_app/utils/http_request.dart';

///訓練頁
class TrainingPage extends StatefulWidget {
  const TrainingPage({Key? key}) : super(key: key);
  static const String routeName = "/training";

  @override
  State<TrainingPage> createState() => _TrainingPageState();
}

Widget _title() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Opacity(
        opacity: 0.5,
        child: Text(
          '肌動GO',
          style: TextStyle(color: primaryColor, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      )
    ],
  );
}

Widget _setLeftTitle() {
  return const Text(
    '剩餘組數',
    style: TextStyle(color: primaryColor, fontSize: 32, fontWeight: FontWeight.bold),
  );
}

Widget _setLeft(int sets) {
  return Text(
    sets.toString(),
    style: const TextStyle(color: primaryColor, fontSize: 42, fontWeight: FontWeight.bold),
  );
}

Widget _countNumberTitle() {
  return const Text(
    '剩餘次數',
    style: TextStyle(color: primaryColor, fontSize: 32, fontWeight: FontWeight.bold),
  );
}

Widget _countNumber(remainingNum) {
  return Text(
    remainingNum.toString(),
    style: const TextStyle(
      color: primaryColor,
      fontSize: 72,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget _endBtn(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    child: GestureDetector(
      onLongPress: () {
        Navigator.pushReplacementNamed(context, Main.routeName);
      },
      child: const Text(
        '長按結束',
        style: TextStyle(color: primaryColor, fontSize: 20, decoration: TextDecoration.underline),
      ),
    ),
  );
}

class _TrainingPageState extends State<TrainingPage> {
  var angle = 0, checkAddNum = 0.0, totalTimes = 0;
  FlutterTts flutterTts = FlutterTts();
  late TrainingPart part;
  late int remainingNum;
  late String targetDate;
  late int todoSet;
  late StreamSubscription<AccelerometerEvent> subscription;

  @override
  void initState() {
    super.initState();
    remainingNum = 15;
    todoSet = 1;
    _loadStates();
    subscription = motionSensors.accelerometer.listen((AccelerometerEvent event) {
      setState(() {
        _calcAngles(event.x, event.y, event.z);
      });
    });
  }

  Future<void> _loadStates() async {
    final prefs = await SharedPreferences.getInstance();
    todoSet = prefs.getInt("set")!;
    totalTimes = prefs.getInt("total")!;
    remainingNum = prefs.getInt("times")!;
    final partValue = prefs.getInt("trainingPart")!;
    part = TrainingPart.parse(partValue);
    setState(() {});
  }

  ///計算roll, pitch角度
  void _calcAngles(double accelX, double accelY, double accelZ) {
    var pitch = (180 * atan2(accelX, sqrt(accelY * accelY + accelZ * accelZ)) / pi).floor();
    var roll = (180 * atan2(accelY, sqrt(accelX * accelX + accelZ * accelZ)) / pi).floor();

    _checkPart(part, pitch, roll);
  }

  ///區分訓練部位
  void _checkPart(TrainingPart part, int pitch, int roll) {
    bool isMinAngle = false, isMaxAngle = false;

    // TODO 調整角度
    switch (part) {
      case TrainingPart.biceps:
        angle = roll;
        isMinAngle = roll < 5;
        isMaxAngle = roll > 60;

        break;
      case TrainingPart.deltoid:
        angle = pitch;
        isMinAngle = pitch < 10;
        isMaxAngle = pitch > 75;

        break;
      case TrainingPart.quadriceps:
        roll += 90;
        angle = roll;
        isMinAngle = roll < 65;
        isMaxAngle = roll > 87;

        break;
    }
    _addTimes(angle, isMinAngle, isMaxAngle);
  }

  ///判斷是否符合增加次數條件
  void _addTimes(int roll, bool isMin, bool isMax) {
    if (checkAddNum == 0 && isMin) checkAddNum += .5;

    if (checkAddNum == 0.5 && isMax) checkAddNum += .5;

    if (checkAddNum == 1) {
      remainingNum -= 1;
      _s();
      checkAddNum = 0.0;
    }

    if (remainingNum <= 0) {
      subscription.cancel();
      checkTrainingComplete();
    }
  }

  ///設置加速度器更新時間
  void setUpdateInterval(int interval) {
    motionSensors.accelerometerUpdateInterval = interval;
  }

  ///文字轉語音
  Future _s() async {
    await flutterTts.speak('$remainingNum');
  }

  void checkTrainingComplete() async {
    todoSet -= 1;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (todoSet > 0) {
      prefs.setInt("set", todoSet);
      Navigator.pushReplacementNamed(context, RestPage.routeName);
    } else {
      showAlertDialog(context, message: "恭喜您已完成本次訓練！").then((value) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String hand = prefs.getString("trainingHand") ?? "";
        String userId = prefs.getString("userId")!;
        UserTodo todo = UserTodo.fromJson(jsonDecode(prefs.getString("userTodo")!));
        String targetDate = todo.targetDate;
        Map<String, dynamic> requestData = {"part": part.value, "times": totalTimes};
        if (hand != "") {
          requestData["hand"] = hand;
        }
        
        await HttpRequest.post("${HttpURL.host}/target/$userId/$targetDate", jsonEncode(requestData));
        prefs.remove("times");
        prefs.remove("set");
        prefs.remove("total");
        prefs.remove("trainingPart");
        prefs.remove("trainingHand");
        Navigator.pushReplacementNamed(context, Main.routeName);
      });
    }
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
              _title(),
              const SizedBox(height: 25),
              _setLeftTitle(),
              const SizedBox(height: 30),
              _setLeft(todoSet),
              const SizedBox(height: 60),
              // _targetNumberTitle(),
              // _targetNumber(),
              const SizedBox(height: 60),
              _countNumberTitle(),
              _countNumber(remainingNum),
              const SizedBox(height: 60),
              _endBtn(context),
            ],
          ),
        ],
      ),
    );
  }
}
