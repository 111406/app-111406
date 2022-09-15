import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';
import 'package:motion_sensors/motion_sensors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_app/db/model/chart_data.dart';
import 'package:sport_app/enum/training_part.dart';
import 'package:sport_app/screen/loadingpage.dart';
import 'package:sport_app/screen/main_page.dart';
import 'package:sport_app/screen/trainingresultpage.dart';
import 'package:sport_app/screen/restpage.dart';
import 'package:sport_app/screen/trainingresultpage.dart';
import 'package:sport_app/theme/color.dart';
import 'package:sport_app/utils/http_request.dart';

int _part = 0, _type = 0;

var _startTime = 0, _displayTimer = 30;
var a = '剩餘次數';

class TrainingPage extends StatefulWidget {
  const TrainingPage({Key? key}) : super(key: key);
  static const String routeName = "/training";

  @override
  State<TrainingPage> createState() => _TrainingPageState();
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

Widget _SetLeftTitle() {
  return const Text(
    '剩餘組數',
    style: TextStyle(
        color: primaryColor, fontSize: 32, fontWeight: FontWeight.bold),
  );
}

Widget _SetLeft(int sets) {
  return Text(
    sets.toString(),
    style: const TextStyle(
        color: primaryColor, fontSize: 42, fontWeight: FontWeight.bold),
  );
}

Widget _CountNumberTitle() {
  return Text(
    '剩餘次數',
    style: TextStyle(
        color: primaryColor, fontSize: 32, fontWeight: FontWeight.bold),
  );
}

Widget _CountNumber(int times) {
  return Text(
    '$times',
    style: const TextStyle(
        color: primaryColor, fontSize: 72, fontWeight: FontWeight.bold),
  );
}

Widget _EndBtn(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    child: GestureDetector(
      onLongPress: () {
        Navigator.pushReplacementNamed(context, Main.routeName);
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

class _TrainingPageState extends State<TrainingPage> {
  FlutterTts flutterTts = FlutterTts();
  var _displayAngle = 0,
      _displayTimer = 30,
      _timerStart = false,
      _startTime = 0,
      _checkAddNum = 0.0;
  final List<ChartData> _angleList = [];
  final int _timer = 30;

  late StreamSubscription<AccelerometerEvent> subscription;
  var _times = 1, _sets = 2, _settimes = 1, _doset = 0;
  @override
  initState() {
    super.initState();
    _loadPrefs();
    subscription =
        motionSensors.accelerometer.listen((AccelerometerEvent event) {
      setState(() {
        _calcAngles(event.x, event.y, event.z);
      });
    });
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
              const SizedBox(height: 25),
              _SetLeftTitle(),
              const SizedBox(height: 30),
              _SetLeft(_sets - _doset),
              const SizedBox(height: 60),
              _CountNumberTitle(),
              _CountNumber(_times),
              const SizedBox(height: 60),
              // _Angle(_displayAngle),
              // _AngleTitle(),
              const SizedBox(height: 50),
              _EndBtn(context),
            ],
          ),
        ],
      ),
    );
  }

  // void _loadPrefs() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   _sets = prefs.getInt("set") ?? 2;
  //   _times = prefs.getInt("settimes") ?? 1;
  // }

  ///計算roll, pitch角度
  void _calcAngles(double accelX, double accelY, double accelZ) {
    var pitch =
        (180 * atan2(accelX, sqrt(accelY * accelY + accelZ * accelZ)) / pi)
            .floor();
    var roll =
        (180 * atan2(accelY, sqrt(accelX * accelX + accelZ * accelZ)) / pi)
            .floor();

    //可能需要例外處理
    TrainingPart? part = TrainingPart.parse(_part);

    _checkPart(part!, pitch, roll);
  }

  ///區分訓練部位
  void _checkPart(TrainingPart part, int pitch, int roll) {
    bool isMinAngle = false, isMaxAngle = false;
    _displayAngle = roll;
    isMinAngle = roll < 5;
    isMaxAngle = roll > 60;

    //     break;
    //   case TrainingPart.deltoid:
    //     _displayAngle = pitch;
    //     isMinAngle = pitch < 10;
    //     isMaxAngle = pitch > 75;

    //     break;
    //   case TrainingPart.quadriceps:
    //     roll += 90;
    //     _displayAngle = roll;
    //     isMinAngle = roll < 65;
    //     isMaxAngle = roll > 87;

    //     break;
    // }
    _addTimes(_displayAngle, isMinAngle, isMaxAngle);
  }

  void setUpdateInterval(int interval) {
    motionSensors.accelerometerUpdateInterval = interval;
    setState(() {
      if (true) {
        int now = DateTime.now().millisecondsSinceEpoch;
        double sec = (now - _startTime) / 1000;
        var data = ChartData(sec, _displayAngle);
        _angleList.add(data);
      }
    });
  }

  ///判斷是否符合增加次數條件
  void _addTimes(int roll, bool isMin, bool isMax) {
    if (_checkAddNum == 0 && isMin) _checkAddNum += .5;

    if (_checkAddNum == 0.5 && isMax) _checkAddNum += .5;
    if (_times > 0) {
      if (_checkAddNum == 1) {
        _times -= 1;
        _s(_times);
        _end(_times, _doset);
        _checkAddNum = 0.0;
      }
    }
  }

  ///文字轉語音
  Future _s(int times) async {
    await flutterTts.speak('$times');
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _doset = prefs.getInt("set") ?? 0;
    _times = prefs.getInt("settimes") ?? 1;
    await prefs.clear();
  }

  void _end(int times, sets) async {
    if (times == 0) {
      _doset = _doset + 1;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (_doset < _sets) {
        prefs.setInt("settimes", _settimes);
        prefs.setInt("set", _doset);
        Navigator.pushReplacementNamed(context, RestPage.routeName);
      } else {
        await prefs.clear();
        Navigator.pushReplacementNamed(context, TrainingResultPage.routeName);
      }
    }
  }

  ///設置加速度器更新時間
  // void setUpdateInterval(int interval) {
  //   motionSensors.accelerometerUpdateInterval = interval;
  //   setState(() {
  //     if (_timerStart) {
  //       int now = DateTime.now().millisecondsSinceEpoch;
  //       double sec = (now - _startTime) / 1000;
  //       var data = ChartData(sec, _displayAngle);
  //       _angleList.add(data);
  //     }
  //   });
  // }

  var period = const Duration(seconds: 1);

  ///設定倒數計時器
}

