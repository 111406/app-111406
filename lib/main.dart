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
  var _isAdded = false;
  var _displayAngle = 0;

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
              const Text('當前角度'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('$_displayAngle°'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 16)),
                    onPressed: () {
                      setState(() {
                        _mode = "three";
                      });
                    },
                    child: const Text('三角肌群'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 16)),
                    onPressed: () {
                      setState(() {
                        _mode = "two";
                      });
                    },
                    child: const Text('二頭肌群'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 16)),
                    onPressed: () {
                      setState(() {
                        _mode = "slide";
                      });
                    },
                    child: const Text('滑牆運動'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void calcAngles(double accelX, double accelY, double accelZ) {
    var deltaP = 0, deltaR = 0;
    var pitch =
        (180 * atan2(accelX, sqrt(accelY * accelY + accelZ * accelZ)) / pi)
            .round();
    var roll =
        (180 * atan2(accelY, sqrt(accelX * accelX + accelZ * accelZ)) / pi)
            .round();

    if (_mode == "three") {
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

      _angleP = pitch.round();

      if (_deltaSum > 25 && deltaP < 20) {
        _times += 1;
        _deltaSum = 0;
        _isAdded = true;
      }

      debugPrint("pitch: $pitch");
      debugPrint("deltaP: $deltaP");
      debugPrint("_deltaSum: $_deltaSum");
      debugPrint("_isAdded: $_isAdded");
    } else if (_mode == "two") {
      _displayAngle = roll;
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
    } else if (_mode == "slide") {
      _displayAngle = roll;
      deltaR = roll - _angleR;

      if (deltaR >= -5) {
        deltaR = deltaR >= 0 ? deltaR : 0;
        _deltaSum += deltaR;
        deltaR = 0;
      } else {
        _deltaSum = 0;
      }

      _angleR = roll.round();

      if (_deltaSum > 75) {
        _times += 1;
        _deltaSum = 0;
      }
    }
    }
  }
}
