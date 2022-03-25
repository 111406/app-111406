import 'dart:math';

import 'package:flutter/material.dart';
import 'package:motion_sensors/motion_sensors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _angleP = 0;
  var _angleR = 0;
  var _deltaSum = 0;
  var _times = 0;
  var _mode = "three";
  var _btnText = "二頭";
  var _isAdded = false;

  @override
  void initState() {
    super.initState();
    motionSensors.accelerometer.listen((AccelerometerEvent event) {
      setState(() {
        calcAngles(event.x, event.y, event.z);
      });
    });
  }

  void setUpdateInterval(int interval) {
    motionSensors.accelerometerUpdateInterval = interval;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    setUpdateInterval(Duration.microsecondsPerSecond ~/ 60);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Motion Sensors'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('運動次數'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('$_times次'),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20)),
                onPressed: () {
                  if (_mode == "three") {
                    setState(() {
                      _mode = "two";
                      _btnText = "三角";
                    });
                  } else {
                    setState(() {
                      _mode = "three";
                      _btnText = "二頭";
                    });
                  }
                  setState(() {
                    _times = 0;
                  });
                },
                child: Text('切換測量$_btnText肌群'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void calcAngles(double accelX, double accelY, double accelZ) {
    var deltaP = 0, deltaR = 0, pitch = 0, roll = 0;

    if (_mode == "three") {
      pitch =
          (180 * atan2(accelX, sqrt(accelY * accelY + accelZ * accelZ)) / pi)
              .round();

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

      _angleP = pitch.round();

      if (_deltaSum > 25 && deltaP < 20) {
        debugPrint(
            "---------------------------------------------------次數加一---------------------------------------------------現在次數: $_times");
        _times += 1;
        _deltaSum = 0;
        _isAdded = true;
      }

      debugPrint("pitch: $pitch");
      debugPrint("deltaP: $deltaP");
      debugPrint("_deltaSum: $_deltaSum");
      debugPrint("_isAdded: $_isAdded");
    } else {
      roll = (180 * atan2(accelY, sqrt(accelX * accelX + accelZ * accelZ)) / pi)
          .round();

      deltaR = roll - _angleR;

      if (deltaR >= 0) {
        _deltaSum += deltaR;
        deltaR = 0;
      } else {
        _deltaSum = 0;
      }

      _angleR = roll.round();

      if (_deltaSum > 55) {
        _times += 1;
        _deltaSum = 0;
      }
    }
  }
}