// import 'package:flutter/material.dart';
// import 'package:sport_app/theme/color.dart';

// class TrainingPage extends StatefulWidget {
//   const TrainingPage({Key? key}) : super(key: key);
//   static const String routeName = "/train";

//   @override
//   State<TrainingPage> createState() => _TrainingPageState();
// }

// Widget _title() {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: const [
//       Opacity(
//         opacity: 0.5,
//         child: Text(
//           '肌動GO',
//           style: TextStyle(
//             color: primaryColor,
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       )
//     ],
//   );
// }

// Widget _poseTitle() {
//   return const Text(
//     '二頭肌',
//     style: TextStyle(
//       color: primaryColor,
//       fontSize: 32,
//       fontWeight: FontWeight.bold,
//     ),
//   );
// }

// Widget _targetNumberTitle() {
//   return const Text(
//     '剩餘組數',
//     style: TextStyle(
//       color: primaryColor,
//       fontSize: 32,
//       fontWeight: FontWeight.bold,
//     ),
//   );
// }

// Widget _targetNumber() {
//   return const Text(
//     '2',
//     style: TextStyle(
//       color: primaryColor,
//       fontSize: 72,
//       fontWeight: FontWeight.bold,
//     ),
//   );
// }

// Widget _countNumberTitle() {
//   return const Text(
//     '剩餘次數',
//     style: TextStyle(
//       color: primaryColor,
//       fontSize: 32,
//       fontWeight: FontWeight.bold,
//     ),
//   );
// }

// Widget _countNumber() {
//   return const Text(
//     '13',
//     style: TextStyle(
//       color: primaryColor,
//       fontSize: 72,
//       fontWeight: FontWeight.bold,
//     ),
//   );
// }

// Widget _endBtn() {
//   return Container(
//     alignment: Alignment.center,
//     child: GestureDetector(
//       onLongPress: () {},
//       child: const Text(
//         '長按結束',
//         style: TextStyle(
//           color: primaryColor,
//           fontSize: 20,
//           decoration: TextDecoration.underline,
//         ),
//       ),
//     ),
//   );
// }

// class _TrainingPageState extends State<TrainingPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               SizedBox(height: MediaQuery.of(context).size.width / 6),
//               _title(),
//               const SizedBox(height: 25),
//               _poseTitle(),
//               const SizedBox(height: 60),
//               _targetNumberTitle(),
//               _targetNumber(),
//               const SizedBox(height: 60),
//               _countNumberTitle(),
//               _countNumber(),
//               const SizedBox(height: 60),
//               _endBtn(),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
